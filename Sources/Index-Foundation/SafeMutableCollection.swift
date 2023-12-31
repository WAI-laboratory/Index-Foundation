import Foundation

public struct SafeMutableCollection<C>: MutableCollection where C: MutableCollection {
  public typealias Index = C.Index
  public typealias Element = Optional<C.Element>

  fileprivate var collection: C

  init(_ collection: C) {
    self.collection = collection
  }

  public subscript(position: Index) -> Element {
    get {
      guard self.collection.indices.contains(position) else { return nil }
      return self.collection[position]
    }
    set {
      guard let value = newValue else { return }
      guard self.collection.indices.contains(position) else { return }
      self.collection[position] = value
    }
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

public extension MutableCollection {
  var safe: SafeMutableCollection<Self> {
    get { return .init(self) }
    set { self = newValue.collection }
  }
}
