//
//  ISettingsService.swift
//  Algorithm-Visualizer
//
//  Created by Min-Kyu Lee on 2023-08-22.
//

import Foundation
import SwiftUI

protocol ISettingsService {
	var darkThemeUseSettingDefault: AvObservable<Bool> { get set }	
	var darkThemeUserInput: AvObservable<Bool> { get set }
}
