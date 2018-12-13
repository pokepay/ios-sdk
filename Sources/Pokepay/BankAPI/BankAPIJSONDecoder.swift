import Foundation

public class BankAPIJSONDecoder : JSONDecoder {
    override init() {
        super.init()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateDecodingStrategy = .formatted(dateFormatter)
    }
}
