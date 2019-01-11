import CoreBluetooth
import Result

public enum BLEError : Error {
    case peripheralIsGone
    case poweredOff
    case notSupported
    case discoveringError(Error)
    case readingError(Error)
    case writingError(Error)
    case dataEncryptionError(Error)
    case dataDecryptionError(Error)
}

class BLEController: NSObject {

    let kServiceUUIDPrefix = "3c46a55f-5890-0689-9025-e75f"
    let kIV = "F0EE1BC8016A6335"
    let kChunkSize = 500

    var aesKey: String!
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral!
    var serviceUUID : CBUUID!
    var tokenCharacteristicsOld : [CBCharacteristic] = []
    var tokenCharacteristic : CBCharacteristic!
    var tokenDataAccumulator : Data = Data.init()
    var responseCharacteristicOld : CBCharacteristic!
    var responseCharacteristic : CBCharacteristic!
    var responseDataSentCount : Int = 0;
    var oldProtocol : Bool = false
    var callback : (Result<String, BLEError>) -> Void = { _ in }
    var writeCallback: (Result<Void, BLEError>) -> Void = { _ in }

    private func getUUID(token: String) -> CBUUID
    {
        let deviceName = token.prefix(8)
        let uuidSuffix = (deviceName.unicodeScalars.map {
            ($0.value % 0x0F)
        }).map { String(format: "%x", $0) }.joined().prefix(7) + "0"
        let serviceUUID = kServiceUUIDPrefix + uuidSuffix;
        return CBUUID(string: serviceUUID)
    }

    private func getAESKey(token: String) -> String
    {
        return String(token.suffix(16))
    }

    public func scanToken(token: String, handler: @escaping (Result<String, BLEError>) -> Void = { _ in })
    {
        callback = handler
        centralManager = CBCentralManager(delegate: self, queue: nil)
        aesKey = getAESKey(token: token)
        serviceUUID = getUUID(token: token)
        tokenDataAccumulator = Data.init()
        responseDataSentCount = 0
    }

    private func writeResultOld(data: Data, handler: @escaping (Result<Void, BLEError>) -> Void = { _ in })
    {
        if peripheral != nil {
            writeCallback = handler
            peripheral.writeValue(data, for: self.responseCharacteristicOld, type: CBCharacteristicWriteType.withResponse)
        } else {
            handler(.failure(BLEError.peripheralIsGone))
        }
    }

    private func writeResultIter(data: Data, handler: @escaping (Result<Void, BLEError>) -> Void = { _ in })
    {
        let slice = data.subdata(in: responseDataSentCount ..< (responseDataSentCount + kChunkSize))
        if peripheral != nil {
            writeCallback = { result in
                switch result {
                case .failure(_):
                    handler(result)
                case .success(_):
                    if slice.count == 0 {
                        handler(result)
                    } else {
                        self.responseDataSentCount += slice.count
                        self.writeResultIter(data: data, handler: handler)
                    }
                }
            }
            peripheral.writeValue(slice, for: self.responseCharacteristic, type: CBCharacteristicWriteType.withResponse)
        } else {
            handler(.failure(BLEError.peripheralIsGone))
        }
    }

    public func writeResult(response: String, handler: @escaping (Result<Void, BLEError>) -> Void = { _ in })
    {
        do {
            let data = try Cypher.AES.encrypt(plainString: response, sharedKey: aesKey, iv: kIV)
            if oldProtocol {
                writeResultOld(data: data, handler: handler)
            } else {
                writeResultIter(data: data, handler: handler)
            }
        } catch let error {
            handler(.failure(BLEError.dataEncryptionError(error)))
        }

    }

    public func stop()
    {
        callback = { _ in }
        writeCallback = { _ in }
        if centralManager != nil {
            if centralManager.isScanning {
                centralManager!.stopScan()
            }
            if peripheral != nil {
                centralManager?.cancelPeripheralConnection(peripheral)
            }
        }
        tokenDataAccumulator = Data.init()
        responseDataSentCount = 0
    }
}

extension BLEController: CBCentralManagerDelegate {

