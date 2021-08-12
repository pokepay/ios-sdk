import Foundation
import CommonCrypto

public class Cypher {

    enum AESError : Error {
        case encryptFailed(String, Any)
        case decryptFailed(String, Any)
        case otherFailed(String, Any)
    }

    public class AES {

        public static func encrypt(plainString: String, sharedKey: String, iv: String) throws -> Data {
            guard let initializeVector = (iv.data(using: .utf8)) else {
                throw Cypher.AESError.otherFailed("Encrypt iv failed", iv)
            }
            guard let keyData = sharedKey.data(using: .utf8) else {
                throw Cypher.AESError.otherFailed("Encrypt sharedkey failed", sharedKey)
            }
            guard let plainData = plainString.data(using: .utf8) else {
                throw Cypher.AESError.otherFailed("Encrypt plainString failed", plainString)
            }

            let encryptedLength = size_t(Int(ceil(Double(plainData.count / kCCBlockSizeAES128)) + 1.0) * kCCBlockSizeAES128)
            var encryptedData   = Data(count:encryptedLength)
            var numBytesEncrypted: size_t = 0

            let cryptStatus = CCCrypt(CCOperation(kCCEncrypt),
                                      CCAlgorithm(kCCAlgorithmAES),
                                      CCOptions(kCCOptionPKCS7Padding),
                                      keyData.withUnsafeBytes { $0.baseAddress },
                                      keyData.count,
                                      initializeVector.withUnsafeBytes { $0.baseAddress },
                                      plainData.withUnsafeBytes { $0.baseAddress },
                                      plainData.count,
                                      encryptedData.withUnsafeMutableBytes { $0.baseAddress },
                                      encryptedData.count,
                                      &numBytesEncrypted)

            if cryptStatus != kCCSuccess {
                throw Cypher.AESError.encryptFailed("Encrypt Failed", cryptStatus)
            }
            return encryptedData
        }

        public static func decrypt(encryptedData: Data, sharedKey: String, iv: String) throws -> String {
            guard let initializeVector = (iv.data(using: .utf8)) else {
                throw Cypher.AESError.otherFailed("Decrypt iv failed", iv)
            }
            guard let keyData = sharedKey.data(using: .utf8) else {
                throw Cypher.AESError.otherFailed("Decrypt sharedKey failed", sharedKey)
            }

            let plainLength = size_t(encryptedData.count + kCCBlockSizeAES128)
            var plainData   = Data(count:plainLength)
            var numBytesDecrypted: size_t = 0

            let cryptStatus = CCCrypt(CCOperation(kCCDecrypt),
                                      CCAlgorithm(kCCAlgorithmAES),
                                      CCOptions(kCCOptionPKCS7Padding),
                                      keyData.withUnsafeBytes { $0.baseAddress },
                                      keyData.count,
                                      initializeVector.withUnsafeBytes { $0.baseAddress },
                                      encryptedData.withUnsafeBytes { $0.baseAddress },
                                      encryptedData.count,
                                      plainData.withUnsafeMutableBytes { $0.baseAddress },
                                      plainData.count,
                                      &numBytesDecrypted)

            if cryptStatus != kCCSuccess {
                throw Cypher.AESError.decryptFailed("Decrypt Failed", cryptStatus)
            }

            guard let decryptedString = String(data: plainData.prefix(numBytesDecrypted), encoding: .utf8) else {
                throw Cypher.AESError.decryptFailed("PKCS7 Unpadding Failed", plainData)
            }

            return decryptedString
        }
    }
}
