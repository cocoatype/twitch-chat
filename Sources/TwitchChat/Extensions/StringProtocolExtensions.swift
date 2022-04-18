extension StringProtocol where Self: RangeReplaceableCollection {
    func removingPrefix(_ prefix: String) -> Self {
        guard hasPrefix(prefix) else { return self }
        var copy = self
        copy.removeFirst(prefix.count)
        return copy
    }

    mutating func append(_ value: Optional<Self>) {
        guard let value = value else { return }
        append(contentsOf: value)
    }
}
