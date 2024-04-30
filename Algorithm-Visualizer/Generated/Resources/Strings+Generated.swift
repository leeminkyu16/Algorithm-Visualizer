// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Algorithm Speed:
  internal static let algorithmSpeedHeader = L10n.tr("Localizable", "algorithm-speed-header", fallback: "Algorithm Speed:")
  /// Algorihtm Visualizer
  internal static let algorithmVisualizer = L10n.tr("Localizable", "algorithm-visualizer", fallback: "Algorihtm Visualizer")
  /// BFS
  internal static let bfs = L10n.tr("Localizable", "bfs", fallback: "BFS")
  /// BFS Algorithm
  internal static let bfsPageTitle = L10n.tr("Localizable", "bfs-page-title", fallback: "BFS Algorithm")
  /// Localizable.strings
  ///   Algorithm Visualizer
  /// 
  ///   Created by Min-Kyu Lee on 2023-08-17.
  internal static let cellType = L10n.tr("Localizable", "cell-type", fallback: "Cell Type")
  /// Cell Type:
  internal static let cellTypeHeader = L10n.tr("Localizable", "cell-type-header", fallback: "Cell Type:")
  /// Dark Theme
  internal static let darkTheme = L10n.tr("Localizable", "dark-theme", fallback: "Dark Theme")
  /// Fast
  internal static let fast = L10n.tr("Localizable", "fast", fallback: "Fast")
  /// Home
  internal static let home = L10n.tr("Localizable", "home", fallback: "Home")
  /// Not Visited
  internal static let notVisited = L10n.tr("Localizable", "not-visited", fallback: "Not Visited")
  /// Queue:
  internal static let queueHeader = L10n.tr("Localizable", "queue-header", fallback: "Queue:")
  /// Reset Grid
  internal static let resetGrid = L10n.tr("Localizable", "reset-grid", fallback: "Reset Grid")
  /// Settings
  internal static let settingsPageTitle = L10n.tr("Localizable", "settings-page-title", fallback: "Settings")
  /// Slow
  internal static let slow = L10n.tr("Localizable", "slow", fallback: "Slow")
  /// Start
  internal static let start = L10n.tr("Localizable", "start", fallback: "Start")
  /// Start Algorithm
  internal static let startAlgorithm = L10n.tr("Localizable", "start-algorithm", fallback: "Start Algorithm")
  /// Target
  internal static let target = L10n.tr("Localizable", "target", fallback: "Target")
  /// To Be Visited
  internal static let toBeVisited = L10n.tr("Localizable", "to-be-visited", fallback: "To Be Visited")
  /// Use Dark Theme
  internal static let useDarkTheme = L10n.tr("Localizable", "use-dark-theme", fallback: "Use Dark Theme")
  /// Use System Default
  internal static let useSystemDefault = L10n.tr("Localizable", "use-system-default", fallback: "Use System Default")
  /// Visited
  internal static let visited = L10n.tr("Localizable", "visited", fallback: "Visited")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
