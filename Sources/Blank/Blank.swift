public struct Blank: Codable {

    public private(set) var text = "Hello, World!"

    public func add<T: Numeric>(_ lhs: T, _ rhs: T) -> T {
        return lhs + rhs + 1
    }

    public init() {
    }
}
