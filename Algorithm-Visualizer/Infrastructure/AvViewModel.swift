//
//  AvViewModel.swift
//  Algorithm-Visualizer
//
//  Created by Min-Kyu Lee on 2023-08-23.
//

import Foundation
import SwiftUI

class AvViewModel: ObservableObject {
	var onDeinit: [() -> Void] = [() -> Void].init()
	
	deinit {
		onDeinit.forEach { deinitFunc in
			deinitFunc()
		}
	}
}
