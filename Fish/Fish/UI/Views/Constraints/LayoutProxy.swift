import UIKit

// MARK: - Layout<Proxy>
final class LayoutProxy {
    // MARK: - Properties
    private let view: UIView

    lazy var leading: LayoutProperty = property(with: view.leadingAnchor)
    lazy var trailing = property(with: view.trailingAnchor)
    lazy var top = property(with: view.topAnchor)
    lazy var bottom = property(with: view.bottomAnchor)

    lazy var width = property(with: view.widthAnchor)
    lazy var height = property(with: view.heightAnchor)

    lazy var centerXAnchor = property(with: view.centerXAnchor)
    lazy var centerYAnchor = property(with: view.centerYAnchor)

    // MARK: - Initialization
    fileprivate init(view: UIView) {
        self.view = view
    }
}

extension LayoutProxy {
    func property<Anchor: LayoutAnchor>(with anchor: Anchor) -> LayoutProperty<Anchor> {
        LayoutProperty(anchor: anchor)
    }

    func property<Anchor: LayoutDimension>(witch anchor: Anchor) -> LayoutProperty<Anchor> {
        LayoutProperty(anchor: anchor)
    }
}

extension UIView {
    func layout(using closure: (LayoutProxy) -> Void) {
        translatesAutoresizingMaskIntoConstraints = false
        closure(LayoutProxy(view: self))
    }
}

// MARK: - LayoutProperty<Anchor>
struct LayoutProperty<Anchor: LayoutAnchor> {
    fileprivate let anchor: Anchor
}

extension LayoutProperty {
    @discardableResult
    func equal(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = anchor.constraint(equalTo: otherAnchor, constant: constant)
        constraint.isActive = true

        return constraint
    }

    @discardableResult
    func greaterThanOrEqual(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = anchor.constraint(greaterThanOrEqualTo: otherAnchor, constant: constant)
        constraint.isActive = true

        return constraint
    }

    @discardableResult
    func lessThanOrEqual(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint = anchor.constraint(lessThanOrEqualTo: otherAnchor, constant: constant)
        constraint.isActive = true

        return constraint
    }
}

extension LayoutProperty where Anchor: LayoutDimension {
    @discardableResult
    func equal(to constant: CGFloat) -> NSLayoutConstraint {
        let constraint = anchor.constraint(equalToConstant: constant)
        constraint.isActive = true

        return constraint
    }

    @discardableResult
    func greaterThanOrEqual(to constant: CGFloat) -> NSLayoutConstraint {
        let constraint = anchor.constraint(greaterThanOrEqualToConstant: constant)
        constraint.isActive = true

        return constraint
    }

    @discardableResult
    func lessThanOrEqual(to constant: CGFloat) -> NSLayoutConstraint {
        let constraint = anchor.constraint(lessThanOrEqualToConstant: constant)
        constraint.isActive = true

        return constraint
    }
}

// swiftlint:disable static_operator
// MARK: - Operators
@discardableResult
func == <Anchor: LayoutAnchor>(lhs: LayoutProperty<Anchor>, rhs: (anchor: Anchor, offset: CGFloat)) -> NSLayoutConstraint {
    lhs.equal(to: rhs.anchor, offsetBy: rhs.offset)
}

@discardableResult
func == <Anchor: LayoutAnchor>(lhs: LayoutProperty<Anchor>, rhs: Anchor) -> NSLayoutConstraint {
    lhs.equal(to: rhs)
}

@discardableResult
func >= <Anchor: LayoutAnchor>(lhs: LayoutProperty<Anchor>, rhs: (anchor: Anchor, offset: CGFloat)) -> NSLayoutConstraint {
    lhs.greaterThanOrEqual(to: rhs.anchor, offsetBy: rhs.offset)
}

@discardableResult
func >= <Anchor: LayoutAnchor>(lhs: LayoutProperty<Anchor>, rhs: Anchor) -> NSLayoutConstraint {
    lhs.greaterThanOrEqual(to: rhs)
}

@discardableResult
func <= <Anchor: LayoutAnchor>(lhs: LayoutProperty<Anchor>, rhs: (anchor: Anchor, offset: CGFloat)) -> NSLayoutConstraint {
    lhs.lessThanOrEqual(to: rhs.anchor, offsetBy: rhs.offset)
}

@discardableResult
func <= <Anchor: LayoutAnchor>(lhs: LayoutProperty<Anchor>, rhs: Anchor) -> NSLayoutConstraint {
    lhs.lessThanOrEqual(to: rhs)
}

@discardableResult
func == <Anchor: LayoutDimension>(lhs: LayoutProperty<Anchor>, rhs: CGFloat) -> NSLayoutConstraint {
    lhs.equal(to: rhs)
}

@discardableResult
func <= <Anchor: LayoutDimension>(lhs: LayoutProperty<Anchor>, rhs: CGFloat) -> NSLayoutConstraint {
    lhs.lessThanOrEqual(to: rhs)
}

@discardableResult
func >= <Anchor: LayoutDimension>(lhs: LayoutProperty<Anchor>, rhs: CGFloat) -> NSLayoutConstraint {
    lhs.greaterThanOrEqual(to: rhs)
}

// swiftlint:enable static_operator
