import Foundation

public class Cypher {

    enum AESError : Error {
        case encryptFailed(String, Any)
        case decryptFailed(String, Any)
        case otherFailed(String, Any)
    }

    public class AES {

        public static func encrypt(plainString: String, sharedKey: String, iv: String) throws -> Data {
            guard let initialzeVector = (iv.data(using: .utf8)) else {
                throw Cypher.AESError.otherFailed("Encrypt iv failed", iv)
            }
            guard let keyData = sharedKey.data(using: .utf8) else {
                throw Cypher.AESError.otherFailed("Encrypt sharedkey failed", sharedKey)
            }
            guard let data = plainString.data(using: .utf8) else {
                throw Cypher.AESError.otherFailed("Encrypt plainString failed", plainString)
            }

            let cryptLength = size_t(Int(ceil(Double(data.count / kCCBlockSizeAES128)) + 1.0) * kCCBlockSizeAES128)

            var cryptData = Data(count:cryptLength)
            var numBytesEncrypted: size_t = 0

            let cryptStatus = cryptData.withUnsafeMutableBytes {cryptBytes in
                initialzeVector.withUnsafeBytes {ivBytes in
                    data.withUnsafeBytes {dataBytes in
                        keyData.withUnsafeBytes {keyBytes in
                            CCCrypt(CCOperation(kCCEncrypt),
                                    CCAlgorithm(kCCAlgorithmAES),
                                    CCOptions(kCCOptionPKCS7Padding),
                                    keyBytes, keyData.count,
                                    ivBytes,
                                    dataBytes, data.count,
                                    cryptBytes, cryptLength,
                                    &numBytesEncrypted)
                        }
                    }
                }
            }

            if cryptStatus != kCCSuccess {
                throw Cypher.AESError.encryptFailed("Encrypt Failed", cryptStatus)
            }
            return cryptData
        }

        public static func decrypt(encryptedData: Data, sharedKey: String, iv: String) throws -> String {
            guard let initialzeVector = (iv.data(using: .utf8)) else {
                throw Cypher.AESError.otherFailed("Encrypt iv failed", iv)
            }
            guard let keyData = sharedKey.data(using: .utf8) else {
                throw Cypher.AESError.otherFailed("Encrypt sharedKey failed", sharedKey)
            }

            let clearLength = size_t(encryptedData.count + kCCBlockSizeAES128)
            var clearData   = Data(count:clearLength)

            var numBytesEncrypted :size_t = 0

            let cryptStatus = clearData.withUnsafeMutableBytes {clearBytes in
                initialzeVector.withUnsafeBytes {ivBytes in
                    encryptedData.withUnsafeBytes {dataBytes in
                        keyData.withUnsafeBytes {keyBytes in
                            CCCrypt(CCOperation(kCCDecrypt),
                                    CCAlgorithm(kCCAlgorithmAES),
                                    CCOptions(kCCOptionPKCS7Padding),
                                    keyBytes, keyData.count,
                                    ivBytes,
                                    dataBytes, encryptedData.count,
                                    clearBytes, clearLength,
                                    &numBytesEncrypted)
                        }
                    }
                }
            }

            if cryptStatus != kCCSuccess {
                throw Cypher.AESError.decryptFailed("Decrypt Failed", cryptStatus)
            }

            guard let decryptedStr = String(data: clearData.prefix(numBytesEncrypted), encoding: .utf8) else {
                throw Cypher.AESError.decryptFailed("PKSC Unpad Failed", clearData)
            }

            return decryptedStr
        }
    }
}
