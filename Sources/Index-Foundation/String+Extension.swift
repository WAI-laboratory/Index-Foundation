import Foundation

public extension String {
    subscript(index: Int) -> Character? {
        guard !self.isEmpty, let stringIndex = self.index(startIndex, offsetBy: index, limitedBy: self.index(before: endIndex)) else { return nil }
        return self[stringIndex]
    }

    // String[0..<1]
    subscript(range: Range<Int>) -> Substring? {
        
        guard let left = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex) else { return nil }
        guard let right = index(left, offsetBy: range.upperBound - range.lowerBound,
                                limitedBy: endIndex) else { return nil }
        return self[left..<right]
    }

    // String[0...1]
    subscript(range: ClosedRange<Int>) -> Substring? {
        if range.upperBound < 0 {
            guard abs(range.lowerBound) <= count else { return nil }
            return self[(count - abs(range.lowerBound))...]
        }
        guard let left = index(startIndex, offsetBy: range.lowerBound, limitedBy: endIndex) else { return nil }
        guard let right = index(left, offsetBy: range.upperBound - range.lowerBound, limitedBy: endIndex) else { return nil }
        return self[left...right]
    }
    
    // String[...1]
    subscript(value: PartialRangeThrough<Int>) -> Substring? {
        
        guard let right = index(startIndex, offsetBy: value.upperBound, limitedBy: endIndex) else { return nil }
        return self[...right]
    }

    // String[1...]
    subscript(value: PartialRangeFrom<Int>) -> Substring? {
        guard let left = index(startIndex, offsetBy: value.lowerBound, limitedBy: endIndex) else { return nil }
        return self[left...]
    }
}
