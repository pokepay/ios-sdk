import Foundation

public class BankAPIJSONDecoder : JSONDecoder {

    public static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter
    }
    
    override init() {
        super.init()
        dateDecodingStrategy = .formatted(BankAPIJSONDecoder.dateFormatter)
    }
}
