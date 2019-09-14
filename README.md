# Pokepay iOS SDK

iOS SDK for Pocket Change Pay (https://pay.pocket-change.jp).

## Document

* https://docs.pokepay.jp/sdk/swift.html

## Usage

```swift
let client = Pokepay.Client(accessToken: "ZhwMsfoAyWZMGrCAKrrofmwYHV82GkUcf3kYSZYYf1oDKVvFAPIKuefyQoc1KDVr",
                            isMerchant: true,
                            env: .production)

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

## Environments

Pokepay APIs have multiple server environments for isolation between development ones and production ones. `Pokepay.Client` (and `Pokepay.OAuthClient`) takes `:env` argument to switch which environment to use.

```swift
// Sandbox (default)
let client = Pokepay.Client(accessToken: "ZhwMsfoAyWZMGrCAKrrofmwYHV82GkUcf3kYSZYYf1oDKVvFAPIKuefyQoc1KDVr",
                            env: .sandbox)
// Production
let client = Pokepay.Client(accessToken: "ZhwMsfoAyWZMGrCAKrrofmwYHV82GkUcf3kYSZYYf1oDKVvFAPIKuefyQoc1KDVr",
                            env: .production)
```

## Authorization

Pokepay API provides OAuth authentication for third-party applications.

1. Open Authorization URL in Web browser (like Safari or WKWebView)

```swift
let oauth = Pokepay.OAuthClient(clientId: clientId, clientSecret: clientSecret, env: .production)
let url = oauth.getAuthorizationUrl()
// => https://www.pokepay.jp/oauth/authorize?client_id=xxxxxxxxxxx&response_type=code
```

2. Wait for the user to authorize your app on Pokepay's Web page.
3. Browser redirects to the app with authorization code
4. Exchange the authorization code for an access token

```swift
let accessToken = oauth.getAccessToken(code: code)
// => AccessToken(accessToken: "dXX1Guh7Ze0F_s6L8mAk-t4DXxvO2wd_IwWXbQBGdNo0nkj01tYA9EKY992H_mMP", refreshToken: "XKOfCZmLuRjLggDZzDfz", tokenType: "Bearer", expiresIn: 2591999)
```

### Refreshing access tokens

Every access tokens will be expired. The term is 30 days now, however, it could be shorten in the future. Therefore, please prepare the case when those access tokens are expired and the API server returns 403 Forbidden.

For avoiding reauthentication with OAuth every time, Pokepay returns a refresh token for each access token responses, at a field `refreshToken` in `AccessToken` objects. As `OAuthClient` doesn't store it automatically, storing it at any secure place (like KeyChain) is recommended.

`OAuthClient#refreshAccessToken` is the function to issue another access token with a refresh token:

```swift
oauth.refreshAccessToken(refreshToken: accessToken.refreshToken)
// => AccessToken(accessToken: "gtSn683mul_FFaMlB2jLyOyK-6LJ-u3Qiv-Iiy6cGoJZyKD242xe29BTHEYXXaqj", refreshToken: "-YvJULJ5rEhQ0fY86t80", tokenType: "Bearer", expiresIn: 2591999)
```

Refresh tokens can be used only once. Be sure to update the refresh token after reauthentication.

## APIs

### [Class] Pokepay.Client

#### Options

- `accessToken` (String): An access token to request Pokepay APIs.
- `isMerchant` (Bool): A flag whether access as a merchant. (It should be an error if the access token isn't for merchant one.)
- `env` (Environment Enum): A enum value to specify which environment to use.

### [Method] Client.send(_ request: Request)

Send an HTTP request to APIs and get the response as an object. See [Send requests with Request objects](#Send-requests-with-Request-objects) for details.

### [Method] Client.getTerminalInfo

Get the accessing `Terminal` informations.

### [Method] Client.scanToken(_ token: String, amount: Double? = nil)

Scan a token and make a new transaction via Bank APIs.

### [Method] Client.createToken(_ amount: Double? = nil, description: String? = nil, expiresIn: Int32? = nil)

Make a new token for sending/receiving money, which can be done with `scanToken`.

### [Method] Client.getTokenInfo(_ token: String)

Get informations of the `token` which is created by `createToken` or read with `scanToken`. The result type could be one of `Bill`, `Check` or `Cashtray`.

### [Class] Pokepay.OAuthClient

#### Options

- `clientId` (String): OAuth client ID
- `clientSecret`: OAuth client secret
- `env` (Environment Enum): A enum value to specify which environment to use.

### [Method] OAuthClient.getAuthorizationUrl() -> String

Get the OAuth authorization URL to open with an external browser. (ex. https://www.pokepay.jp/oauth/authorize?client_id=xxxxxxxx&response_type=code)

### [Method] OAuthClient.getAccessToken(code: String)

Exchange authorization code, a string in redirection URL, with an access token.

### [Method] OAuthClient.refreshAccessToken(refreshToken: String)

Issue a new access token with a refresh token.

## Send requests with Request objects

All HTTP requests to RESTful APIs also can be done with request structures defined under `BankAPI` (See Sources/Pokepay/BankAPI/).

```swift
import Pokepay

// Same as Client.getTerminalInfo
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

## Error handling

```swift
client.send(BankAPI.Terminal.Get()) { result in
    switch result {
    case .success(let response):
        // Success. `response` is a Terminal object.
        print(response)
    case .failure(.responseError(let error as BankAPIError)):
        // Failure with response error. The content of Error object is returned from Bank API.
        switch error {
        case .clientError(let code, let apiError):
            // 4xx error
            print("code: \(code)")
            print("type: \(apiError.type)")
            print("message: \(apiError.message)")
        case .serverError:
            // 5xx error
        default:
            print("Other unknown error.")
        }
    case .failure:
        // Other error, like network disconnected
        print(result)
    }
}
```

## Requirements

* Xcode 9 or later
* iOS 10.0 or later

## Installation

```
brew update; brew install carthage
ls Cartfile
carthage bootstrap --platform iOS
open Pokepay.xcodeproj
[Cmd-b]
ls $HOME/Library/Developer/Xcode/DerivedData/Pokepay-{somecode}/Build/Products/Release-iphoneos/Pokepay.framework
```

### Carthage

```ruby
github "pokepay/ios-sdk"
```

### CocoaPods

```
pod 'Pokepay'
```

## Dependencies

* Swift 5.0
* [APIKit](https://github.com/ishkawa/APIKit)

## Copyright

Copyright (c) 2018 Pocket Change, Inc.
