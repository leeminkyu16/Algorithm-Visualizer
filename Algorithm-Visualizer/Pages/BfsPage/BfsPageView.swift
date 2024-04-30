//
//  BFS_Page_View.swift
//  Algorithm Visualizer
//
//  Created by Min-Kyu Lee on 2023-05-03.
//

import SwiftUI
import Swinject

struct BfsPageView: AvView {
	@Binding var container: Container
	@ObservedObject var viewModel: BfsPageViewModel

    var body: some View {
		switch viewModel.viewState {
		case BfsPageViewState.Loading:
			ProgressView()
		case BfsPageViewState.Loaded(let viewState):
			VStack(alignment: .center) {
				AvGrid(
					grid: viewState.colorGrid,
					squareSize: BfsPageConstants.squareSize,
					onTap: { [weak viewModel] xIndex, yIndex in
						guard let viewModel else { return }

						viewModel.eventSubject.send(
							BfsPageEvent(.CellTapped(xIndex, yIndex))
						)
					},
					onResize: { [weak viewModel] numberOfColumns, numberOfRows in
						guard let viewModel else { return }

						viewModel.eventSubject.send(
							BfsPageEvent(.GridResized(numberOfColumns, numberOfRows))
						)
					}
				)
				.padding()

				VStack {
					Text(
						L10n.cellTypeHeader
					)
					.frame(maxWidth: .infinity, alignment: .leading)
					.bold()
					Picker(
						L10n.cellType,
						selection: .init(
							get: {
								viewState.currentSelectedCellType
							},
							set: { newSelection in
								viewModel.eventSubject.send(
									BfsPageEvent(.CellTypeSelected(newSelection))
								)
							}
						)
					) {
						ForEach([CellType.start, CellType.target]) { cellType in
							Text(cellType.localizedStringKey).tag(cellType)
						}
					}
					.pickerStyle(.segmented)

					Spacer()
						.frame(height: 10)

					Text(L10n.queueHeader)
						.frame(maxWidth: .infinity, alignment: .leading)
						.bold()
					ScrollView(.horizontal) {
						HStack {
							Text(viewState.queueString).lineLimit(1)
						}
					}

					Spacer()
						.frame(height: 10)

					Text(
						L10n.algorithmSpeedHeader
					)
					.bold()
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
					Slider(
						value: .init(get: {
							viewState.algorithmSpeed
						}, set: { newAlgorithmSpeed in
							viewModel.eventSubject.send(
								BfsPageEvent(.AlgorithmSpeedChanged(newAlgorithmSpeed))
							)
						}),
						in: 0.0...1.0,
						label: {
							Text(L10n.algorithmSpeedHeader)
						},
						minimumValueLabel: {Text(L10n.slow)},
						maximumValueLabel: {Text(L10n.fast)}
					)

					if viewState.algorithmComplete {
						Button(
							action: {
								viewModel.eventSubject.send(.init(.ResetTapped))
							}
						) {
							Text(L10n.resetGrid)
						}
					} else {
						Button(
							action: {
								viewModel.eventSubject.send(.init(.StartTapped))
							}
						) {
							Text(L10n.startAlgorithm)
						}
						.disabled(
							viewState.algorithmRunning ||
							viewState.startIndices == (-1, -1) ||
							viewState.targetIndices == (-1, -1)
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
