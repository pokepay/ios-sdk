import Foundation

public struct ServerKey: Codable{
    public let key:String
    
    private enum CodingKeys: String, CodingKey{
        case key = "server_key"
    }
}
