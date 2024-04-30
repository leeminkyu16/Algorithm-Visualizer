//
//  BFS_Page_Constants.swift
//  Algorithm Visualizer
//
//  Created by Min-Kyu Lee on 2023-08-17.
//

import Foundation
import SwiftUI

class BfsPageConstants {
	static let squareSize: CGFloat = 25

	static func indexToCoordinate(
		index: Int,
		squareSize: CGFloat = BfsPageConstants.squareSize + 1,
		offset: CGFloat = 0
	) -> CGFloat {
		return CGFloat(index) * squareSize + offset
	}

	static func coordinateToIndex(
		coordinate: CGFloat,
		squareSize: CGFloat = BfsPageConstants.squareSize + 1,
		offset: CGFloat = 0
	) -> Int {
		return Int(floor((coordinate - offset) / squareSize))
	}

}
