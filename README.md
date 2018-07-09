# Pokepay iOS SDK

iOS SDK for Pocket Change Pay (https://pay.pocket-change.jp).

## Usage

```swift
Pokepay.setup(accessToken: "ZhwMsfoAyWZMGrCAKrrofmwYHV82GkUcf3kYSZYYf1oDKVvFAPIKuefyQoc1KDVr")
let client = Pokepay.Client(isMerchant: true)

client.getTerminalInfo() { result in
    switch result {
    case .success(let terminal):
        print(terminal)
    case .failure(let error):
        print(error)
    }
}

// Create a token for sending 108 yen.
client.createToken(108) { result in
    switch result {
    case .success(let token):
        print(token)  // like 'https://www.***REMOVED***/cashtrays/dc204118-9e3b-493c-b396-b9259ce28663'
    case .failure(let error):
        print(error)
    }
}

client.scanToken("https://www.***REMOVED***/cashtrays/dc204118-9e3b-493c-b396-b9259ce28663") { result in
    switch result {
    case .success(let transaction):
        print(transaction)
    case. failure(let error):
        print(error)
    }
}
```

## APIs

### [Static Function] Pokepay#setup(accessToken: String)

Set the access token for Bank APIs.

### [Class] Pokepay.Client

#### Options

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
import APIKit

Session.send(BankAPI.Terminal.Get()) { result in
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

## Dependencies

* Swift 4.1
* [APIKit](https://github.com/ishkawa/APIKit)

## Copyright

Copyright (c) 2018 Pocket Change, Inc.
