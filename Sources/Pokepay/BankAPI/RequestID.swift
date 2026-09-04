import Foundation

extension UUID {
    /// The Pokepay API requires `request_id` in lowercase.
    /// Foundation's `uuidString` returns uppercase hex, so it must not be
    /// sent to the API directly.
    var pokepayRequestID: String {
        return uuidString.lowercased()
    }
}
