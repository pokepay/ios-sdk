import Foundation

public struct PaginatedCoupons:Codable{
    public let perPage:Int
    public let count:Int
    public let next:String
    public let prev:String
    public let items:[Coupon]
    
    private enum CodingKeys: String, CodingKey {
        case perPage = "per_page"
        case count
        case next
        case prev
        case items
    }
}
