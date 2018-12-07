import Foundation

struct RegexCase {
    let pattern: String
    let options: NSRegularExpression.Options!

    private var matcher: NSRegularExpression {
        return try! NSRegularExpression(pattern: self.pattern, options: self.options)
    }

    init(pattern: String, options: NSRegularExpression.Options = []) {
        self.pattern = pattern
        self.options = options
    }

    func match(string: String, options: NSRegularExpression.MatchingOptions = []) -> Bool {
        return self.matcher.numberOfMatches(in: string, options: options, range: NSMakeRange(0, string.utf16.count)) != 0
    }
}

protocol RegularExpressionMatchable {
    func match(regex: RegexCase) -> Bool
}

extension String: RegularExpressionMatchable {
    func match(regex: RegexCase) -> Bool {
        return regex.match(string: self)
    }
}

func ~=<T: RegularExpressionMatchable>(pattern: RegexCase, matchable: T) -> Bool {
    return matchable.match(regex: pattern)
}
