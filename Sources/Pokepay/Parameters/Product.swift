import Foundation

public struct Product: Codable {

    public let janCode: String
    public let name: String
    public let price: Double
    public let unitPrice: Double
    public let isDiscounted: Bool
    public let other: String

    private enum CodingKeys: String, CodingKey {
        case janCode = "jan_code"
        case name
        case price
        case unitPrice = "unit_price"
        case isDiscounted = "is_discounted"
        case other
    }

    public static func create(
        janCodePrimary: String, name: String, price: Double, unitPrice: Double,
        isDiscounted: Bool = false, janCodeSecondary: String? = nil,
        amount: Double? = nil, amountUnit: String? = nil
    ) -> Product {
        var janCode: String = janCodePrimary
        if (janCodeSecondary != nil) {
            janCode = janCodePrimary + "___" + janCodeSecondary!
        }
        var otherDict: [String: Any] = [:]
        if amount != nil {
            otherDict["amount"] = amount!
        }
        if amountUnit != nil {
            otherDict["amount_unit"] = amountUnit!
        }
        let other = try! JSONSerialization.data(withJSONObject: otherDict)
        return Product(janCode: janCode, name: name, price: price, unitPrice: unitPrice, isDiscounted: isDiscounted, other: String(decoding: other, as: UTF8.self))
    }
    
}
