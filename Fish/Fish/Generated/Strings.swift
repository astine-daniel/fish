// Generated using SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum Strings {
  /// Na cidade
  internal static let inTheCity = Strings.tr("Localizable", "inTheCity")
  /// Produtos
  internal static let products = Strings.tr("Localizable", "products")
  /// Viagens
  internal static let trips = Strings.tr("Localizable", "trips")

  internal enum Common {
    /// A partir de
    internal static let fromPrice = Strings.tr("Localizable", "common.fromPrice")
    /// Top
    internal static let top = Strings.tr("Localizable", "common.top")
  }

  internal enum Error {
    internal enum Fatal {
      /// %@ has not been implemented
      internal static func notImplemented(_ p1: String) -> String {
        return Strings.tr("Localizable", "error.fatal.notImplemented", p1)
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
