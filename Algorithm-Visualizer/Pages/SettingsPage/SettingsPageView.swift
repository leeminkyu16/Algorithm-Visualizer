//
//  SettingsPageView.swift
//  Algorithm-Visualizer
//
//  Created by Min-Kyu Lee on 2023-08-22.
//

import Foundation
import SwiftUI
import Swinject

struct SettingsPageView: View {
	@Binding var container: Container
	@ObservedObject var viewModel: SettingsPageViewModel
	@Environment(\.originalColorScheme) var originalColorScheme

	var body: some View {
		GeometryReader { proxy in
			VStack {
				Spacer()
					.frame(maxHeight: proxy.size.height * 0.05)
				HStack {
					Text(L10n.darkTheme)
						.font(.subheadline)
				}
				.frame(
					maxWidth: .infinity,
					alignment: .leading
				)
				Toggle(L10n.useSystemDefault, isOn: Binding(
					get: {
						viewModel.settingsService.darkThemeUseSettingDefault.value
					},
					set: { newValue in
						viewModel.settingsService.darkThemeUserInput.value = originalColorScheme == .dark
						viewModel.settingsService.darkThemeUseSettingDefault.value = newValue
					}
				))
				if !viewModel.darkThemeUseSystemDefault {
					Toggle(
						L10n.useDarkTheme,
						isOn: viewModel.darkThemeUserInputBinding
					)
					.transition(.slide)
				}
			}
			.padding(
				EdgeInsets(
					top: CGFloat(0),
					leading: CGFloat(20),
					bottom: CGFloat(0),
					trailing: CGFloat(20)
				)
			)
			.frame(
				maxWidth: .infinity,
				maxHeight: .infinity,
				alignment: .top
			)
		}
	}
}
