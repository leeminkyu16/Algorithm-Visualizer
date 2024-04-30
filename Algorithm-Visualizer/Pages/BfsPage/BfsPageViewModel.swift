//
//  BfsPageViewModel.swift
//  Algorithm Visualizer
//
//  Created by Min-Kyu Lee on 2023-05-03.
//

import Foundation
import SwiftUI
import Combine

class BfsPageViewModel: AvViewModel {
	typealias ViewState = BfsPageViewState
	typealias Event = BfsPageEvent

	@Published var viewState: BfsPageViewState = BfsPageViewState.Loaded(
		BfsPageViewStateLoaded(
			colorGrid: [],
			currentSelectedCellType: CellType.start,
			startIndices: (-1, -1),
			targetIndices: (-1, -1)
		)
	)

	private let internalViewStateSubject: CurrentValueSubject<BfsPageViewState, Never> = CurrentValueSubject(
		BfsPageViewState.Loaded(
			.init(
				colorGrid: [],
				currentSelectedCellType: CellType.start,
				startIndices: (-1, -1),
				targetIndices: (-1, -1)
			)
		)
	)

	var viewStatePublisher: AnyPublisher<BfsPageViewState, Never> {
		get {
			internalViewStateSubject.eraseToAnyPublisher()
		}
	}

	var eventSubject: PassthroughSubject<BfsPageEvent, Never> = .init()

	internal var onDeinit: [() -> Void] = .init()
	internal var cancellables: Set<AnyCancellable> = .init()

	private let gridSubject: CurrentValueSubject<[[CellType]], Never> = CurrentValueSubject([])
	private let colorGridSubject: CurrentValueSubject<[[Color]], Never> = CurrentValueSubject([])
	private let currentSelectedCellTypeSubject: CurrentValueSubject<CellType, Never> = CurrentValueSubject(.start)

