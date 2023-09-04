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
					.onAppear() {
						self.topSpacing = proxy.size.height * 0.099
						withAnimation(.easeInOut(duration: 5)) {
							self.topSpacing = proxy.size.height * 0.1
						}
					}
				Text(LocalizedStringKey("algorithm-visualizer"))
					.font(.largeTitle)
					.fontWeight(.bold)
					.foregroundLinearGradient(
						colors: [
							Color(UIColor(named: "title-highlight-text")!),
							Color(UIColor(named: "primary-text")!)
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
							LocalizedStringKey("bfs-page-title")
						)
						.foregroundColor(Color(uiColor: UIColor(named: "primary-text")!))
						.frame(maxWidth: .infinity)
					}
				)
				.padding(CGFloat(10))
				.foregroundColor(
					Color(UIColor(named: "primary-text")!)
				)
				.background(
					Color(UIColor(named: "background")!)
				)
				.cornerRadius(CGFloat(25))
				.shadow(color: Color(uiColor: UIColor(named: "primary-shadow")!), radius: CGFloat(3))
				
				Spacer()
					.frame(maxHeight: proxy.size.height * 0.03)
				Button(
					action: {
						viewModel.navigateToSettingsPage()
					},
					label: {
						Text(
							LocalizedStringKey("settings-page-title")
						)
						.foregroundColor(Color(uiColor: UIColor(named: "primary-text")!))
						.frame(maxWidth: .infinity)
					}
				)
				.padding(CGFloat(10))
				.foregroundColor(
					Color(UIColor(named: "primary-text")!)
				)
				.background(
					Color(UIColor(named: "background")!)
				)
				.cornerRadius(CGFloat(25))
				.shadow(color: Color(uiColor: UIColor(named: "primary-shadow")!), radius: CGFloat(3))
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