    func centralManagerDidUpdateState(_ central: CBCentralManager)
    {
        switch central.state {
        case CBManagerState.poweredOn:
            let services: [CBUUID] = [serviceUUID]
            centralManager?.scanForPeripherals(withServices: services, options: nil)
        case CBManagerState.poweredOff:
            let err = BLEError.poweredOff
            callback(.failure(err))
            writeCallback(.failure(err))
        case CBManagerState.unsupported:
            let err = BLEError.notSupported
            callback(.failure(err))
            writeCallback(.failure(err))
        default:
            break
        }
    }

    func centralManager(_ central: CBCentralManager,
                        didDiscover peripheral: CBPeripheral,
                        advertisementData: [String : Any],
                        rssi RSSI: NSNumber)
    {
        self.peripheral = peripheral
        if centralManager.isScanning {
            centralManager?.stopScan()
        }
        central.connect(peripheral, options: nil)
    }

    func centralManager(_ central: CBCentralManager,
                        didConnect peripheral: CBPeripheral)
    {
        peripheral.delegate = self
        peripheral.discoverServices([serviceUUID])
    }
}

extension BLEController: CBPeripheralDelegate {

    // started service
    func peripheral(_ peripheral: CBPeripheral,
                    didDiscoverServices error: Error?)
    {
        if error != nil {
            callback(.failure(BLEError.discoveringError(error!)))
            return
        }
        peripheral.discoverCharacteristics(nil, for: (peripheral.services?.first)!)
    }

    // found Characteristics
    func peripheral(_ peripheral: CBPeripheral,
                    didDiscoverCharacteristicsFor service: CBService,
                    error: Error?)
    {
        if error != nil {
            callback(.failure(BLEError.discoveringError(error!)))
            return
        }
        service.characteristics?.forEach { (char) in
            let uuidString = char.uuid.uuidString;
            switch uuidString {
            case RegexCase(pattern: "^00[1][0-9A-Fa-f]$"):
                oldProtocol = true
                tokenCharacteristicsOld.append(char)
                peripheral.readValue(for: char)
            case RegexCase(pattern: "^0020$"):
                oldProtocol = false
                tokenCharacteristic = char
                peripheral.readValue(for: char)
            case RegexCase(pattern: "^0030$"):
                responseCharacteristicOld = char
            case RegexCase(pattern: "^0040$"):
                responseCharacteristic = char
            case RegexCase(pattern: "^0100$"):
                break
            default:
                break
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral,
                    didUpdateValueFor characteristic: CBCharacteristic,
                    error: Error?)
    {
        if error != nil {
            callback(.failure(BLEError.readingError(error!)))
            return
        }
        if oldProtocol {
            let allTokenRead = !(tokenCharacteristicsOld.contains { $0.value == nil })
            if (allTokenRead) {
                procTokenOld()
            }
        } else {
            let tokenRead = tokenCharacteristic.value != nil
            if (tokenRead) {
                procToken()
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral,
                    didWriteValueFor characteristic: CBCharacteristic,
                    error: Error?)
    {
        if error != nil {
            writeCallback(.failure(BLEError.writingError(error!)))
            return
        }
        writeCallback(.success(()))
    }

    private func procTokenOld() {
        do {
            let stringArray = try tokenCharacteristicsOld.sorted(by: { (lhs, rhs) -> Bool in
                lhs.uuid.uuidString < rhs.uuid.uuidString
            }).map { (char) -> String in
                if char.value == nil {
                    return ""
                }
                let data: Data = char.value!
                let plain = try Cypher.AES.decrypt(encryptedData: data, sharedKey: aesKey, iv: kIV)
                return plain
            }
            let jwt = stringArray.joined()
            callback(.success(jwt))
        } catch let error {
            callback(.failure(BLEError.dataDecryptionError(error)))
        }
    }

    private func procToken() {
        let data: Data = tokenCharacteristic.value!
        tokenDataAccumulator.append(data)
        if data.count < kChunkSize {
            do {
                let jwt = try Cypher.AES.decrypt(encryptedData: tokenDataAccumulator, sharedKey: aesKey, iv: kIV)
                callback(.success(jwt))
            } catch let error {
                callback(.failure(BLEError.dataDecryptionError(error)))
            }
        } else {
            if peripheral != nil {
                peripheral.readValue(for: tokenCharacteristic)
            } else {
                callback(.failure(BLEError.peripheralIsGone))
            }
        }
    }
}
