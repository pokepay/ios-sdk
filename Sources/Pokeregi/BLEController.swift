import CoreBluetooth

class BLEController: NSObject {

    let kServiceUUIDPrefix = "3c46a55f-5890-0689-9025-e75f"
    let kIV = "F0EE1BC8016A6335"

    var aesKey: String!
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral!
    var serviceUUID : CBUUID!
    var tokenCharacteristics : [CBCharacteristic] = []
    var responseCharacteristic : CBCharacteristic!

    private func getUUID(qrData: String) -> CBUUID
    {
        let deviceName = qrData.prefix(8)
        let uuidSuffix = (deviceName.unicodeScalars.map {
            ($0.value % 0x0F)
        }).map { String(format: "%x", $0) }.joined().prefix(7) + "0"
        let serviceUUID = kServiceUUIDPrefix + uuidSuffix;
        return CBUUID(string: serviceUUID)
    }

    private func getAESKey(qrData: String) -> String
    {
        return String(qrData.suffix(16))
    }

    public func start(qrData: String)
    {
        centralManager = CBCentralManager(delegate: self, queue: nil)
        aesKey = getAESKey(qrData: qrData)
        serviceUUID = getUUID(qrData: qrData)
    }

}

extension BLEController: CBCentralManagerDelegate {

    func centralManagerDidUpdateState(_ central: CBCentralManager)
    {
        switch central.state {
        case CBManagerState.poweredOn:
            let services: [CBUUID] = [serviceUUID]
            centralManager?.scanForPeripherals(withServices: services, options: nil)
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
        centralManager?.stopScan()
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
                    didDiscoverServices error: Error?) {
        if error != nil {
            print(error.debugDescription)
            return
        }
        peripheral.discoverCharacteristics(nil, for: (peripheral.services?.first)!)
    }

    // found Characteristics
    func peripheral(_ peripheral: CBPeripheral,
                    didDiscoverCharacteristicsFor service: CBService,
                    error: Error?) {

        if error != nil {
            print(error.debugDescription)
            return
        }

        print("chars:", Array(service.characteristics!))
        service.characteristics?.forEach {
            let char = $0
            let uuidString = char.uuid.uuidString;
            switch uuidString {
            case RegexCase(pattern: "^00[12][0-9A-Fa-f]$"):
                print("token_char:", char)
                tokenCharacteristics.append(char)
                peripheral.readValue(for: char)
                break
            case RegexCase(pattern: "^00[34][0-9A-Fa-f]$"):
                print("response_char:", char)
                responseCharacteristic = char
                break
            case RegexCase(pattern: "^0100$"):
                print("time_stamp:", char)
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
            print(error.debugDescription)
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
            print(error.debugDescription)
            return
        }
        centralManager.cancelPeripheralConnection(peripheral)
    }

    private func procToken() {
        let stringArray = tokenCharacteristics.sorted(by: { (lhs, rhs) -> Bool in
            lhs.uuid.uuidString < rhs.uuid.uuidString
        }).map { (char) -> String in
            let data: Data = char.value!
            let plain = try! Cypher.AES.decrypt(encryptedData: data, sharedKey: aesKey, iv: kIV)
            return plain
        }
        let string = stringArray.joined()
        print("data:", string)
        APITransaction(jwt: string)
    }

    private func APITransaction(jwt: String)
    {
        let client = Pokepay.Client(
            accessToken: "ZhwMsfoAyWZMGrCAKrrofmwYHV82GkUcf3kYSZYYf1oDKVvFAPIKuefyQoc1KDVr",
            env: .development
        )
        client.send(BankAPI.Transaction.CreateWithJwt(data: jwt)) { result in
            switch result {
            case .success(let response):
                print("APITransaction succ:", response)
                let jwtResponse = response.data!
                let data = try! Cypher.AES.encrypt(plainString: jwtResponse, sharedKey: self.aesKey, iv: self.kIV)
                self.peripheral.writeValue(data, for: self.responseCharacteristic, type: CBCharacteristicWriteType.withResponse)
                break
            case .failure(let error):
                switch error {
                case .connectionError(let error):
                    let e = PokepayError.connectionError(error)
                    print(e)
                    break
                case .requestError(let error):
                    let e = PokepayError.requestError(error)
                    print(e)
                    break
                case .responseError(let error):
                    let e = PokepayError.responseError(error)
                    print(e)
                    break
                default:
                    break
                }
                let data = try! Cypher.AES.encrypt(plainString: "NG", sharedKey: self.aesKey, iv: self.kIV)
                self.peripheral.writeValue(data, for: self.responseCharacteristic, type: CBCharacteristicWriteType.withResponse)
            }
        }
    }
}
