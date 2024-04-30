//
//  Home_Page_ViewModel.swift
//  Algorithm Visualizer
//
//  Created by Min-Kyu Lee on 2023-08-18.
//

import Foundation
import SwiftUI

class HomePageViewModel: ObservableObject {
	@Published var navigationService: INavigationService

	init(navigationService: INavigationService) {
		self.navigationService = navigationService
	}

	func navigateToSettingsPage() {
		self.navigationService.navigateTo(navigationDestination: NavigationDestination.settings)
	}

	func navigateToBfsPage() {
		self.navigationService.navigateTo(navigationDestination: NavigationDestination.bfs)
	}
}
