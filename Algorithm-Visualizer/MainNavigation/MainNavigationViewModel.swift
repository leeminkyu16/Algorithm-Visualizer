//
//  Main_Navigation_ViewModel.swift
//  Algorithm Visualizer
//
//  Created by Min-Kyu Lee on 2023-08-18.
//

import Foundation
import SwiftUI

class MainNavigationViewModel: AvViewModel {
	@Published var navigationService: INavigationService
	@Published var navigationPath: NavigationPath
	
	@Published var settingsService: ISettingsService
	@Published var darkThemeUseSystemDefault: Bool
	@Published var darkThemeUserInput: Bool 
		
	init(
		navigationService: INavigationService,
		settingsService: ISettingsService
	) {
		self.navigationService = navigationService
		self.settingsService = settingsService
		self.navigationPath = navigationService.navigationPath
		self.darkThemeUseSystemDefault = settingsService.darkThemeUseSettingDefault.value
		self.darkThemeUserInput = settingsService.darkThemeUserInput.value
		super.init()

		self.$navigationPath = navigationService.navigationPathPublisher
		self._navigationPath = navigationService.navigationPathPublished
		
		self.settingsService.darkThemeUseSettingDefault.addOnChange(
			newOnChange: { [weak self] newValue in
				self?.darkThemeUseSystemDefault = newValue
			},
			viewModel: self
		)
		self.settingsService.darkThemeUserInput.addOnChange(
			newOnChange: { [weak self] newValue in
				self?.darkThemeUserInput = newValue
			},
			viewModel: self
		)
		
		self.navigationPath.append(NavigationDestination.home)
	}
}
