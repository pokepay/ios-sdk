import APIKit

struct SendToAccountRequest: PokepayRequest {
    let accountId: String
    let amount: Double
    let receiverTerminalId: String?
    let senderAccountId: String?
    let description: String?

    typealias Response = UserTransaction

    init(to accountId: String, amount: Double, receiverTerminalId: String?, senderAccountId: String?, description: String?) {
        self.accountId = accountId
        self.amount = amount
        self.receiverTerminalId = receiverTerminalId
        self.senderAccountId = senderAccountId
        self.description = description
    }

    var method: HTTPMethod {
        return .post
    }

    var path: String {
        return "/accounts/\(accountId)/transactions"
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
