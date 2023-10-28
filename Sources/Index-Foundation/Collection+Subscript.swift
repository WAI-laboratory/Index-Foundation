import Foundation

public extension Collection {
    subscript (safe index: Index) -> Element? {
      return indices.contains(index) ? self[index] : nil
    }
    
    subscript (indexs: Index...) -> [Element] {
        var result: [Self.Element] = []
        for index in indexs {
            if let value = self[safe: index] {
                result.append(value)
            }
        }
        return result
    }
    
    subscript(stride step: Int) -> [Element] {
        precondition(step > 0, "Stride must be greater than zero")
        
        var result: [Element] = []
        var index = startIndex
        while index < endIndex {
            result.append(self[index])
            let distance = self.distance(from: index, to: endIndex)
            if distance > step {
                index = self.index(index, offsetBy: step)
            } else {
                break
            }
        }
        
        return result
    }
}
