//
//  MainContainer.swift
//  Algorithm Visualizer
//
//  Created by Min-Kyu Lee on 2023-08-16.
//

import SwiftUI
import Swinject

func getMainContainer() -> Container {
	let newContainer = Container()
	
	/**
	 * View Models
	 */
	newContainer.register(BfsPageViewModel.self, factory: { _ in BfsPageViewModel()})
	newContainer.register(
		HomePageViewModel.self) { r in
			HomePageViewModel(
				navigationService: r.resolve(INavigationService.self)!
			)
		}
	newContainer.register(MainNavigationViewModel.self) { r in
		MainNavigationViewModel(
			navigationService: r.resolve(INavigationService.self)!,
			settingsService: r.resolve(ISettingsService.self)!
		)
	}
	newContainer.register(SettingsPageViewModel.self) { r in
		SettingsPageViewModel(
			settingsService: r.resolve(ISettingsService.self)!
		)
	}
	
	/**
	 * Services
	 */
	newContainer.register(INavigationService.self) { _ in
		NavigationService()
	}
	.inObjectScope(.container)
	
	newContainer.register(ISettingsService.self) { _ in
		SettingsService()
	}
	.inObjectScope(.container)
	
	return newContainer
}
