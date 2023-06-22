import Foundation

extension String {
    func contain(of pattern: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options()) else {
            fatalError("Invalid RegularExpression")
        }
        return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, self.count)) != nil
    }
}
