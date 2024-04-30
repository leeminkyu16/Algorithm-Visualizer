//
//  SettingsPageViewModel.swift
//  Algorithm-Visualizer
//
//  Created by Min-Kyu Lee on 2023-08-22.
//

import Foundation
import SwiftUI
import Combine

class SettingsPageViewModel: AvViewModel {
	typealias ViewState = Any?

	typealias Event = BaseEvent

	var viewState: Any?
	var viewStatePublisher: AnyPublisher<Any?, Never> = Empty().eraseToAnyPublisher()
	var eventSubject: PassthroughSubject<BaseEvent, Never> = .init()

	var cancellables: Set<AnyCancellable> = .init()
	var onDeinit: [() -> Void] = []

	@Published var settingsService: ISettingsService
	@Published var darkThemeUserInputBinding: Binding<Bool>

	@Published var darkThemeUseSystemDefault: Bool

	init(settingsService: ISettingsService) {
		self.settingsService = settingsService
		self.darkThemeUserInputBinding = settingsService.darkThemeUserInput.getBinding()
		self.darkThemeUseSystemDefault = settingsService.darkThemeUseSettingDefault.value

		settingsService.darkThemeUseSettingDefault.addOnChange(
			newOnChange: { [weak self] newValue in
				withAnimation {
					self?.darkThemeUseSystemDefault = newValue
				}
			},
			viewModel: self
		)
	}
}
