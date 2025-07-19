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
    
    var existingResources: [Int] = []
    var allocatedResources: [[Int]] = []
    var requestedResources: [[Int]] = []
    var availableResources: [DispatchSemaphore] = []
    
    init(parameters: SimulationParameters) {
        resources = parameters.resources
        parameters.resources.forEach { resource in
            self.existingResources.append(resource.totalInstances)
            self.availableResources.append(DispatchSemaphore(value: resource.totalInstances))
        }
        
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
