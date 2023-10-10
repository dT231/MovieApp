//
// https://forums.swift.org/t/tree-iterator/15181/8

public final class Node<Element> {
    public var value: Element
    public var children: [Node]

    public init(value: Element, children: [Node] = []) {
        self.value = value
        self.children = children
    }
}

extension Node: Sequence {
    public func makeIterator() -> Iterator { return Iterator.parent(self) }

    public enum Iterator: IteratorProtocol {
        case parent(Node)
        indirect case remainingChildren(Iterator, ArraySlice<Node>)
        case done

        public mutating func next() -> Node? {
            switch self {
            case let .parent(parent):
                if let first = parent.children.first {
                    self = .remainingChildren(first.makeIterator(), parent.children.dropFirst())
                } else {
                    self = .done
                }

                return parent

            case .remainingChildren(var childIterator, let remainingChildren):
                if let nextValue = childIterator.next() {
                    self = .remainingChildren(childIterator, remainingChildren)

                    return nextValue
                } else if let nextChild = remainingChildren.first {
                    childIterator = nextChild.makeIterator()
                    let nextValue = childIterator.next()
                    // Note: nextValue cannot be nil because nextChild != nil && nextChild.makeIterator().next() === nextChild
                    self = .remainingChildren(childIterator, remainingChildren.dropFirst())

                    return nextValue
                } else {
                    self = .done

                    return nil
                }
            case .done:
                return nil
            }
        }
    }
}
