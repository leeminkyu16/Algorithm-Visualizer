//
//  CellType.swift
//  Algorithm Visualizer
//
//  Created by Min-Kyu Lee on 2023-05-03.
//

import Foundation
import SwiftUI

struct CellType: RawRepresentable, Equatable, Hashable, Identifiable {
	var rawValue: String
	let localizedStringKey: LocalizedStringKey
	let color: Color
	
	init?(rawValue: String) {
		switch(rawValue) {
		case CellType.start.rawValue:
			self = CellType.start;
		case CellType.target.rawValue:
			self = CellType.target;
		case CellType.visited.rawValue:
			self = CellType.visited;
		case CellType.toBeVisited.rawValue:
			self = CellType.toBeVisited;
		case CellType.notVisited.rawValue:
			self = CellType.notVisited;
		default:
			return nil;
		}
	}
	
	init(rawValue: String, localizedStringKey: LocalizedStringKey, color: Color) {
		self.rawValue = rawValue
		self.localizedStringKey = localizedStringKey
		self.color = color
	}
	
	static let start = CellType(
		rawValue: "start",
		localizedStringKey: LocalizedStringKey("start"),
		color: Color(UIColor(named: "bfs-start-cell")!)
	)
	static let target = CellType(
		rawValue: "target",
		localizedStringKey: LocalizedStringKey("target"),
		color: Color(UIColor(named: "bfs-target-cell")!)
	)
	static let visited = CellType(
		rawValue: "visited",
		localizedStringKey: LocalizedStringKey("visited"),
		color: Color(UIColor(named: "bfs-visited-cell")!)
	)
	static let toBeVisited = CellType(
		rawValue: "to-be-visited",
		localizedStringKey: LocalizedStringKey("to-be-visited"),
		color: Color(UIColor(named: "bfs-to-be-visited-cell")!)
	)
	static let notVisited = CellType(
		rawValue: "not-visited",
		localizedStringKey: LocalizedStringKey("not-visited"),
		color: Color(UIColor(named: "bfs-not-visited-cell")!)
	)
    
	var id: String { self.rawValue }
	static func == (lhs: Self, rhs: Self) -> Bool {
		return lhs.rawValue == rhs.rawValue
	}
}
