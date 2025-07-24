//
//  MockResourceVM.swift
//  deadlock-so
//
//  Created by Yane dos Santos on 16/07/25.
//

import Foundation

enum ProcessStatus {
    case aguardando, usando, bloqueado, deadlock
}

class SimulationViewModel: ObservableObject {
    @Published var resources: [Resource] = []
    @Published var isSOCreated: Bool = true
    @Published var logs: [LogEntry] = []
    @Published var processes: [ProcessThread] = []
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
//            self.allocatedResources = Array(repeating: Array(repeating: 0, count: 10), count: 10)
//            self.requestedResources = Array(repeating: Array(repeating: 0, count: 10), count: 10)
        }
        let operatingSystem = OperatingSystem(simulationVM: self)
        operatingSystem.start()
    }
}


