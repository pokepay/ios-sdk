import XCTest
import APIKit
@testable import Pokepay

final class PokepayTests: XCTestCase {

    public let merchantAccessToken: String = "eYNDMo_cAqPgxMW3qlMv9968awTwFpiwi_rR8XrRhaO6zMOgMfem2q1wfnlluo-v"
    public let customerAccessToken: String = "S-WAIYRN6rVdb77rYGgMeRQgMLuQ2ZAM0Fo8HfocrrTWxH7tsehCkD6JJSjGhs-0"
    public let customerAccountId: String = "eb4e552b-4299-4e8f-ba8b-d738c96e1f60"
    public let pokepayMoneyId: String = "4b138a4c-8944-4f98-a5c4-96d3c1c415eb"

    func getProducts() -> [Product] {
        let products: [Product] = [
            Product.create(janCodePrimary: "4569951116179", name: "ハムスこくとろカレー140g", price: 150, unitPrice: 300, isDiscounted: false, amount: 2.0, amountUnit: "個"),
            Product.create(janCodePrimary: "4569951116179", name: "SCカレーの王様80g", price: 140, unitPrice: 160, isDiscounted: true),
            Product.create(janCodePrimary: "4569951116179", name: "牛肩ロースしゃぶしゃぶ用", price: 600, unitPrice: 200, isDiscounted: false, janCodeSecondary: "4569951116179", amount: 3.0, amountUnit: "100グラム"),
        ]
        return products
    }

