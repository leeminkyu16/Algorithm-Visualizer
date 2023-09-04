//
//  TextExtension.swift
//  Algorithm-Visualizer
//
//  Created by Min-Kyu Lee on 2023-08-20.
//

import Foundation
import SwiftUI

extension Text {
	public func foregroundLinearGradient(
		colors: [Color],
		startPoint: UnitPoint = .leading,
		endPoint: UnitPoint = .trailing
	) -> some View {
		self.overlay {
			LinearGradient(
				colors: colors,
				startPoint: startPoint,
				endPoint: endPoint
			)
			.mask(
				self
			)
		}
	}
}
