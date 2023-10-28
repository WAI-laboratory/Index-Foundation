import Foundation

public extension Collection {
    //array[safe: 4]
    subscript (safe index: Index) -> Element? {
      return indices.contains(index) ? self[index] : nil
    }
    
    // array[1,4,5]
    subscript (indexs: Index...) -> [Element] {
        var result: [Self.Element] = []
        for index in indexs {
            if let value = self[safe: index] {
                result.append(value)
            }
        }
        return result
    }
    
    //array[stride: 2]
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
