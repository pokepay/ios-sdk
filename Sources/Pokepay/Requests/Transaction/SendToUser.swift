import APIKit

struct SendToUserRequest: PokepayRequest {
    let userId: String
    let amount: Double
    let receiverTerminalId: String?
    let senderAccountId: String?
    let description: String?

    typealias Response = UserTransaction

    init(to userId: String, amount: Double, receiverTerminalId: String?, senderAccountId: String?, description: String?) {
        self.userId = userId
        self.amount = amount
        self.receiverTerminalId = receiverTerminalId
        self.senderAccountId = senderAccountId
        self.description = description
    }

    var method: HTTPMethod {
        return .post
    }

    var path: String {
        return "/users/\(userId)/transactions"
    }

    var parameters: Any? {
        var dict: [String: Any] = ["amount": amount]
        if receiverTerminalId != nil {
            dict["receiver_terminal_id"] = receiverTerminalId
        }
        if senderAccountId != nil {
            dict["sender_account_id"] = senderAccountId
        }
        if description != nil {
            dict["description"] = description
        }
        return dict
    }
}
