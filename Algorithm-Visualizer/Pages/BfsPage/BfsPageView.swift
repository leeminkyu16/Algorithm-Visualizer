//
//  BFS_Page_View.swift
//  Algorithm Visualizer
//
//  Created by Min-Kyu Lee on 2023-05-03.
//

import SwiftUI
import Swinject

struct BfsPageView: View {
	@Binding var container: Container
	@ObservedObject var viewModel: BfsPageViewModel
	    
    var body: some View {
		VStack(alignment: .center) {
            GeometryReader { proxy in
				let numberOfColumns: Int = getNumberOfColumns(
					width: proxy.size.width
				)
				let numberOfRows: Int = getNumberOfRows(
					height: proxy.size.height
				)
				let xOffset: CGFloat = getXOffset(
					numberOfColumns: numberOfColumns,
					width: proxy.size.width
				)
				let yOffset: CGFloat = getYOffset(
					numberOfRows: numberOfRows,
					height: proxy.size.height
				)
				Canvas { context, size in
					drawCells(
						context: context,
						xOffset: xOffset,
						yOffset: yOffset
					)
					
					drawGrid(
						context: context,
						numberOfColumns: numberOfColumns,
						numberOfRows: numberOfRows,
						xOffset: xOffset,
						yOffset: yOffset
					)
                }
				.onChange(of: proxy.size) { newSize in
					let numberOfColumns: Int = getNumberOfColumns(
						width: proxy.size.width
					)
					let numberOfRows: Int = getNumberOfRows(
						height: proxy.size.height
					)
					
					self.viewModel.initGrid(
						numOfColumns: numberOfColumns,
						numOfRows: numberOfRows
					)
				}
                .onTapGesture { location in
					viewModel.setCell(
						xCoordinate: location.x,
						yCoordinate: location.y,
						xOffset: xOffset,
						yOffset: yOffset,
						newCellType: viewModel.currentSelectedCellType
					)
                }
            }.padding()
		
			VStack {
				Text(
					LocalizedStringKey("cell-type-header")
				)
				.frame(maxWidth: .infinity, alignment: .leading)
				.bold()
				Picker(
					LocalizedStringKey("cell-type"),
					selection: $viewModel.currentSelectedCellType
				) {
					ForEach([CellType.start, CellType.target]) { cellType in
						Text(cellType.localizedStringKey).tag(cellType);
					}
				}
				.pickerStyle(.segmented)
				
				Spacer()
					.frame(height: 10)
			
				Text(LocalizedStringKey("queue-header"))
					.frame(maxWidth: .infinity, alignment: .leading)
					.bold()
				ScrollView(.horizontal) {
					HStack {
						Text(viewModel.queueString).lineLimit(1)
					}
				}
				
				Spacer()
					.frame(height: 10)
				
				Text(
					LocalizedStringKey("algorithm-speed-header")
				)
				.bold()
				.frame(maxWidth: .infinity, alignment: .leading)
				.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
				Slider(
					value: $viewModel.algorithmSpeed,
					in: 0.0...1.0,
					label: {Text(LocalizedStringKey("algorithm-speed-header"))},
					minimumValueLabel: {Text(LocalizedStringKey("slow"))},
					maximumValueLabel: {Text(LocalizedStringKey("fast"))}
				)
				
				if (viewModel.algorithmComplete) {
					Button(
						action: {
							viewModel.resetGridValues()
						}
					) {
						Text(LocalizedStringKey("reset-grid"))
					}
				}
				else {
					Button(
						action: {
							viewModel.startAlgorithm()
						}
					) {
						Text(LocalizedStringKey("start-algorithm"))
					}
					.disabled(
						viewModel.algorithmRunning ||
						viewModel.startIndices == (-1, -1) ||
						viewModel.targetIndices == (-1, -1)
					)
				}
			}.padding(
				EdgeInsets(
					top: CGFloat(0),
					leading: CGFloat(20),
					bottom: CGFloat(0),
					trailing: CGFloat(20)
				)
			)
		}
			.frame(
				maxWidth: .infinity,
				maxHeight: .infinity
			)
	}
	