	private let algorithmRunning: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false)
	private let algorithmComplete: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false)

	private let startIndices: CurrentValueSubject<(Int, Int), Never> = CurrentValueSubject((-1, -1))
	private let targetIndices: CurrentValueSubject<(Int, Int), Never> = CurrentValueSubject((-1, -1))

	private let algorithmSpeed: CurrentValueSubject<Double, Never> = CurrentValueSubject(0.5)

	private let queueString: CurrentValueSubject<String, Never> = CurrentValueSubject("[]")
	init() {
		self.colorGridSubject
			.combineLatest(
				currentSelectedCellTypeSubject,
				algorithmRunning,
				algorithmComplete,
				startIndices,
				targetIndices,
				algorithmSpeed,
				queueString
			)
			.receive(on: DispatchQueue.global(qos: .userInteractive))
			.safeSink(on: self) { [weak self] parameters in
				guard let self else { return }

				self.internalViewStateSubject.send(
					BfsPageViewState.Loaded(
						.init(
							colorGrid: parameters.0,
							currentSelectedCellType: parameters.1,
							algorithmRunning: parameters.2,
							algorithmComplete: parameters.3,
							startIndices: parameters.4,
							targetIndices: parameters.5,
							algorithmSpeed: parameters.6,
							queueString: parameters.7
						)
					)
				)
			}

		self.gridSubject
			.receive(
				on: DispatchQueue.global(qos: .userInteractive)
			)
			.safeSink(on: self) { [weak self] newGrid in
				guard let self else { return }

				self.colorGridSubject.send(newGrid.toColorArray())
			}

		self.viewStatePublisher
			.receive(on: DispatchQueue.main)
			.safeSink(on: self) { [weak self] newViewState in
				guard let self else { return }

				self.viewState = newViewState
			}

		self.eventSubject
			.combineLatest(self.internalViewStateSubject)
			.receive(on: DispatchQueue.global(qos: .userInteractive))
			.removeDuplicates {
				return $0.0 == $1.0
			}
			.safeSink(on: self) { [weak self] event, oldViewState in
				guard let self else { return }

				switch event.value {
				case .CellTypeSelected(let newCellType):
					self.currentSelectedCellTypeSubject.send(newCellType)
				case .CellTapped(let xIndex, let yIndex):
					switch oldViewState {
					case .Loaded(let oldLoadedViewState):
						self.setCell(
							xIndex: xIndex,
							yIndex: yIndex,
							newCellType: oldLoadedViewState.currentSelectedCellType
						)
					default:
						break
					}
				case .GridResized(let numberOfColumns, let numberOfRows):
					self.initGrid(numOfColumns: numberOfColumns, numOfRows: numberOfRows)
				case .StartTapped:
					self.startAlgorithm()
				case .ResetTapped:
					switch oldViewState {
					case .Loaded(let oldLoadedViewState):
						self.resetGridValues(oldGrid: oldLoadedViewState.colorGrid)
					default:
						break
					}
				case .AlgorithmSpeedChanged(let newAlgorithmSpeed):
					self.algorithmSpeed.send(newAlgorithmSpeed)
				}
			}
	}

    private func initGrid(numOfColumns: Int, numOfRows: Int) {
		Just((numOfColumns, numOfRows))
			.receive(on: DispatchQueue.global(qos: .background))
			.map({ (numberOfColumns, numberOfRows) in
				var newGrid: [[CellType]] = []
				for i in 0..<numberOfRows {
					newGrid.append([])
					for _ in 0..<numberOfColumns {
						newGrid[i].append(CellType.notVisited)
					}
				}

				return newGrid
			})
			.safeSink(
				on: self
			) { [weak self] newGrid in
				guard let self else { return }

				self.gridSubject.send(newGrid)
				self.algorithmComplete.send(false)
			}
    }

	private func resetGridValues(oldGrid: [[Color]]) {
		Just(())
			.receive(on: DispatchQueue.global(qos: .background))
			.safeSink(on: self) { [weak self] _ in
				guard let self else { return }

				var newGrid: [[CellType]] = []
				for i in 0..<oldGrid.count {
					newGrid.append([])
					for _ in 0..<((oldGrid.first ?? []).count) {
						newGrid[i].append(CellType.notVisited)
					}
				}

				self.gridSubject.send(newGrid)
				self.currentSelectedCellTypeSubject.send(.start)
				self.startIndices.send((-1, -1))
				self.targetIndices.send((-1, -1))
				self.queueString.send("[]")
				self.algorithmComplete.send(false)
		}
	}

	private func setCell(
		xIndex: Int,
		yIndex: Int,
		newCellType: CellType
	) {
		Just((xIndex, yIndex, newCellType))
			.combineLatest(
				gridSubject,
				algorithmRunning,
				algorithmComplete,
				algorithmSpeed,
				startIndices,
				targetIndices
			)
			.removeDuplicates(by: {$0.0 == $1.0})
			.safeSink(on: self) { [weak self]
				_,
				grid,
				algorithmRunning,
				algorithmComplete,
				_,
				startIndices,
				targetIndices in

				guard let self else { return }

				if !algorithmRunning && !algorithmComplete {
					if 0 <= xIndex &&
						0 <= yIndex &&
						yIndex < grid.count &&
						xIndex < (grid.first ?? []).count {
						var newGrid = grid

						switch newCellType {
						case CellType.start:
							if startIndices != (-1, -1) {
								newGrid[startIndices.1][startIndices.0] = .notVisited
							}
							self.startIndices.send((xIndex, yIndex))
						case CellType.target:
							if self.targetIndices.value != (-1, -1) {
								newGrid[targetIndices.1][targetIndices.0] = .notVisited
							}
							self.targetIndices.send((xIndex, yIndex))
						default:
							break
						}
						newGrid[yIndex][xIndex] = newCellType

						self.gridSubject.send(newGrid)
					}
				}
			}
	}

	private func startAlgorithm() {
		DispatchQueue.global(qos: .userInteractive).async {
			self.algorithmRunning.send(true)
			self.breadthFirstSearch()
			self.algorithmComplete.send(true)
			self.algorithmRunning.send(false)
		}
	}

	private func breadthFirstSearch() {
		var grid: [[CellType]] = gridSubject.value
		var queue: [(Int, Int)] = [self.startIndices.value]
		var targetVisited: Bool = false
		let targetIndices = targetIndices.value
		while !targetVisited && !queue.isEmpty {
			let currentElement: (Int, Int) = queue.removeFirst()
			[
				(currentElement.0 - 1, currentElement.1),
				(currentElement.0, currentElement.1 - 1),
				(currentElement.0 + 1, currentElement.1),
				(currentElement.0, currentElement.1 + 1)
			].forEach { testElement in
				if validIndices(gridParam: grid, xIndex: testElement.0, yIndex: testElement.1) {
					if grid[testElement.1][testElement.0] != CellType.target {
						grid[testElement.1][testElement.0] = CellType.toBeVisited
					}
					queue.append(testElement)
				}
			}

			if currentElement.0 == targetIndices.0 &&
				currentElement.1 == targetIndices.1 {
				targetVisited = true
			} else if grid[currentElement.1][currentElement.0] == CellType.toBeVisited {
				grid[currentElement.1][currentElement.0] = CellType.visited
			}

			let newQueueString = getQueueString(queue: queue)

			self.gridSubject.send(grid)
			self.queueString.send(newQueueString)

			Thread.sleep(forTimeInterval: (1.005 - algorithmSpeed.value))
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

extension Array where Element == [CellType] {
	func toColorArray() -> [[Color]] {
		return self.map { cellTypeArray in
			return cellTypeArray.map { cellTypeValue in
				return cellTypeValue.color
			}
		}
	}
}