    func testGetTerminal() {
        let expect = expectation(description: "get request test")
        let client = Pokepay.Client(accessToken: customerAccessToken, env: .development)
        client.getTerminalInfo() { result in
            switch result {
            case .success(let response):
                print(response)
                expect.fulfill()
            case .failure:
                print(result)
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testAddPublicKey() {
        let expect = expectation(description: "add public key request test")
        let client = Pokepay.Client(accessToken: customerAccessToken, env: .development)
        client.send(BankAPI.Terminal.AddPublicKey(key:
"""
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAq8oHIShTIJHrQpBQqAVs
JxjhstGMghotRq2QaU0PU7y4jR42AAWMHzjzTxQUjE/Id/ko5lwbFx+tco0NvJVR
vPulU82D0pMlfc0oXd2dJ+UWvw7Fpg0+lo2o4R7fMQxt91fKfktyOkga1rUJ3SDH
601jw43ptdAPgugMloD9uExkbNqXXKjzruksDssh7mvIIe33Yz/463VrcSOaLgBA
OSj+GhSx4PuQz8yUk/Jo0ebaaBPtf0imVkhsp8v4v8LvXhrqRy+k6V58gW4nJvu+
rUfw+waqKu5AJycsUD6C1zbaj7mTXUTRNyZegDJHV8wRuSa4kFSB5S5KIGflM9M4
AQIDAQAB
""")) { result in
            switch result {
            case .success(let response):
                print(response)
                expect.fulfill()
            case .failure(.responseError(let error as BankAPIError)):
                print("responseError")
                switch error {
                case .clientError(let code, let apiError):
                    print("code: \(code)")
                    print("type: \(apiError.type)")
                    print("message: \(apiError.message)")
                default:
                    print("other error")
                }
                expect.fulfill()
            case .failure:
                print(result)
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testCreateToken() {
        let expect = expectation(description: "create token test")
        let client = Pokepay.Client(accessToken: merchantAccessToken,
                                    isMerchant: true,
                                    env: .development)
        client.createToken(108) { result in
            switch result {
            case .success(let token):
                print(token)
                expect.fulfill()
            case .failure(let error):
                print(error)
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testClientGetTerminal() {
        let expect = expectation(description: "client.getTerminal")
        let client = Pokepay.Client(accessToken: merchantAccessToken,
                                    isMerchant: true,
                                    env: .development)
        client.getTerminalInfo() { result in
            switch result {
            case .success(let terminal):
                print(terminal)
                expect.fulfill()
            case .failure(let error):
                print(error)
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testGetTokenInfo() {
        let expect = expectation(description: "client.getTokenInfo")
        let client = Pokepay.Client(accessToken: merchantAccessToken,
                                    isMerchant: false,
                                    env: .development)
        let dispatchGroup = DispatchGroup()
        // check
        dispatchGroup.enter()
        client.createToken(108) { result in
            switch result {
            case .success(let token):
                print(token)
                client.getTokenInfo(token) { result in
                    switch result {
                    case .success(let tokeninfo):
                        switch tokeninfo{
                        case .check(_):
                            dispatchGroup.leave()
                        default:
                            print(tokeninfo)
                            XCTFail("Unexpected type")
                        }
                    case .failure(let error):
                        print(error)
                        XCTFail("Error on getTokenInfo")
                    }
                }
            case .failure(let error):
                print(error)
                XCTFail("Error on createToken 1")
            }
        }

        // bill
        dispatchGroup.enter()
        client.createToken(-108) { result in
            switch result {
            case .success(let token):
                print(token)
                client.getTokenInfo(token) { result in
                    switch result {
                    case .success(let tokeninfo):
                        switch tokeninfo {
                        case .bill(_):
                            dispatchGroup.leave()
                        default:
                            print(tokeninfo)
                            XCTFail("Unexpected type")
                        }
                    case .failure(let error):
                        print(error)
                        XCTFail("Error on getTokenInfo")
                    }
                }
            case .failure(let error):
                print(error)
                XCTFail("Error on createToken 2")
            }
        }

        let mclient = Pokepay.Client(accessToken: merchantAccessToken,
                                    isMerchant: true,
                                    env: .development)
        // cashtray
        dispatchGroup.enter()
        mclient.createToken(108) { result in
            switch result {
            case .success(let token):
                print(token)
                mclient.getTokenInfo(token) { result in
                    switch result {
                    case .success(let tokeninfo):
                        switch tokeninfo{
                        case .cashtray(_):
                            print(tokeninfo)
                            dispatchGroup.leave()
                        default:
                            print(tokeninfo)
                            XCTFail("Unexpected type")
                        }
                    case .failure(let error):
                        print(error)
                        XCTFail("Error on getTokenInfo")
                    }
                }
            case .failure(let error):
                print(error)
                XCTFail("Error on createToken 3")
            }
        }
        
        // get cashtray in lowlevel
        dispatchGroup.enter()
        mclient.createToken(108) { result in
            switch result {
            case .success(let token):
                print(token)
                mclient.getTokenInfo(token) { result in
                    switch result {
                    case .success(let tokeninfo):
                        switch tokeninfo{
                        case .cashtray(_):
                            let id = String(token.suffix(token.utf8.count - "\(mclient.wwwBaseURL)/cashtrays/".utf8.count))
                            // merchant can get cashtray
                            mclient.send(BankAPI.Cashtray.Get(id: id)) { result in
                                switch result {
                                    case .success(let data):
                                        print(data.privateMoney.id)
                                        dispatchGroup.leave()
                                    case .failure(let error):
                                        print(error)
                                        XCTFail("Get failed")
                                }
                            }
                        default:
                            print(tokeninfo)
                            XCTFail("Unexpected type")
                        }
                    case .failure(let error):
                        print(error)
                        XCTFail("Error on getTokenInfo")
                    }
                }
            case .failure(let error):
                print(error)
                XCTFail("Error on createToken 3")
            }
        }
        
        // pokeregi
        let v1_QR_Token = "A0B1C2D3E4F5G6H7I8J9K0L1M"
        dispatchGroup.enter()
        client.getTokenInfo(v1_QR_Token) { result in
        switch result {
            case .success(let tokeninfo):
                switch tokeninfo {
                case .pokeregi(_):
                    dispatchGroup.leave()
                default:
                    print(tokeninfo)
                    XCTFail("Unexpected type")
                }
            case .failure(let error):
                print(error)
                XCTFail("Error on getTokenInfo")
            }
        }
        
        let v1_NFC_Token = "https://www.pokepay.jp/pd?d=A0B1C2D3E4F5G6H7I8J9K0L1M"
        dispatchGroup.enter()
        client.getTokenInfo(v1_NFC_Token) { result in
        switch result {
            case .success(let tokeninfo):
                switch tokeninfo{
                case .pokeregi(_):
                    dispatchGroup.leave()
                default:
                    print(tokeninfo)
                    XCTFail("Unexpected type")
                }
            case .failure(let error):
                print(error)
                XCTFail("Error on getTokenInfo")
            }
        }
        
        let v2_QR_NFC_Token = "https://www.pokepay.jp/pd/A0B1C2D3E4F5G6H7I8J9K0L1M"
        dispatchGroup.enter()
        client.getTokenInfo(v2_QR_NFC_Token) { result in
        switch result {
            case .success(let tokeninfo):
                switch tokeninfo{
                case .pokeregi(_):
                    dispatchGroup.leave()
                default:
                    print(tokeninfo)
                    XCTFail("Unexpected type")
                }
            case .failure(let error):
                print(error)
                XCTFail("Error on getTokenInfo")
            }
        }
        
        let invalidToken = "ABCDEFG10102020202020"
        dispatchGroup.enter()
        client.getTokenInfo(invalidToken) { result in
        switch result {
            case .success(let tokeninfo):
                switch tokeninfo{
                case .pokeregi(_):
                    print(tokeninfo)
                    XCTFail("Shouldn't be success")
                default:
                    print(tokeninfo)
                    XCTFail("Unexpected type")
                }
            case .failure(_):
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main, work: DispatchWorkItem(block: {
            expect.fulfill()
        }))
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testGetTokenInfoHasPointExpiresInDays() {
        let expect = expectation(description: "client.getTokenInfoHasPointExpiresInDays")
        let client = Pokepay.Client(accessToken: customerAccessToken, env: .development)
        let token = "https://www-dev.pokepay.jp/checks/52923951-3438-4acd-b433-2273732a5877"
        client.getTokenInfo(token) { result in
            switch result {
            case .success(let tokentype):
                switch tokentype {
                case .check(let response):
                    XCTAssertEqual(30, response.pointExpiresInDays!)
                    expect.fulfill()
                default:
                    XCTFail("Unexpected type")
                }
            case .failure:
                XCTFail("Unexpected tokeninfo")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        
    }

    func testScanToken() {
        let expect = expectation(description: "client.scanToken")
        let mclient = Pokepay.Client(accessToken: merchantAccessToken,
                                    isMerchant: true,
                                    env: .development)
        let dispatchGroup = DispatchGroup()
        // cashtray
        dispatchGroup.enter()
        mclient.createToken(108) { result in
            switch result {
            case .success(let token):
                print(token)
                let client2 = Pokepay.Client(accessToken: self.customerAccessToken,
                                             env: .development)
                client2.scanToken(token) { result in
                    switch result {
                    case .success(let transaction):
                        print(transaction)
                        dispatchGroup.leave()
                    case .failure(let error):
                        print(error)
                        XCTFail("Error on scanToken")
                    }
                }
            case .failure(let error):
                print(error)
                XCTFail("Error on createToken")
            }
        }
        // cashtray
        dispatchGroup.enter()
        mclient.createToken(-108, products: getProducts()) { result in
            switch result {
            case .success(let token):
                print(token)
                let client2 = Pokepay.Client(accessToken: self.customerAccessToken,
                                             env: .development)
                client2.scanToken(token) { result in
                    switch result {
                    case .success(let transaction):
                        print(transaction)
                        dispatchGroup.leave()
                    case .failure(let error):
                        print(error)
                        XCTFail("Error on scanToken")
                    }
                }
            case .failure(let error):
                print(error)
                XCTFail("Error on createToken")
            }
        }

        dispatchGroup.notify(queue: DispatchQueue.main, work: DispatchWorkItem(block: {
            expect.fulfill()
        }))

        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testAuthorizationUrl() {
        let oauth = Pokepay.OAuthClient(clientId: "3qyJZlDnJbGK5roa-5XLkw", clientSecret: "kz96I8SDmjl2x77aAI9iNvAjc0cneL3UoK6zKLjmdXwmoghC7FSRrqKr")
        XCTAssertEqual(oauth.getAuthorizationUrl(), "https://www-dev.pokepay.jp/oauth/authorize?client_id=3qyJZlDnJbGK5roa-5XLkw&response_type=code")
        XCTAssertEqual(oauth.getAuthorizationUrl(contact: "09012345678"), "https://www-dev.pokepay.jp/oauth/authorize?client_id=3qyJZlDnJbGK5roa-5XLkw&response_type=code&contact=09012345678")
        XCTAssertEqual(oauth.getAuthorizationUrl(contact: "{"), "https://www-dev.pokepay.jp/oauth/authorize?client_id=3qyJZlDnJbGK5roa-5XLkw&response_type=code&contact=%7B")
        XCTAssertEqual(oauth.getAuthorizationUrl(contact: "{}@foo.jp"), "https://www-dev.pokepay.jp/oauth/authorize?client_id=3qyJZlDnJbGK5roa-5XLkw&response_type=code&contact=%7B%7D%40foo%2Ejp")
    }

    func testGetAccessToken() {
        let expect = expectation(description: "OAuthClient.getAccessToken")
        let oauth = Pokepay.OAuthClient(clientId: "3qyJZlDnJbGK5roa-5XLkw", clientSecret: "kz96I8SDmjl2x77aAI9iNvAjc0cneL3UoK6zKLjmdXwmoghC7FSRrqKr")
        oauth.getAccessToken(code: "NdnqscefbW4RVa30/DvOf1vKDuPaX0e4") { result in
            switch result {
            case .success(let response):
                print(response)
                expect.fulfill()
            case .failure:
                print(result)
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testSearchPrivateMoney() {
        let expect = expectation(description: "SearchPrivateMoney")
        let client = Pokepay.Client(accessToken: merchantAccessToken,
                                    isMerchant: true,
                                    env: .development)
        client.send(BankAPI.PrivateMoney.Search()) { result in
            switch result {
            case .success(let response):
                print(response)
                expect.fulfill()
            case .failure:
                print(result)
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testListMessages() {
        let expect = expectation(description: "ListMessages")
        let client = Pokepay.Client(accessToken: customerAccessToken,
                                    env: .development)
        client.send(MessagingAPI.List()) { result in
            switch result {
            case .success(let response):
                print(response)
                expect.fulfill()
            case .failure:
                print(result)
                expect.fulfill()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testCashtray() {
        let customer = Pokepay.Client(accessToken: customerAccessToken, isMerchant: false, env: .development)
        let merchant = Pokepay.Client(accessToken: merchantAccessToken, isMerchant: true, env: .development)
        let expect = expectation(description: "Create CPM with customer AccessToken")
        merchant.send(BankAPI.Cashtray.Create(amount: -100000)) { result in
            switch result {
            case .success(let response):
                let id = response.id
                merchant.send(BankAPI.Cashtray.GetAttempts(id: id)) { result in
                    switch result {
                    case .success(let attempts):
                        print(attempts)
                        XCTAssertEqual(0, attempts.rows.count)
                        customer.send(BankAPI.Transaction.CreateWithCashtray(cashtrayId: id)) { result in
                            switch result {
                            case .success(let tran):
                                print(tran)
                                XCTFail("Success on CreateWithCashtray1")
                            case .failure(let error):
                                print(error)
                                merchant.send(BankAPI.Cashtray.GetAttempts(id: id)) { result in
                                    switch result {
                                    case .success(let attempts):
                                        print(attempts)
                                        XCTAssertEqual(1, attempts.rows.count)
                                        XCTAssertTrue(400 <= attempts.rows[0].statusCode)
                                        merchant.send(BankAPI.Cashtray.Update(id: id, amount: 10)) { result in
                                            switch result {
                                            case .success(let cashtray):
                                                print(cashtray)
                                                customer.send(BankAPI.Transaction.CreateWithCashtray(cashtrayId: id)) { result in
                                                    switch result {
                                                    case .success(let tran):
                                                        print(tran)
                                                        merchant.send(BankAPI.Cashtray.GetAttempts(id: id)) { result in
                                                            switch result {
                                                            case .success(let attempts):
                                                                print(attempts)
                                                                XCTAssertEqual(2, attempts.rows.count)
                                                                XCTAssertEqual(200, attempts.rows[0].statusCode)
                                                                expect.fulfill()
                                                            case .failure(let error):
                                                                print(error)
                                                                XCTFail("Error on GetAttempts3")
                                                            }
                                                        }
                                                    case .failure(let error):
                                                        print(error)
                                                        XCTFail("Error on CreateWithCashtray2")
                                                    }
                                                }
                                            case .failure(let error):
                                                print(error)
                                                XCTFail("Error on CashtrayUpdate")
                                            }
                                        }
                                    case .failure(let error):
                                        print(error)
                                        XCTFail("Error on GetAttempts2")
                                    }
                                }
                            }
                        }
                    case .failure(let error):
                        print(error)
                        XCTFail("Error on GetAttempts1")
                    }
                }
            case .failure(let error):
                print(error)
                XCTFail("Error on Cashtray.Create")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testCpmTokens() {
        var expect = expectation(description: "404 should return when get random CPM token.")
        let customer = Pokepay.Client(accessToken: customerAccessToken, isMerchant: false, env: .development)
        let merchant = Pokepay.Client(accessToken: merchantAccessToken, isMerchant: true, env: .development)
        customer.send(BankAPI.CpmToken.Get(cpmToken: "00001111222233334444")) { result in
            switch result {
            case .success:
                XCTFail("This call should be 404.")
            case .failure(.responseError(let error as BankAPIError)):
                switch error {
                case .clientError(let code, let apiError):
                    print("code: \(code)")
                    print("type: \(apiError.type)")
                    print("message: \(apiError.message)")
                    if code != 404 {
                        XCTFail("This call shold be 404.")
                    } else {
                        expect.fulfill()
                    }
                default:
                    XCTFail("unknown error")
                }
            case .failure:
                XCTFail("unknown error")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        // ---
        var firstBalance: Double = 0.0
        expect = expectation(description: "Create CPM with customer AccessToken")
        customer.send(BankAPI.Account.CreateAccountCpmToken(accountId: customerAccountId, scopes: BankAPI.Account.CreateAccountCpmToken.Scope.BOTH, expiresIn: 100)) { result in
            switch result {
            case .success(let response):
                let token = response.cpmToken
                customer.send(BankAPI.CpmToken.Get(cpmToken: token)) { result in
                    switch result {
                    case .success(let response):
                        if response.transaction != nil {
                            XCTFail("transaction should be null")
                        }
                        let balanceBefore = response.account.balance
                        firstBalance = balanceBefore
                        merchant.send(BankAPI.Transaction.CreateWithCpm(cpmToken: token, amount: 1000.0)) { result in
                            switch result {
                            case .success:
                                customer.send(BankAPI.CpmToken.Get(cpmToken: token)) { result in
                                    switch result {
                                    case .success(let response):
                                        if response.transaction == nil {
                                            XCTFail("transaction should be")
                                        }
                                        let balanceAfter = response.account.balance
                                        if balanceBefore + 1000.0 != balanceAfter {
                                            XCTFail("balance not match")
                                        }
                                        expect.fulfill()
                                    case .failure(let err):
                                        print(err)
                                        XCTFail()
                                    }
                                }
                            case .failure(let err):
                                print(err)
                                XCTFail()
                            }
                        }
                    case .failure(let err):
                        print(err)
                        XCTFail()
                    }
                }
            case .failure(let err):
                print(err)
                XCTFail()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
        // ---
        expect = expectation(description: "Create CPM with customer AccessToken")
        customer.send(BankAPI.Account.CreateAccountCpmToken(accountId: customerAccountId, scopes: BankAPI.Account.CreateAccountCpmToken.Scope.BOTH, expiresIn: 100)) { result in
            switch result {
            case .success(let response):
                let token = response.cpmToken
                customer.send(BankAPI.CpmToken.Get(cpmToken: token)) { result in
                    switch result {
                    case .success(let response):
                        if response.transaction != nil {
                            XCTFail("transaction should be null")
                        }
                        let balanceBefore = response.account.balance
                        merchant.send(BankAPI.Transaction.CreateWithCpm(cpmToken: token, amount: -1000.0, products: self.getProducts())) { result in
                            switch result {
                            case .success:
                                customer.send(BankAPI.CpmToken.Get(cpmToken: token)) { result in
                                    switch result {
                                    case .success(let response):
                                        if response.transaction == nil {
                                            XCTFail("transaction should be")
                                        }
                                        let balanceAfter = response.account.balance
                                        if balanceBefore - 1000.0 != balanceAfter && firstBalance != balanceAfter {
                                            XCTFail("balance not match")
                                        }
                                        expect.fulfill()
                                    case .failure(let err):
                                        print(err)
                                        XCTFail()
                                    }
                                }
                            case .failure(let err):
                                print(err)
                                XCTFail()
                            }
                        }
                    case .failure(let err):
                        print(err)
                        XCTFail()
                    }
                }
            case .failure(let err):
                print(err)
                XCTFail()
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testParsingPokeregiToken() {
        let client = Pokepay.Client(accessToken: self.customerAccessToken, env: .development)
        let key = "A0B1C2D3E4F5G6H7I8J9K0L1M"
        let v1QRToken = client.parseAsPokeregiToken(key)
        XCTAssertTrue(v1QRToken.matched, "V1 QR should be matched")
        XCTAssertEqual(v1QRToken.key, key, "V1 QR key")
        let v1NFCToken = client.parseAsPokeregiToken("https://www.pokepay.jp/pd?d=" + key)
        XCTAssertTrue(v1NFCToken.matched, "V1 NFC should be matched")
        XCTAssertEqual(v1NFCToken.key, key, "V1 NFC key")
        let v2QRNFCToken = client.parseAsPokeregiToken("https://www.pokepay.jp/pd/" + key)
        XCTAssertTrue(v2QRNFCToken.matched, "V2 QR/NFC shoudl be  matched")
        XCTAssertEqual(v2QRNFCToken.key, key, "V2 QR/NFC key")
        let invalidToken = client.parseAsPokeregiToken("ABCDEFG10102020202020")
        XCTAssertFalse(invalidToken.matched, "Invalid token should not be matched")
        XCTAssertEqual(invalidToken.key, "", "Invalid token should not have data")
    }
    
    func testPrivateMoneyCanUseCreditCard() {
        let expect = expectation(description: "get privateMoney canUseCreditCard")
        let client = Pokepay.Client(accessToken: customerAccessToken, env: .development)
        client.getTerminalInfo() { result in
            switch result {
            case .success(let response):
                client.send(BankAPI.User.GetAccounts(id: response.user.id)) { result in
                    switch result {
                    case .success(let response):
                        for account in response.items{
                            print(account.id)
                            print(account.privateMoney.name)
                            if let canUseCreditCard = account.privateMoney.canUseCreditCard {
                                print(canUseCreditCard)
                            }
                        }
                        expect.fulfill()
                    case .failure:
                        XCTFail("get account error")
                    }
                }
            case .failure:
                print(result)
                XCTFail("terminal not found")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testUserCreditCard() {
        let expect = expectation(description: "get User CreditCard List and TOPUP")
        let client = Pokepay.Client(accessToken: customerAccessToken, env: .development)
        client.getTerminalInfo() { result in
            switch result {
            case .success(let response):
                client.send(BankAPI.User.GetUserCards(id: response.user.id)) { result in
                    let userId = response.user.id
                    switch result {
                    case .success(let response):
                        for card in response.items{
                            print(card.card_number)
                        }
                        if response.items.count == 0 {
                            expect.fulfill()
                        } else {
                            client.send(BankAPI.User.CardsTopUp(id: userId, accountId: "9c13c0d4-b9ff-46d0-8561-c8ef292267b5", cardRegisteredAt: response.items.first!.registeredAt, amount: "100"), handler: { result in
                                            switch result {
                                            case .success(let response):
                                                expect.fulfill()
                                            case .failure(let err):
                                                print(err)
                                                XCTFail("top up error")
                                            }
                            })
                        }
                    case .failure:
                        XCTFail("get account error")
                    }
                }
            case .failure:
                print(result)
                XCTFail("terminal not found")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testCoupon() {
        let client = Pokepay.Client(accessToken: customerAccessToken, env: .development)
        client.getTerminalInfo() { result in
            switch result {
            case .success(let response):
                let accountId = response.account.id
                client.send(BankAPI.PrivateMoney.GetPrivateMoneyCoupons(privateMoneyId: pokepayMoneyId)) { result in
                    switch result {
                    case .success(let response):
                        print("coupon counts: "+response.counts)
                        let coupon = response.items[0]
                        print("coupon: "+coupon)
                        client.send(BankAPI.Account.GetCouponDetail(accountId: accountId, couponId: coupon.id)){ result in
                            switch result {
                            case .success(let response):
                                let couponDetail = response.couponDetail
                                print("coupon detail: "+couponDetail)
                                client.send(BankAPI.Account.PatchCouponDetail(accountId: accountId, couponId: coupon.id, isReceived: true)) { result in
                                    switch result {
                                    case .success(let response):
                                        print("Patch coupone detail: "+response.couponDetail)
                                    case .failure:
                                        print(result)
                                        XCTFail("patch coupon detail fail")
                                    }
                                }
                            case .failure:
                                print(result)
                                XCTFail("get coupon detail fail")
                            }
                        }
                    case .failure:
                        print(result)
                        XCTFail("get private money coupons fails")
                    }
                }
            case .failure:
                print(result)
                XCTFail("terminal not found")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    static var allTests = [
      ("testGetTerminal", testGetTerminal),
      ("testAddPublicKey", testAddPublicKey),
      ("testCreateToken", testCreateToken),
      ("testClientGetTerminal", testClientGetTerminal),
      ("testGetTokenInfo", testGetTokenInfo),
      ("testScanToken", testScanToken),
      ("testAuthorizationUrl", testAuthorizationUrl),
      ("testGetAccessToken", testGetAccessToken),
      ("testSearchPrivateMoney", testSearchPrivateMoney),
      ("testListMessages", testListMessages),
      ("testCashtray", testCashtray),
      ("testCpmTokens", testCpmTokens),
      ("testParsingPokeregiToken", testParsingPokeregiToken),
      ("testCoupon", testCoupon),
    ]
}
