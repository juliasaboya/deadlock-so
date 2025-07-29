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
    @Published var removeProcessSheet: Bool = false
    
    @Published var existingResources: [Int] = []
    @Published var allocatedResources: [[Int]] = []
    @Published var requestedResources: [[Int]] = []
    @Published var availableResources: [ResourceSemaphore] = []
    
    let deltaT: TimeInterval
    @Published var isDeadlocked = false
    
    
    
    init(parameters: SimulationParameters) {
        deltaT = parameters.deltaT
        
        resources = parameters.resources
        parameters.resources.forEach { resource in
            self.existingResources.append(resource.totalInstances)
            self.availableResources.append(ResourceSemaphore(value: resource.totalInstances))
        }
//        print("Existing: \(existingResources)")
//        print("Allocated: \(allocatedResources)")
//        print("Requested: \(requestedResources)")
//        print("Available: \(availableResources.map(\.count))")
        
        let operatingSystem = OperatingSystem(simulationVM: self)
        operatingSystem.start()
    }
    
    func appendProcess(_ process: ProcessThread) {
        processes.append(process)
        allocatedResources.append(Array(repeating: 0, count: existingResources.count))
        requestedResources.append(Array(repeating: 0, count: existingResources.count))
    }
    
    func removeProcess(_ process: ProcessThread) {
        print("Tentando remover processo no index \(process.id)")
        logs.append(LogEntry(message: "Removendo processo \(process.id)"))
        
        process.alive = false
        
        var resourcesToFreeIds = process.freeResourcesTimes
            .map { $0.resourceId }
        
        guard let processIndex = self.processes.firstIndex(where: { $0.id == process.id }) else { return }
        mutexRR.wait()
        if let requestedResourceId = requestedResources[processIndex].firstIndex(where: { $0 > 0 }) {
            resourcesToFreeIds.append(requestedResourceId)
        }
        mutexRR.signal()
        
            mutexAR.wait()
            self.allocatedResources.remove(at: processIndex)
            mutexAR.signal()
            mutexRR.wait()
            self.requestedResources.remove(at: processIndex)
            mutexRR.signal()
            self.processes.remove(at: processIndex)
            
            for resourceId in resourcesToFreeIds {
                let resource = resources.first(where: { $0.id == resourceId })!
                
                self.availableResources[resource.id].signal()
//                print("[Process \(process.id)] Liberou recurso \(resource.name)")
                logs.append(LogEntry(message: "[Process \(process.id)] Liberou recurso \(resource.name)"))

//                print("Available: \(self.availableResources.map(\.count))")
                logs.append(LogEntry(message: "Available: \(self.availableResources.map(\.count))"))


            }
//        }
    }
}


