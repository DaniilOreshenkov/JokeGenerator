import Foundation

extension R {
    enum Localisable: String {
        case jokeIdLabel
        case jokeNumberLabel
        case typeLabel
        case generalLabel
        case setupLabel
        case punchlineButton
        
        var value: Swift.String {
            NSLocalizedString(self.rawValue, comment: "")
        }
    }
}
