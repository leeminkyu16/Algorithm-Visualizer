//
//  AvViewModel.swift
//  Algorithm-Visualizer
//
//  Created by Min-Kyu Lee on 2023-08-23.
//

import Foundation
import SwiftUI
import Combine

protocol AvViewModel: ObservableObject {
	associatedtype ViewState
	associatedtype Event: AvEvent

	var viewState: ViewState { get set }
	var viewStatePublisher: AnyPublisher<ViewState, Never> { get }
	var eventSubject: PassthroughSubject<Event, Never> { get set }

	var onDeinit: [() -> Void] { get set }
	var cancellables: Set<AnyCancellable> { get set }
}

extension Publisher where Self.Failure == Never {
	func safeSink(
		on viewModel: any AvViewModel,
		receiveValue: @escaping ((Self.Output) -> Void)
	) {
		self.sink(receiveValue: receiveValue)
			.store(in: &viewModel.cancellables)
	}
}
