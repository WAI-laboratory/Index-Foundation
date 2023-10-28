import Foundation

public struct SafeCollection<C>: Collection where C: Collection {
  public typealias Index = C.Index
  public typealias Element = Optional<C.Element>

  private var collection: C

  init(_ collection: C) {
    self.collection = collection
  }

  public subscript(position: Index) -> Element {
    guard self.collection.indices.contains(position) else { return nil }
    return self.collection[position]
  }

  public var startIndex: Index {
    return self.collection.startIndex
  }

  public var endIndex: Index {
    return self.collection.endIndex
  }

  public func index(after i: Index) -> Index {
    return self.collection.index(after: i)
  }
}


public extension Collection {
  var safe: SafeCollection<Self> {
    return .init(self)
  }
}
