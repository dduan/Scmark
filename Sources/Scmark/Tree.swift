/// Sequence of nodes in a tree-representation of a document.
///
/// Provides a `Sequence` interface to `TreeIterator`. Read docs for `TreeIterator` for how the tree is traversed.
public struct Tree: Sequence {
    let root: Node

    /// - Parameter root: Root of the tree to visit.
    public init(root: Node) {
        self.root = root
    }

    public func makeIterator() -> AnyIterator<(TreeIterator.Event, Node)> {
        let iter = TreeIterator(root: root)

        return AnyIterator {
            if let event = iter.next(), let node = iter.node() {
                return (event, node)
            }

            return nil
        }
    }
}
