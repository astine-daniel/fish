// MARK: - fatalError testable replace
func fatalError(
    _ message: @autoclosure () -> String = String(),
    file: StaticString = #file,
    line: UInt = #line) -> Never {
    FatalError.fatalError(message(), file, line)
}

// MARK: - FatalError wrapper
enum FatalError {
    typealias Closure = (@autoclosure () -> String, StaticString, UInt) -> Never

    static var fatalError: Closure = defaultFatalError

    static func replace(_ closure: @escaping Closure) {
        fatalError = closure
    }

    static func restore() {
        fatalError = defaultFatalError
    }
}

// MARK: - FatalError private extension
private extension FatalError {
    static let defaultFatalError: Closure = { Swift.fatalError($0(), file: $1, line: $2) }
}
