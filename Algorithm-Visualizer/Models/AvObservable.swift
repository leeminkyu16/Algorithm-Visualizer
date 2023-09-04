//
//  AvObservable.swift
//  Algorithm-Visualizer
//
//  Created by Min-Kyu Lee on 2023-08-23.
//

import Foundation
import SwiftUI

class AvObservable<Element> {
	init(defaultValue: Element) {
		internalValue = defaultValue
	}
	
	private var internalValue: Element
	var value: Element {
		get {
			internalValue
		}
		set {
			internalValue = newValue
			internalOnChangeFunctions.forEach { _, onChangeFunc in
				onChangeFunc(newValue)
			}
		}
	}
	private var internalOnChangeFunctions: [String: (Element) -> Void] = [String: (Element) -> Void].init()
	
	func addOnChange(
		newOnChange: @escaping ((Element) -> Void),
		viewModel: AvViewModel
	) {
		viewModel.onDeinit.append(
			self.addOnChange(newOnChange: newOnChange)
		)
	}
	
	func addOnChange(newOnChange: @escaping (Element) -> Void) -> (() -> Void) {
		let key = UUID().uuidString
		self.internalOnChangeFunctions.updateValue(newOnChange, forKey: key)
		
		return { [weak self] in
			self?.internalOnChangeFunctions.removeValue(forKey: key)
		}
	}
	
	func getBinding() -> Binding<Element> {
		return Binding(
			get: {
				self.value
			},
			set: { newValue in
				self.value = newValue
			}
		)
	}
}
