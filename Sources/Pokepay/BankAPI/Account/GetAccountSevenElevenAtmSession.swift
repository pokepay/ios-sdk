import APIKit

public extension BankAPI.Account {
    struct GetAccountSevenElevenAtmSession: BankRequest {
        public let qrInfo: String
        
        public typealias Response = SevenElevenAtmSession
        
        public init(qrInfo: String) {
            self.qrInfo = qrInfo
        }
        
        public var method: HTTPMethod {
            return .get
        }
        
        public var path: String {
            return "/seven-bank-atm-sessions/\(qrInfo)"
        }
    }
}

/*
 API Test Logs (Dev Env)
 
 $ curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer 8DZN-jCfqOTwKALYjWa2lYj7we8GYGTGi2UzT4cVERISl6qBIuNurDk4TMdqIUEU" https://api-dev.pokepay.jp/seven-bank-atm-sessions/91234567890123456789021 | jq .
 
 SevenElevenAtmSession(
   qrInfo: "91234567890123456789021", amount: 1000.0,
   account: Pokepay.Account(
     id: "fe2f16b9-a0f5-4b74-b322-57c6e6981606", name: "", balance: 167110.0, moneyBalance: 167100.0,
     pointBalance: 10.0, isSuspended: false,
     privateMoney: Pokepay.PrivateMoney(
       id: "4b138a4c-8944-4f98-a5c4-96d3c1c415eb", name: "コイルマネー", type: "third-party", unit: "マネー",
       description: "コイル市場で使えるマネーです", onelineMessage: "コイルのマネーです！🍣",
       accountImage: Optional(
         "https://pocketbank-assets.s3.amazonaws.com/development/private-money-account-image/coil_logo-860e776dd3514287ac606db990e031ff3f82348e.png"
       ),
       images: Pokepay.Images(
         card: Optional(
           "https://pocketbank-assets.s3.amazonaws.com/development/private-money-account-image/coil_logo-860e776dd3514287ac606db990e031ff3f82348e.png"
         ),
         res300: Optional(
           "https://pocketbank-assets.s3.amazonaws.com/development/private-money-image/coilinc_300x300-c5604d713a1a56f7109fd69188d7b58bfa301e56.png"
         ),
         res600: Optional(
           "https://pocketbank-assets.s3.amazonaws.com/development/private-money-image/coilinc_600x600-38ec4d2b705fcb7e6e8fab67e1b49203ee763aaa.png"
         )), organization: Pokepay.Organization(code: "coilinc", name: "コイル"), maxBalance: 300000.0,
       transferLimit: 10000.0, expirationType: "static", isExclusive: false,
       termsUrl: Optional("/private-moneys/4b138a4c-8944-4f98-a5c4-96d3c1c415eb/terms"),
       privacyPolicyUrl: Optional(
         "/private-moneys/4b138a4c-8944-4f98-a5c4-96d3c1c415eb/privacy-policy"),
       paymentActUrl: Optional("/private-moneys/4b138a4c-8944-4f98-a5c4-96d3c1c415eb/payment-act"),
       commercialActUrl: Optional(
         "/private-moneys/4b138a4c-8944-4f98-a5c4-96d3c1c415eb/commercial-act"),
       canUseCreditCard: Optional(true), customDomainName: nil), nearestExpiresAt: nil),
   transaction: nil)
 
 ----
 
 $ curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer 8DZN-jCfqOTwKALYjWa2lYj7we8GYGTGi2UzT4cVERISl6qBIuNurDk4TMdqIUEU" https://api-dev.pokepay.jp/seven-bank-atm-sessions/91234567820123456789021 | jq .
 
 SevenElevenAtmSession (
     qrInfo : "91234567820123456789021",
     amount : 1000.0,
     account : Pokepay.Account (
         id : "fe2f16b9-a0f5-4b74-b322-57c6e6981606",
         name : "",
         balance : 167110.0,
         moneyBalance : 167100.0,
         pointBalance : 10.0,
         isSuspended : false,
         privateMoney : Pokepay.PrivateMoney (
             id : "4b138a4c-8944-4f98-a5c4-96d3c1c415eb",
             name : "コイルマネー",
             type : "third-party",
             unit : "マネー",
             description : "コイル市場で使えるマネーです",
             onelineMessage : "コイルのマネーです！🍣",
             accountImage : Optional (
                 "https://pocketbank-assets.s3.amazonaws.com/development/private-money-account-image/coil_logo-860e776dd3514287ac606db990e031ff3f82348e.png"
             ),
             images : Pokepay.Images (
                 card : Optional (
                     "https://pocketbank-assets.s3.amazonaws.com/development/private-money-account-image/coil_logo-860e776dd3514287ac606db990e031ff3f82348e.png"
                 ),
                 res300 : Optional (
                     "https://pocketbank-assets.s3.amazonaws.com/development/private-money-image/coilinc_300x300-c5604d713a1a56f7109fd69188d7b58bfa301e56.png"
                 ),
                 res600 : Optional (
                     "https://pocketbank-assets.s3.amazonaws.com/development/private-money-image/coilinc_600x600-38ec4d2b705fcb7e6e8fab67e1b49203ee763aaa.png"
                 )
             ),
             organization : Pokepay.Organization (code: "coilinc", name: "コイル"),
             maxBalance : 300000.0,
             transferLimit : 10000.0,
             expirationType : "static",
             isExclusive : false,
             termsUrl : Optional (
                 "/private-moneys/4b138a4c-8944-4f98-a5c4-96d3c1c415eb/terms"
             ),
             privacyPolicyUrl : Optional (
                 "/private-moneys/4b138a4c-8944-4f98-a5c4-96d3c1c415eb/privacy-policy"
             ),
             paymentActUrl : Optional (
                 "/private-moneys/4b138a4c-8944-4f98-a5c4-96d3c1c415eb/payment-act"
             ),
             commercialActUrl : Optional (
                 "/private-moneys/4b138a4c-8944-4f98-a5c4-96d3c1c415eb/commercial-act"
             ),
             canUseCreditCard : Optional (true),
             customDomainName : nil
         ),
         nearestExpiresAt : nil
     ),
     transaction : Optional (
         Pokepay.UserTransaction (
             id : "19bafab8-151d-45f0-afce-5358956ca05a",
             type : "topup",
             isModified : false,
             user : Pokepay.User (
                 id : "55694dbd-582a-442f-80e1-a23e0f49b3cd",
                 name : "Pokepay",
                 isMerchant : true
             ),
             balance : 167110.0,
             customerBalance : nil,
             amount : 1000.0,
             moneyAmount : 1000.0,
             pointAmount : 0.0,
             account : Pokepay.Account (
                 id : "fe2f16b9-a0f5-4b74-b322-57c6e6981606",
                 name : "",
                 balance : 167110.0,
                 moneyBalance : 167100.0,
                 pointBalance : 10.0,
                 isSuspended : false,
                 privateMoney : Pokepay.PrivateMoney (
                     id : "4b138a4c-8944-4f98-a5c4-96d3c1c415eb",
                     name : "コイルマネー",
                     type : "third-party",
                     unit : "マネー",
                     description : "コイル市場で使えるマネーです",
                     onelineMessage : "コイルのマネーです！🍣",
                     accountImage : Optional (
                         "https://pocketbank-assets.s3.amazonaws.com/development/private-money-account-image/coil_logo-860e776dd3514287ac606db990e031ff3f82348e.png"
                     ),
                     images : Pokepay.Images (
                         card : Optional (
                             "https://pocketbank-assets.s3.amazonaws.com/development/private-money-account-image/coil_logo-860e776dd3514287ac606db990e031ff3f82348e.png"
                         ),
                         res300 : Optional (
                             "https://pocketbank-assets.s3.amazonaws.com/development/private-money-image/coilinc_300x300-c5604d713a1a56f7109fd69188d7b58bfa301e56.png"
                         ),
                         res600 : Optional (
                             "https://pocketbank-assets.s3.amazonaws.com/development/private-money-image/coilinc_600x600-38ec4d2b705fcb7e6e8fab67e1b49203ee763aaa.png"
                         )
                     ),
                     organization : Pokepay.Organization (code: "coilinc", name: "コイル"),
                     maxBalance : 300000.0,
                     transferLimit : 10000.0,
                     expirationType : "static",
                     isExclusive : false,
                     termsUrl : Optional (
                         "/private-moneys/4b138a4c-8944-4f98-a5c4-96d3c1c415eb/terms"
                     ),
                     privacyPolicyUrl : Optional (
                         "/private-moneys/4b138a4c-8944-4f98-a5c4-96d3c1c415eb/privacy-policy"
                     ),
                     paymentActUrl : Optional (
                         "/private-moneys/4b138a4c-8944-4f98-a5c4-96d3c1c415eb/payment-act"
                     ),
                     commercialActUrl : Optional (
                         "/private-moneys/4b138a4c-8944-4f98-a5c4-96d3c1c415eb/commercial-act"
                     ),
                     canUseCreditCard : Optional (true),
                     customDomainName : nil
                 ),
                 nearestExpiresAt : nil
             ),
             description : "seven atm topup!",
             doneAt : 2022-09-07 7 : 44 : 58 AM +0000,
             transfers : Optional ([])
         )
     )
 )

 */
