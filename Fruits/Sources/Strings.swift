// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Fruit {
    /// Price: %d
    internal static func price(_ p1: Int) -> String {
      return L10n.tr("Localizable", "fruit.price", p1)
    }
    /// Weight: %0.1f
    internal static func weight(_ p1: Float) -> String {
      return L10n.tr("Localizable", "fruit.weight", p1)
    }
  }

  internal enum Main {
    internal enum View {
      internal enum Navigation {
        /// Fruits
        internal static let title = L10n.tr("Localizable", "main.view.navigation.title")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.autoupdatingCurrent, arguments: args)
  }
}

private final class BundleToken {}
