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

let mutexAR = DispatchSemaphore(value: 1)
let mutexRR = DispatchSemaphore(value: 1)

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
//        self.allocatedResources = Array(repeating: Array(repeating: 0, count: 10), count: 10)
//        self.requestedResources = Array(repeating: Array(repeating: 0, count: 10), count: 10)
        resources = parameters.resources
        parameters.resources.forEach { resource in
            self.existingResources.append(resource.totalInstances)
            self.availableResources.append(ResourceSemaphore(value: resource.totalInstances))
        }
        print("Existing: \(existingResources)")
        print("Allocated: \(allocatedResources)")
        print("Requested: \(requestedResources)")
        print("Available: \(availableResources.map(\.count))")
        
        let operatingSystem = OperatingSystem(simulationVM: self)
        operatingSystem.start()
    }
    
    func appendProcess(_ process: ProcessThread) {
        processes.append(process)
        allocatedResources.append(Array(repeating: 0, count: existingResources.count))
        requestedResources.append(Array(repeating: 0, count: existingResources.count))
    }
}


