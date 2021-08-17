import Foundation

public struct Coupon :Codable{
    public let id:String
    public let name:String
    public let description:String
    public let discountAmount:Int
    public let discountPercentage:Int
    public let startAt:Date
    public let endAt:Date
    public let displayStartAt:Date
    public let displayEndAt:Date
    public let usageLimit:Int
    public let minAmount:Int
    public let isShopSpecified:Bool
    public let isDisabled:Bool
    public let isHidden:Bool
    public let couponImage:String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case discountAmount = "discount_amount"
        case discountPercentage = "discount_percentage"
        case startAt = "starts_at"
        case endAt = "ends_at"
        case displayStartAt = "display_starts_at"
        case displayEndAt = "display_ends_at"
        case usageLimit = "usage_limit"
        case minAmount = "min_amount"
        case isShopSpecified = "is_shop_specified"
        case isDisabled = "is_disabled"
        case isHidden = "is_hidden"
        case couponImage = "coupon_image"
    }
}
