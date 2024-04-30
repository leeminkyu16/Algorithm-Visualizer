//
//  BfsPageViewState.swift
//  Algorithm-Visualizer
//
//  Created by Min-Kyu Lee on 2024-04-28.
//

import Foundation
import SwiftUI

enum BfsPageViewState: AvViewState {
	case Loading
	case Loaded(BfsPageViewStateLoaded)
}

// sourcery: GenerateCopy
struct BfsPageViewStateLoaded: Equatable {
	init(
		colorGrid: [[Color]],
		currentSelectedCellType: CellType,
		algorithmRunning: Bool = false,
		algorithmComplete: Bool = false,
		startIndices: (Int, Int),
		targetIndices: (Int, Int),
		algorithmSpeed: Double = 0.5,
		queueString: String = "[]"
	) {
		self.colorGrid = colorGrid
		self.currentSelectedCellType = currentSelectedCellType
		self.algorithmRunning = algorithmRunning
		self.algorithmComplete = algorithmComplete
		self.startIndices = startIndices
		self.targetIndices = targetIndices
		self.algorithmSpeed = algorithmSpeed
		self.queueString = queueString
	}

	let colorGrid: [[Color]]

	let currentSelectedCellType: CellType

	let algorithmRunning: Bool
	let algorithmComplete: Bool

	let startIndices: (Int, Int)
	let targetIndices: (Int, Int)

	let algorithmSpeed: Double

	let queueString: String

	static func == (lhs: BfsPageViewStateLoaded, rhs: BfsPageViewStateLoaded) -> Bool {
		return lhs.colorGrid == rhs.colorGrid &&
		lhs.currentSelectedCellType == rhs.currentSelectedCellType &&
		lhs.algorithmRunning == rhs.algorithmRunning &&
		lhs.algorithmComplete == rhs.algorithmComplete &&
		lhs.startIndices == rhs.startIndices &&
		lhs.targetIndices == rhs.targetIndices &&
		lhs.algorithmSpeed == rhs.algorithmSpeed &&
		lhs.queueString == rhs.queueString
	}

}
