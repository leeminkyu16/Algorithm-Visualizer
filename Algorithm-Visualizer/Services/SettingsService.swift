//
//  SettingsService.swift
//  Algorithm-Visualizer
//
//  Created by Min-Kyu Lee on 2023-08-22.
//

import Foundation
import SwiftUI

class SettingsService: ISettingsService {
	// Default Value is inverted to ensure that the first time app default is true
	var darkThemeUseSettingDefault: AvObservable<Bool> = AvObservable(
		defaultValue: !UserDefaults.standard.bool(forKey: DARK_THEME_USE_SETTING_DEFAULT_KEY)
	)
	var darkThemeUserInput: AvObservable<Bool> = AvObservable(
		defaultValue: !UserDefaults.standard.bool(forKey: DARK_THEME_USE_INPUT_KEY)
	)
	
	init() {
		let _ = darkThemeUseSettingDefault.addOnChange { newValue in
			UserDefaults.standard.set(
				!newValue,
				forKey: DARK_THEME_USE_SETTING_DEFAULT_KEY
			)
		}
		
		let _ = darkThemeUserInput.addOnChange { newValue in
			UserDefaults.standard.set(
				!newValue,
				forKey: DARK_THEME_USE_INPUT_KEY
			)
		}
	}
}
fileprivate let DARK_THEME_USE_INPUT_KEY: String = "DARK_THEME_USE_INPUT_KEY"
fileprivate let DARK_THEME_USE_SETTING_DEFAULT_KEY: String = "DARK_THEME_USE_SETTING_DEFAULT_KEY"
