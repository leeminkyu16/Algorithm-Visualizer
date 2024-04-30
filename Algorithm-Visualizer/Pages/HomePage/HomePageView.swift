//
//  Home_Page_View.swift
//  Algorithm Visualizer
//
//  Created by Min-Kyu Lee on 2023-08-18.
//

import Foundation
import SwiftUI
import Swinject

struct HomePageView: View {
	@Binding var container: Container
	@ObservedObject var viewModel: HomePageViewModel
	@State var topSpacing: CGFloat = 0
	@State var animateTitleGradient: Bool = true

	var body: some View {
		GeometryReader { proxy in
			VStack {
				Spacer()
					.frame(
						maxHeight: topSpacing
					)
					.onAppear {
						self.topSpacing = proxy.size.height * 0.099
						withAnimation(.easeInOut(duration: 5)) {
							self.topSpacing = proxy.size.height * 0.1
						}
					}
				Text(L10n.algorithmVisualizer)
					.font(.largeTitle)
					.fontWeight(.bold)
					.foregroundLinearGradient(
						colors: [
							Asset.Colors.titleHighlightText.swiftUIColor,
							Asset.Colors.primaryText.swiftUIColor
						],
						startPoint: animateTitleGradient ? .topLeading : .bottomTrailing,
						endPoint: animateTitleGradient ? .bottomTrailing : .topLeading
					)
					.animation(.easeInOut(duration: 10).repeatForever(), value: self.animateTitleGradient)
					.onTapGesture {
						animateTitleGradient.toggle()
					}

				Spacer()
					.frame(maxHeight: proxy.size.height * 0.075)
				Button(
					action: {
						viewModel.navigateToBfsPage()
					},
					label: {
						Text(
							L10n.bfsPageTitle
						)
						.foregroundColor(Asset.Colors.primaryText.swiftUIColor)
						.frame(maxWidth: .infinity)
					}
				)
				.padding(CGFloat(10))
				.foregroundColor(
					Asset.Colors.primaryText.swiftUIColor
				)
				.background(
					Asset.Colors.background.swiftUIColor
				)
				.cornerRadius(CGFloat(25))
				.shadow(
					color: Asset.Colors.primaryShadow.swiftUIColor,
					radius: CGFloat(3)
				)

				Spacer()
					.frame(maxHeight: proxy.size.height * 0.03)
				Button(
					action: {
						viewModel.navigateToSettingsPage()
					},
					label: {
						Text(
							L10n.settingsPageTitle
						)
						.foregroundColor(
							Asset.Colors.primaryText.swiftUIColor
						)
						.frame(maxWidth: .infinity)
					}
				)
				.padding(CGFloat(10))
				.foregroundColor(
					Asset.Colors.primaryText.swiftUIColor
				)
				.background(
					Asset.Colors.background.swiftUIColor
				)
				.cornerRadius(CGFloat(25))
				.shadow(
					color: Asset.Colors.primaryShadow.swiftUIColor,
					radius: CGFloat(3)
				)
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

struct HomePageViewPreviews: PreviewProvider {
	static var previews: some View {
		HomePageView(
			container: .constant(Container()),
			viewModel: HomePageViewModel(
				navigationService: NavigationService()
			)
		)
	}
}