	private func drawGrid(
		context: GraphicsContext,
		numberOfColumns: Int,
		numberOfRows: Int,
		xOffset: CGFloat = 0,
		yOffset: CGFloat = 0
	) {
		/*
		 * Draw Vertical Grid Lines
		 */
		for i in 0...numberOfColumns {
			if (i != numberOfColumns) {
				context.draw(
					Text(String(i)),
					at: CGPoint(
						x: (CGFloat(i) + 0.5) * (BfsPageConstants.squareSize + 1) + xOffset,
						y: CGFloat(yOffset / 2)
					)
				)
			}
			context.fill(
				Path(
					CGRect(
						origin: CGPoint(
							x: CGFloat(i) * (BfsPageConstants.squareSize + 1) + xOffset,
							y: yOffset
						),
						size: CGSize(
							width: 1,
							height: CGFloat(numberOfRows) * (BfsPageConstants.squareSize + 1)
						)
					)
				),
				with: .color (
					Color(
						uiColor: UIColor(named: "grid-line")!
					)
				)
			)
		}
		
		/*
		 * Draw Horizontal Grid Lines
		 */
		for i in 0...numberOfRows {
			if (i != numberOfRows) {
				context.draw(
					Text(String(i)),
					at: CGPoint(
						x: CGFloat(xOffset / 2),
						y: (CGFloat(i) + 0.5) * (BfsPageConstants.squareSize + 1) + yOffset
					)
				)
			}
			context.fill(
				Path(
					CGRect(
						origin: CGPoint(
							x: xOffset,
							y: CGFloat(i) * (BfsPageConstants.squareSize + 1) + yOffset
						),
						size: CGSize(
							width: CGFloat(numberOfColumns) * (BfsPageConstants.squareSize + 1),
							height: 1
						)
					)
				),
				with: .color (
					Color(
						uiColor: UIColor(named: "grid-line")!
					)
				)
			)
		}
	}
	
	private func drawCells(
		context: GraphicsContext,
		xOffset: CGFloat = 0,
		yOffset: CGFloat = 0
	) {
		for (rowIndex, row) in viewModel.grid.enumerated() {
			for (columnIndex, cell) in row.enumerated() {
				context.fill(
					Path(
						CGRect(
							origin: CGPoint(
								x: CGFloat(columnIndex) * (BfsPageConstants.squareSize + 1) + 1 + xOffset,
								y: CGFloat(rowIndex) * (BfsPageConstants.squareSize + 1) + 1 + yOffset
							),
							size: CGSize(
								width: BfsPageConstants.squareSize,
								height: BfsPageConstants.squareSize
							)
						)
					),
					with: .color(
						cell.color
					)
				)
			}
		}
	}
	
	private func getNumberOfColumns(width: Double) -> Int {
		return Int(
			floor(
				 width / (BfsPageConstants.squareSize + 1)
			)
		 ) - 1
	}
	
	private func getNumberOfRows(height: Double) -> Int {
		return Int(
			floor(
				 height / (BfsPageConstants.squareSize + 1)
			)
		 ) - 1
	}
	
	private func getXOffset(numberOfColumns: Int, width: Double) -> CGFloat {
		return (
			(width
			 - (CGFloat(numberOfColumns)
				* (BfsPageConstants.squareSize + 1)
			   )
			)
			/ 2
		)
	}
	private func getYOffset(numberOfRows: Int, height: Double) -> CGFloat {
		return (
			(height
			 - (CGFloat(numberOfRows)
				* (BfsPageConstants.squareSize + 1)
			   )
			)
			/ 2
		)
	}
}

struct BFSPageViewPreviews: PreviewProvider {
    static var previews: some View {
		BfsPageView(
			container: .constant(Container()),
			viewModel: BfsPageViewModel()
		)
    }
}
