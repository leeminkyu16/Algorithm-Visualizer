//
//  MainNavigationView.swift
//  Algorithm Visualizer
//
//  Created by Min-Kyu Lee on 2023-08-16.
//

import SwiftUI
import Swinject

struct MainNavigationView: View {
	@Binding var container: Container
	@ObservedObject var viewModel: MainNavigationViewModel
	@Environment(\.originalColorScheme) var originalColorScheme
	
	var body: some View {
		NavigationStack(path: $viewModel.navigationPath) {
			List {
				NavigationLink("home", value: NavigationDestination.home)
				NavigationLink("bfs", value: NavigationDestination.bfs)
			}
				.navigationDestination(for: NavigationDestination.self) { navigationDestination in
					switch(navigationDestination) {
					case NavigationDestination.home:
						HomePageView(
							container: $container,
							viewModel: container.resolve(HomePageViewModel.self)!
						)
						.navigationBarBackButtonHidden(true)
					case NavigationDestination.bfs:
						BfsPageView(container: $container, viewModel: container.resolve(BfsPageViewModel.self)!)
							.navigationBarTitleDisplayMode(.inline)
							.navigationTitle(LocalizedStringKey("bfs-page-title"))
					case NavigationDestination.settings:
						SettingsPageView(
							container: $container,
							viewModel: container.resolve(SettingsPageViewModel.self)!
						)
						.navigationBarTitleDisplayMode(.inline)
						.navigationTitle(LocalizedStringKey("settings-page-title"))
					}
				}
				.hidden()
		}
		.preferredColorScheme(
			viewModel.darkThemeUseSystemDefault ?
			originalColorScheme
			: (viewModel.darkThemeUserInput ?
				.dark
				: .light
			)
		)
	}
}
