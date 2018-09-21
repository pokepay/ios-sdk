# Pokepay iOS SDK

iOS SDK for Pocket Change Pay (https://pay.pocket-change.jp).

## Usage

```swift
let client = Pokepay.Client(accessToken: "ZhwMsfoAyWZMGrCAKrrofmwYHV82GkUcf3kYSZYYf1oDKVvFAPIKuefyQoc1KDVr",
                            isMerchant: true)

client.getTerminalInfo() { result in
    switch result {
    case .success(let terminal):
        print(terminal)
        // => Terminal(id: "45046d7f-aa33-4d26-8cb0-8971aae5a487", name: "", hardwareId: "4e5c5d18-b27f-4b32-a0e0-e8900686fe23", pushToken: nil, user: Pokepay.User(id: "4abed0cc-6431-446f-aaf5-bebc208d84c1", name: "", isMerchant: true), account: Pokepay.Account(id: "1b4533c0-651c-4e79-8444-346419b18c77", name: "", balance: -15357.0, isSuspended: false, privateMoney: Pokepay.PrivateMoney(id: "090bf006-7450-4ed9-8da1-977ea3ff332c", name: "PocketBank", organization: Pokepay.Organization(code: "pocketchange", name: "ポケットチェンジ"), maxBalance: 30000.0, expirationType: "static")))
    case .failure(let error):
        print(error)
    }
}

// Create a token for sending 108 yen.
client.createToken(108) { result in
    switch result {
    case .success(let token):
        print(token)  // like 'https://www.pokepay.jp/cashtrays/dc204118-9e3b-493c-b396-b9259ce28663'
    case .failure(let error):
        print(error)
    }
}

// Scan a QR code
client.scanToken("https://www.pokepay.jp/cashtrays/dc204118-9e3b-493c-b396-b9259ce28663") { result in
    switch result {
    case .success(let transaction):
        print(transaction)
    case. failure(let error):
        print(error)
    }
}
```

## Authorization

Pocket Change Pay API provides OAuth for authentication of third-party applications.

1. Open Authorization URL in Web browser (like Safari or WKWebView)

```swift
let oauth = Pokepay.OAuthClient(clientId: clientId, clientSecret: clientSecret)
let url = oauth.getAuthorizationUrl()
// => https://www.pokepay.jp/oauth/authorize?client_id=xxxxxxxxxxx&response_type=code
```

2. Wait for the user to authorize your app on Pocket Change Pay
3. Browser redirects to the app with authorization code
4. Exchange the authorization code for an access token

```swift
let accessToken = oauth.getAccessToken(code: code)
// => AccessToken(accessToken: "dXX1Guh7Ze0F_s6L8mAk-t4DXxvO2wd_IwWXbQBGdNo0nkj01tYA9EKY992H_mMP", refreshToken: "XKOfCZmLuRjLggDZzDfz", tokenType: "Bearer", expiresIn: 2591999)
```

## APIs

### [Class] Pokepay.Client

#### Options

- `accessToken` (String): An access token to request Pocket Change Pay APIs.
- `isMerchant` (Bool): A flag for accessing as a merchant account. (It should be an error if the access token isn't for merchant one.)

### [Method] Client.getTerminalInfo

Get a `Terminal` informations about the accessing terminal.

### [Method] Client.scanToken(_ token: String, amount: Double? = nil)

Scan a token and make a new transaction via Bank APIs.

### [Method] Client.createToken(_ amount: Double? = nil, description: String? = nil, expiresIn: Int32? = nil)

Make a new token for sending/receiving money, which can be done with `scanToken`.

## Low-Level APIs

All HTTP requests to Bank RESTful APIs also can be done with APIKit and request structures defined under `BankAPI` (See Sources/Pokepay/BankAPI/).

```swift
import Pokepay

let client = Pokepay.Client(accessToken: "ZhwMsfoAyWZMGrCAKrrofmwYHV82GkUcf3kYSZYYf1oDKVvFAPIKuefyQoc1KDVr")
client.send(BankAPI.Terminal.Get()) { result in
    switch result {
    case .success(let terminal):
        print(terminal)
    case .failure(let error):
        print(error)
    }
}
```

## Requirements

* Xcode 9 or later

## Installation

### CocoaPods

```ruby
pod "Pokepay"
```

## Dependencies

* Swift 4.1
* [APIKit](https://github.com/ishkawa/APIKit)

## Development Note

### Building HTML documents

```
$ make docs
```

## Copyright

Copyright (c) 2018 Pocket Change, Inc.
