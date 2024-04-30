//
//  AvEvent.swift
//  Algorithm-Visualizer
//
//  Created by Min-Kyu Lee on 2024-04-26.
//

import Foundation

protocol AvEvent: Identifiable, Equatable {}

struct BaseEvent: AvEvent {
	var id: UUID = UUID()
}
