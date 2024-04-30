//
//  AvGrid.swift
//  Algorithm-Visualizer
//
//  Created by Min-Kyu Lee on 2024-04-14.
//

import Foundation
import SwiftUI

struct AvGrid: View {
	init(
		grid: [[Color]],
		squareSize: CGFloat,
		onTap: @escaping (Int, Int) -> Void,
		onResize: @escaping (Int, Int) -> Void
	) {
		self.grid = grid
		self.numberOfColumns = 0
		self.numberOfRows = 0
		self.xOffset = 0
		self.yOffset = 0
		self.squareSize = squareSize
		self.onTap = onTap
		self.onResize = onResize
	}

	let grid: [[Color]]

	@State var numberOfColumns: Int
	@State var numberOfRows: Int

	@State var xOffset: CGFloat
	@State var yOffset: CGFloat

	let squareSize: CGFloat

	let onTap: (Int, Int) -> Void
	let onResize: (Int, Int) -> Void

	var body: some View {
		GeometryReader { proxy in
			Canvas { context, _ in
				drawCells(
					context: context
				)

				drawGrid(
					context: context
				)
			}
			.onTapGesture { location in
				let xIndex = BfsPageConstants.coordinateToIndex(
					coordinate: location.x,
					offset: xOffset
				)
				let yIndex = BfsPageConstants.coordinateToIndex(
					coordinate: location.y,
					offset: yOffset
				)

				onTap(xIndex, yIndex)
			}
			.onChange(of: proxy.size) { _ in
				self.numberOfColumns = getNumberOfColumns(
					width: proxy.size.width
				)
				self.numberOfRows = getNumberOfRows(
					height: proxy.size.height
				)

				self.xOffset = getXOffset(
					numberOfColumns: numberOfColumns,
					width: proxy.size.width
				)
				self.yOffset = getYOffset(
					numberOfRows: numberOfRows,
					height: proxy.size.height
				)

				self.onResize(
					self.numberOfColumns,
					self.numberOfRows
				)
			}
		}

	}

	private func drawGrid(
		context: GraphicsContext
	) {
		/*
		 * Draw Vertical Grid Lines
		 */
		for i in 0...self.numberOfColumns {
			if i != self.numberOfColumns {
				context.draw(
					Text(String(i)),
					at: CGPoint(
						x: (CGFloat(i) + 0.5) * (self.squareSize + 1) + self.xOffset,
						y: CGFloat(self.yOffset / 2)
					)
				)
			}
			context.fill(
				Path(
					CGRect(
						origin: CGPoint(
							x: CGFloat(i) * (self.squareSize + 1) + self.xOffset,
							y: self.yOffset
						),
						size: CGSize(
							width: 1,
							height: CGFloat(self.numberOfRows) * (self.squareSize + 1)
						)
					)
				),
				with: .color(
					Color(
						uiColor: UIColor(named: "grid-line")!
					)
				)
			)
		}

		/*
		 * Draw Horizontal Grid Lines
		 */
		for i in 0...self.numberOfRows {
			if i != self.numberOfRows {
				context.draw(
					Text(String(i)),
					at: CGPoint(
						x: CGFloat(self.xOffset / 2),
						y: (CGFloat(i) + 0.5) * (self.squareSize + 1) + self.yOffset
					)
				)
			}
			context.fill(
				Path(
					CGRect(
						origin: CGPoint(
							x: self.xOffset,
							y: CGFloat(i) * (self.squareSize + 1) + yOffset
						),
						size: CGSize(
							width: CGFloat(self.numberOfColumns) * (self.squareSize + 1),
							height: 1
						)
					)
				),
				with: .color(
					Color(
						uiColor: UIColor(named: "grid-line")!
					)
				)
			)
		}
	}

	private func drawCells(
		context: GraphicsContext
	) {
		for (rowIndex, row) in grid.enumerated() {
			for (columnIndex, cell) in row.enumerated() {
				context.fill(
					Path(
						CGRect(
							origin: CGPoint(
								x: CGFloat(columnIndex) * (self.squareSize + 1) + 1 + self.xOffset,
								y: CGFloat(rowIndex) * (self.squareSize + 1) + 1 + self.yOffset
							),
							size: CGSize(
								width: self.squareSize,
								height: self.squareSize
							)
						)
					),
					with: .color(
						cell
					)
				)
			}
		}
	}

	private func getNumberOfColumns(width: Double) -> Int {
		return Int(
			floor(
				width / (self.squareSize + 1)
			)
		 ) - 1
	}

	private func getNumberOfRows(height: Double) -> Int {
		return Int(
			floor(
				 height / (self.squareSize + 1)
			)
		 ) - 1
	}

	private func getXOffset(numberOfColumns: Int, width: Double) -> CGFloat {
		return (
			(width
			 - (CGFloat(numberOfColumns)
				* (self.squareSize + 1)
			   )
			)
			/ 2
		)
	}
	private func getYOffset(numberOfRows: Int, height: Double) -> CGFloat {
		return (
			(height
			 - (CGFloat(numberOfRows)
				* (self.squareSize + 1)
			   )
			)
			/ 2
		)
	}
}
