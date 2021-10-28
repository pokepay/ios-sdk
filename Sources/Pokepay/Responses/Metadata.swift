import Foundation

public struct Metadata: Codable{
    public let key1: String
    
    private enum CodingKeys: String, CodingKey {
        case key1
    }
    
    public init(key1:String) {
        self.key1 = key1
    }
}
