//
//  NavigationService.swift
//  Algorithm Visualizer
//
//  Created by Min-Kyu Lee on 2023-08-18.
//

import Foundation
import SwiftUI

class NavigationService: ObservableObject, INavigationService {
	init() {
	}
	
	@Published var navigationPath: NavigationPath = NavigationPath()
	var navigationPathPublished: Published<NavigationPath> { _navigationPath }
	var navigationPathPublisher: Published<NavigationPath>.Publisher { $navigationPath }
	
	func navigateTo(navigationDestination: NavigationDestination) {
		navigationPath.append(navigationDestination)
	}
}
