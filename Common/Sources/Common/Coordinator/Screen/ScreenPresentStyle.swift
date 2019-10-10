public enum ScreenPresentStyle {
    case main(animated: Bool)
    case modal(animated: Bool)
    case show(animated: Bool)
}

extension ScreenPresentStyle: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case let (.main(lhsAnimated), .main(rhsAnimated)):
            return lhsAnimated == rhsAnimated
        case let (.modal(lhsAnimated), .modal(rhsAnimated)):
            return lhsAnimated == rhsAnimated
        case let (.show(lhsAnimated), .show(rhsAnimated)):
            return lhsAnimated == rhsAnimated
        default:
            return false
        }
    }
}
