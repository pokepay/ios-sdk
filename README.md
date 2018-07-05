# Pokepay iOS SDK

iOS SDK for Pocket Change Pay (https://pay.pocket-change.jp).

## Usage

```swift
Pokepay.setup(accessToken: "ZhwMsfoAyWZMGrCAKrrofmwYHV82GkUcf3kYSZYYf1oDKVvFAPIKuefyQoc1KDVr")

// Create a token for sending 108 yen.
Pokepay.createToken(108) { result in
    switch result {
    case .success(let token):
        print(token)  // like 'https://www.***REMOVED***/cashtrays/dc204118-9e3b-493c-b396-b9259ce28663'
    case .failure(let error):
        print(error)
    }
}
```

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
