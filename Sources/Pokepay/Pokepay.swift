import KeychainAccess

struct Pokepay {
    static func setup(accessToken: String) {
        let keychain = Keychain(service: "jp.pocket-change.pay")
        keychain["accessToken"] = accessToken
    }
}
