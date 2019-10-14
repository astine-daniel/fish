// Generated using SwiftGen

#if canImport(AppKit)
  import AppKit
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias Image = NSImage
#elseif canImport(UIKit)
  import UIKit
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias Image = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

internal struct ImageAsset {
  internal private(set) var name: String

  internal var image: Image {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal struct ColorAsset {
  internal private(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

// swiftlint:disable identifier_name line_length nesting type_body_length type_name let_var_whitespace
internal enum Assets {
  internal enum Colors {
    internal static let denim = ColorAsset(name: "Denim")
    internal static let dustyGray = ColorAsset(name: "Dusty Gray")
    internal static let flamingo = ColorAsset(name: "Flamingo")
    internal static let wildSand = ColorAsset(name: "Wild Sand")
  }
  internal enum Common {
    internal static let arrowDown = ImageAsset(name: "ArrowDown")
    internal static let filter = ImageAsset(name: "Filter")
    internal static let heart = ImageAsset(name: "Heart")
    internal static let heartBold = ImageAsset(name: "HeartBold")
    internal static let heartHighlighted = ImageAsset(name: "HeartHighlighted")
    internal static let star = ImageAsset(name: "Star")
  }
  internal enum Flows {
    internal enum InTheCity {
      internal static let inTheCityIcon = ImageAsset(name: "InTheCityIcon")
      internal static let inTheCityIconHighlighted = ImageAsset(name: "InTheCityIconHighlighted")
    }
    internal enum Products {
      internal static let productsIcon = ImageAsset(name: "ProductsIcon")
      internal static let productsIconHighlighted = ImageAsset(name: "ProductsIconHighlighted")
    }
    internal enum Trips {
      internal static let tripsIcon = ImageAsset(name: "TripsIcon")
      internal static let tripsIconHighlighted = ImageAsset(name: "TripsIconHighlighted")
    }
  }

  // swiftlint:disable trailing_comma
  internal static let allColors: [ColorAsset] = [
    Colors.denim,
    Colors.dustyGray,
    Colors.flamingo,
    Colors.wildSand,
  ]
  internal static let allImages: [ImageAsset] = [
    Common.arrowDown,
    Common.filter,
    Common.heart,
    Common.heartBold,
    Common.heartHighlighted,
    Common.star,
    Flows.InTheCity.inTheCityIcon,
    Flows.InTheCity.inTheCityIconHighlighted,
    Flows.Products.productsIcon,
    Flows.Products.productsIconHighlighted,
    Flows.Trips.tripsIcon,
    Flows.Trips.tripsIconHighlighted,
  ]
  // swiftlint:enable trailing_comma
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
