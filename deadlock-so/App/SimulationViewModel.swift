//
//  MockResourceVM.swift
//  deadlock-so
//
//  Created by Yane dos Santos on 16/07/25.
//

import Foundation

class SimulationViewModel: ObservableObject {
    @Published var resources: [Resource] = []
    @Published var isSOCreated: Bool = true
    @Published var logs: [LogEntry] = []
    @Published var process: [ProcessMock] = []
    @Published var createSOSheet: Bool = false
    @Published var createProcess: Bool = false
    
    @Published var existingResources: [Int] = []
    @Published var allocatedResources: [[Int]] = []
    @Published var requestedResources: [[Int]] = []
    @Published var availableResources: [ResourceSemaphore] = []
    
    init(parameters: SimulationParameters) {
        resources = parameters.resources
        parameters.resources.forEach { resource in
            self.existingResources.append(resource.totalInstances)
            self.availableResources.append(ResourceSemaphore(value: resource.totalInstances))
        }
        let operatingSystem = OperatingSystem(simulationVM: self)
        operatingSystem.start()
    }
}

class ProcessMock: Identifiable {
    let id: Int
    let intervalRequest: Int
    let intervalUse: Int
    init(id: Int, intervalRequest: Int, intervalUse: Int) {
        self.id = id
        self.intervalRequest = intervalRequest
        self.intervalUse = intervalUse
    }
}
