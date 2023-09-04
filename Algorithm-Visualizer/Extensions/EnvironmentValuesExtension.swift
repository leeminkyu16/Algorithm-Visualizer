//
//  EnvironmentExtension.swift
//  Algorithm-Visualizer
//
//  Created by Min-Kyu Lee on 2023-08-23.
//

import Foundation
import SwiftUI

private struct OriginalColorScheme: EnvironmentKey {
	static let defaultValue = ColorScheme.dark
}

extension EnvironmentValues {
  var originalColorScheme: ColorScheme {
	get { self[OriginalColorScheme.self] }
	set { self[OriginalColorScheme.self] = newValue }
  }
}
