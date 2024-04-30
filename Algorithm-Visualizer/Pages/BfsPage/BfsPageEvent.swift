//
//  BfsPageEvent.swift
//  Algorithm-Visualizer
//
//  Created by Min-Kyu Lee on 2024-04-27.
//

import Foundation

struct BfsPageEvent: AvEvent {
	init(_ value: Value) {
		self.value = value
	}

	static func == (lhs: BfsPageEvent, rhs: BfsPageEvent) -> Bool {
		return lhs.id == rhs.id
	}

	let id: UUID = UUID()
	let value: Value

	enum Value {
		case AlgorithmSpeedChanged(Double)
		case CellTypeSelected(CellType)
		case CellTapped(Int, Int)

		case GridResized(Int, Int)

		case ResetTapped
		case StartTapped
	}
}
