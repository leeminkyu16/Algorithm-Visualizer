//
//  MainContainer.swift
//  Algorithm Visualizer
//
//  Created by Min-Kyu Lee on 2023-08-16.
//

import SwiftUI
import Swinject
import SwinjectAutoregistration

func getMainContainer() -> Container {
	let newContainer = Container()

	/**
	 * View Models
	 */
	newContainer.autoregister(BfsPageViewModel.self, initializer: BfsPageViewModel.init)
	newContainer.autoregister(HomePageViewModel.self, initializer: HomePageViewModel.init)
	newContainer.autoregister(MainNavigationViewModel.self, initializer: MainNavigationViewModel.init)
	newContainer.autoregister(SettingsPageViewModel.self, initializer: SettingsPageViewModel.init)

	/**
	 * Services
	 */
	newContainer.autoregister(INavigationService.self, initializer: NavigationService.init)
		.inObjectScope(.container)

	newContainer.autoregister(ISettingsService.self, initializer: SettingsService.init)
		.inObjectScope(.container)

	return newContainer
}
