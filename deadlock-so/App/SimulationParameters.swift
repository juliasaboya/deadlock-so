//
//  SimulationParameters.swift
//  deadlock-so
//
//  Created by Cauan Lopes Galdino on 27/07/25.
//
import SwiftUI

struct SimulationParameters: Hashable, Equatable, Identifiable {
    let id = UUID()
    var resources: [Resource]
    var deltaT: TimeInterval
}
