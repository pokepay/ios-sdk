import Foundation

public class Cypher {

    enum AESError : Error {
        case encryptFailed(String, Any)
        case decryptFailed(String, Any)
        case otherFailed(String, Any)
    }

    public class AES {

        /// 暗号
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

            // 暗号化後のデータのサイズを計算
            let cryptLength = size_t(Int(ceil(Double(data.count / kCCBlockSizeAES128)) + 1.0) * kCCBlockSizeAES128)

            var cryptData = Data(count:cryptLength)
            var numBytesEncrypted: size_t = 0

            // 暗号化
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

        /// 復号
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

            // 復号
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

            // パディングされていた文字数分のデータを捨てて文字列変換を行う
            guard let decryptedStr = String(data: clearData.prefix(numBytesEncrypted), encoding: .utf8) else {
                throw Cypher.AESError.decryptFailed("PKSC Unpad Failed", clearData)
            }
            return decryptedStr
        }

        public static func convertHexString(frombinary: Data) -> String {
            var rt = ""
            for byte in frombinary {
                rt.append(String(format: "%02X", byte))
            }
            return rt
        }

        /// ランダムIV生成
        public static func generateRandamIV() throws -> String {
            // CSPRNGから乱数取得
            var randData = Data(count: 8)
            let result = randData.withUnsafeMutableBytes {mutableBytes in
                SecRandomCopyBytes(kSecRandomDefault, 16, mutableBytes)
            }
            if result != errSecSuccess {
                // SecRandomCopyBytesに失敗(本来はあり得ない)
                throw Cypher.AESError.otherFailed("SecRandomCopyBytes Failed GenerateRandam IV", result)
            }
            // 16進数文字列化
            let ivStr = convertHexString(frombinary: randData)
            return ivStr
        }
    }
}
