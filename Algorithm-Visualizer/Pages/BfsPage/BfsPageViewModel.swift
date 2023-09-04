//
//  ContentViewModel.swift
//  Algorithm Visualizer
//
//  Created by Min-Kyu Lee on 2023-05-03.
//

import Foundation

class BfsPageViewModel: ObservableObject {
    @Published var grid: [[CellType]] = []
    @Published var currentSelectedCellType: CellType = CellType.start
	
	@Published var algorithmRunning = false
	@Published var algorithmComplete = false
	
	@Published var startIndices: (Int, Int) = (-1, -1)
	@Published var targetIndices: (Int, Int) = (-1, -1)
	
	@Published var algorithmSpeed = 0.5
	
	@Published var queueString = "[]";
	
    func initGrid(numOfColumns: Int, numOfRows: Int) {
		DispatchQueue.global(qos: .background).async {
			var newGrid: [[CellType]] = []
			for i in 0..<numOfRows {
				newGrid.append([])
				for _ in 0..<numOfColumns {
					newGrid[i].append(CellType.notVisited)
				}
			}
			DispatchQueue.main.async {
				self.grid = newGrid
				self.algorithmComplete = false
			}
		}
    }
	
	func resetGridValues() {
		DispatchQueue.global(qos: .background).async {
			var newGrid: [[CellType]] = []
			for i in 0..<self.grid.count {
				newGrid.append([])
				for _ in 0..<((self.grid.first ?? []).count) {
					newGrid[i].append(CellType.notVisited)
				}
			}
			
			DispatchQueue.main.async {
				self.grid = newGrid
				self.startIndices = (-1, -1)
				self.targetIndices = (-1, -1)
				self.algorithmRunning = false
				self.algorithmComplete = false
				self.queueString = "[]"
			}
		}
		
	}
	
	func setCell(
		xCoordinate: CGFloat,
		yCoordinate: CGFloat,
		xOffset: CGFloat,
		yOffset: CGFloat,
		newCellType: CellType
	) {
		DispatchQueue.global(qos: .background).async {
			if (!self.algorithmRunning && !self.algorithmComplete) {
				let xIndex = BfsPageConstants.coordinateToIndex(coordinate: xCoordinate, offset: xOffset)
				let yIndex = BfsPageConstants.coordinateToIndex(coordinate: yCoordinate, offset: yOffset)
				if (
					0 <= xIndex &&
					0 <= yIndex &&
					yIndex < self.grid.count &&
					xIndex < (self.grid.first ?? []).count
				) {
					DispatchQueue.main.async {
						switch newCellType {
						case CellType.start:
							if (self.startIndices != (-1, -1)) {
								self.grid[self.startIndices.1][self.startIndices.0] = CellType.notVisited
							}
							self.startIndices = (xIndex, yIndex)
							break
						case CellType.target:
							if (self.targetIndices != (-1, -1)) {
								self.grid[self.targetIndices.1][self.targetIndices.0] = CellType.notVisited
							}
							self.targetIndices = (xIndex, yIndex)
							break
						default:
							break
						}
						self.grid[yIndex][xIndex] = newCellType
					}
				}
			}
		}
	}
	
	func startAlgorithm() {
		DispatchQueue.main.async {
			self.algorithmRunning = true
		}
		DispatchQueue.global(qos: .background).async {
			self.breadthFirstSearch()
			DispatchQueue.main.async {
				self.algorithmComplete = true
				self.algorithmRunning = false
			}
		}
	}
	
	private func breadthFirstSearch() {
		var queue: [(Int, Int)] = [self.startIndices]
		var targetVisited: Bool = false
		while (!targetVisited && !queue.isEmpty) {
			var gridCopy: [[CellType]] = getDeepCopyGrid()
			
			let currentElement: (Int, Int) = queue.removeFirst()
			[
				(currentElement.0 - 1, currentElement.1),
				(currentElement.0, currentElement.1 - 1),
				(currentElement.0 + 1, currentElement.1),
				(currentElement.0, currentElement.1 + 1)
			].forEach { testElement in
				if (
					validIndices(gridParam: gridCopy, xIndex: testElement.0, yIndex: testElement.1)
				) {
					if (gridCopy[testElement.1][testElement.0] != CellType.target) {
						gridCopy[testElement.1][testElement.0] = CellType.toBeVisited
					}
					queue.append(testElement)
				}
			}
			
			if (
				currentElement.0 == targetIndices.0 &&
				currentElement.1 == targetIndices.1
			) {
				targetVisited = true
			}
			else if (gridCopy[currentElement.1][currentElement.0] == CellType.toBeVisited) {
				gridCopy[currentElement.1][currentElement.0] = CellType.visited
			}
			
			let newQueueString = getQueueString(queue: queue);
			DispatchQueue.main.sync {
				self.grid = gridCopy
				self.queueString = newQueueString
			}
			Thread.sleep(forTimeInterval: (1.005 - algorithmSpeed))
		}
	}
	
	private func getDeepCopyGrid() -> [[CellType]] {
		return self.grid.map { cellTypeArray in
			cellTypeArray.map { cellType in
				cellType
			}
		}
	}
	
	private func getQueueString(queue: [(Int, Int)]) -> String {
		return queue.description
	}
	
	private func validIndices(gridParam: [[CellType]], xIndex: Int, yIndex: Int) -> Bool {
		return 0 <= yIndex && yIndex < gridParam.count &&
			0 <= xIndex && xIndex < (gridParam.first ?? []).count &&
			(gridParam[yIndex][xIndex] == CellType.notVisited ||
			gridParam[yIndex][xIndex] == CellType.target)
	}
}
