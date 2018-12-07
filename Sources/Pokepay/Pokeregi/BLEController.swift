import CoreBluetooth
import Result

public enum BLEError : Error {
    case invalidStateError(String)
    case startingError(String)
    case discoveringError(Error)
    case readingError(Error)
    case writingError(Error)
    case dataEncryptionError(Error)
    case dataDecryptionError(Error)
}

class BLEController: NSObject {

    let kServiceUUIDPrefix = "3c46a55f-5890-0689-9025-e75f"
    let kIV = "F0EE1BC8016A6335"

    var aesKey: String!
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral!
    var serviceUUID : CBUUID!
    var tokenCharacteristics : [CBCharacteristic] = []
    var responseCharacteristic : CBCharacteristic!
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
    }

    public func writeResult(response: String, handler: @escaping (Result<Void, BLEError>) -> Void = { _ in })
    {
        do {
            let data = try Cypher.AES.encrypt(plainString: response, sharedKey: aesKey, iv: kIV)
            if peripheral != nil {
                writeCallback = handler
                peripheral.writeValue(data, for: self.responseCharacteristic, type: CBCharacteristicWriteType.withResponse)
            } else {
                handler(.failure(BLEError.invalidStateError("BLE peripheral is gone")))
            }
        } catch let error {
            handler(.failure(BLEError.dataEncryptionError(error)))
            return
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
            let err = BLEError.startingError("BLE powered off")
            callback(.failure(err))
            writeCallback(.failure(err))
        case CBManagerState.unsupported:
            let err = BLEError.startingError("BLE not supported")
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
            case RegexCase(pattern: "^00[12][0-9A-Fa-f]$"):
                tokenCharacteristics.append(char)
                peripheral.readValue(for: char)
            case RegexCase(pattern: "^00[34][0-9A-Fa-f]$"):
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
        let allTokenRead = !(tokenCharacteristics.contains { $0.value == nil })
        if (allTokenRead) {
            procToken()
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

    private func procToken() {
        do {
            let stringArray = try tokenCharacteristics.sorted(by: { (lhs, rhs) -> Bool in
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
}
