//
//  SettingsPageViewModel.swift
//  Algorithm-Visualizer
//
//  Created by Min-Kyu Lee on 2023-08-22.
//

import Foundation
import SwiftUI

class SettingsPageViewModel: AvViewModel {
	@Published var settingsService: ISettingsService
	@Published var darkThemeUserInputBinding: Binding<Bool>
	
	@Published var darkThemeUseSystemDefault: Bool
	
	init(settingsService: ISettingsService) {
		self.settingsService = settingsService
		self.darkThemeUserInputBinding = settingsService.darkThemeUserInput.getBinding()
		self.darkThemeUseSystemDefault = settingsService.darkThemeUseSettingDefault.value
		super.init()
		
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
