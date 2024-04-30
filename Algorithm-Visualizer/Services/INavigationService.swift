//
//  INavigationService.swift
//  Algorithm Visualizer
//
//  Created by Min-Kyu Lee on 2023-08-18.
//

import Foundation
import SwiftUI

protocol INavigationService {
	var navigationPath: NavigationPath { get set }
	var navigationPathPublished: Published<NavigationPath> { get }
	var navigationPathPublisher: Published<NavigationPath>.Publisher { get }

	func navigateTo(navigationDestination: NavigationDestination)
}
