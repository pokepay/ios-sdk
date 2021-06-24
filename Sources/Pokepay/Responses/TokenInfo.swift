public enum TokenType : String{
    case cashtray = "cashtray"
    case bill = "bill"
    case check = "check"
    case cpm = "cpm"
    case pokeregi = "pokeregi"
}

public struct TokenInfo : Codable{
    enum CodingKeys:String,CodingKey {
        case type = "Type"
        case info
    }
    var type:Int
    var info: String
    
    public init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(Int.self,forKey:.type)
        self.info = try container.decode(String.self, forKey:.info)
    }

    public func encode(to encoder :Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(self.type, forKey: .type)
            try container.encode(self.info, forKey: .info)
    }
}