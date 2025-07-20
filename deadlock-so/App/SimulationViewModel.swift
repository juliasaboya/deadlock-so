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

enum ProcessStatus {
    case aguardando, usando, bloqueado, deadlock
}

class ProcessMock: Thread, Identifiable {
    let id: Int
    let intervalRequest: TimeInterval
    let intervalUse: TimeInterval
    var resourceRequested: Resource? = nil
    var resourceBeingUsed: Resource? = nil
    
    var status: ProcessStatus = .aguardando
    
    let simulationVM: SimulationViewModel
    
    var isRunning: Bool = true
    
    
    init(id: Int, intervalRequest: TimeInterval, intervalUse: TimeInterval, simulationVM: SimulationViewModel) {
        self.id = id
        self.intervalRequest = intervalRequest
        self.intervalUse = intervalUse
        self.simulationVM = simulationVM
    }
    
    override func main() {
        Thread.current.name = "Process \(id)"
        while self.isRunning {
            self.requestResourceAndUse()
        }
    }
    
    func stop() {
        isRunning = false
    }
    
    private func requestResourceAndUse() {
        guard let resource = simulationVM.resources.randomElement() else { return }
        resourceRequested = resource
        
        print("[Process \(id)] Solicitando recurso \(resource.name)...")
        
        tryAllocate(resource: resourceRequested!)
        
        resourceBeingUsed = resourceRequested
        
        print("[Process \(id)] Obteve recurso \(resource.name), utilizando por \(intervalUse)s...")
        useResource(resource: resourceBeingUsed!)
        
        print("[Process \(id)] Liberou recurso \(resource.name)")
        self.cpuBound(seconds: self.intervalRequest)
    }
    
    private func useResource(resource: Resource) {
        cpuBound(seconds: intervalUse)
        simulationVM.availableResources[resource.id - 1].signal()
        DispatchQueue.main.async { [unowned self] in
            status = .aguardando
            resourceBeingUsed = nil
            resourceRequested = nil
        }
    }
    
    private func cpuBound(seconds: TimeInterval) {
        let start = Date()
        var x = 0.0
        while Date().timeIntervalSince(start) < seconds {
            x += sin(Double.random(in: 0..<Double.pi))
        }
    }
    
    private func tryAllocate(resource: Resource) {
//        if status != .usando {
//            DispatchQueue.main.async { [unowned self] in
//                status = .bloqueado
//                print("bloqueado, processo \(id) aguardando recurso...")
//            }
//        }
        // MARK: primeiro recurso tem q ter id 1, depois 2
        simulationVM.availableResources[resource.id - 1].wait()
        DispatchQueue.main.async { [unowned self] in
            status = .usando
        }
    }
}
