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
    
    /*@Published*/ var existingResources: [Int] = []
    /*@Published*/ var allocatedResources: [[Int]] = []
    /*@Published*/ var requestedResources: [[Int]] = []
    /*@Published*/ var availableResources: [ResourceSemaphore] = []
    
    let deltaT: TimeInterval
    @Published var isDeadlocked = false
    
    
    
    init(parameters: SimulationParameters) {
        deltaT = parameters.deltaT
        
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
    
    func removeProcess(_ processIndexToRemove: Int) {
            print("Tentando remover processo no index \(processIndexToRemove)")
            self.processes[processIndexToRemove].stop()
            //TODO: tem que passar pelas tuplas e usar um for para liberar todos os recursos com o signal() e decrementar de allocatedResource
            //mutexAR.wait()
            //for tupla {
                //self.simulationVM.availableResources[resource.id].signal()
                //simulationVM.allocatedResources[self.id][resource.id] -= 1
            // }
            //mutexAR.signal()
            
            self.processes.remove(at: processIndexToRemove)
        
    }
}


