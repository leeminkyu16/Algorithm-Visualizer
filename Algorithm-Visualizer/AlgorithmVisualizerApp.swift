//
//  AlgorithmVisualizerApp.swift
//  Algorithm Visualizer
//
//  Created by Min-Kyu Lee on 2023-05-03.
//

import SwiftUI
import Swinject

@main
struct AlgorithmVisualizerApp: App {
	@State var container: Container = getMainContainer()
	@Environment(\.colorScheme) var colorScheme
	
    var body: some Scene {
        WindowGroup {
			MainNavigationView(
				container: self.$container,
				viewModel: container.resolve(MainNavigationViewModel.self)!
			)
			.environment(\.originalColorScheme, colorScheme)
        }
    }
}
