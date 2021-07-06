import Foundation

public class BankAPIJSONDecoder : JSONDecoder {
public let dateFormatter = DateFormatter()
    override public init() {
        super.init()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateDecodingStrategy = .formatted(dateFormatter)
    }
}
