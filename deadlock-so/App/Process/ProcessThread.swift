//
//  Process.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 14/07/25.
//

// A classe processos poderá ter várias instâncias, que devem simular os processos solicitando,
// utilizando e liberando recursos do sistema.

import Foundation

class ProcessThread: Thread, Identifiable {
    let id: Int
    let intervalRequest: TimeInterval
    let intervalUse: TimeInterval
    var status: ProcessStatus = .aguardando
    var isRunning: Bool = true
    
    let simulationVM: SimulationViewModel
    
    init(id: Int, intervalRequest: TimeInterval, intervalUse: TimeInterval, simulationVM: SimulationViewModel) {
        self.id = id
        self.intervalRequest = intervalRequest
        self.intervalUse = intervalUse
        self.simulationVM = simulationVM
    }
    
    override func main() {
        Thread.current.name = "Process \(id)"
        
        while self.isRunning {
            Thread.sleep(forTimeInterval: intervalRequest)
            self.requestResourceAndUse()
        }
    }
    
    func stop() {
        isRunning = false
    }
    
    private func requestResourceAndUse() {
//        if status != .bloqueado {
            guard let resource = simulationVM.resources.randomElement() else { return }
            
            requestResource(resource: resource)
            
            // Isso deve bloquear corretamente
            tryAllocate(resource: resource)
            
//            DispatchQueue.global().async { [unowned self] in
//                useResource(resource: resource)
//            }
            
//        }
//        if status != .bloqueado {
//            guard let resource = simulationVM.resources.randomElement() else { return }
//            requestResource(resource: resource)
//            tryAllocate(resource: resource)
//            DispatchQueue.global().async { [unowned self] in
//                self.useResource(resource: resource)
//            }
//        }
    }
    
    private func requestResource(resource: Resource) {
        print("[Process \(id)] Solicitando recurso \(resource.name)...")
        if let processIndex = simulationVM.processes.firstIndex(where: { $0.id == self.id }) {
            simulationVM.requestedResources[processIndex][resource.id] += 1
        }
    }
    
    private func useResource(resource: Resource) {
        Thread.sleep(forTimeInterval: intervalUse)
//        DispatchQueue.main.async { [unowned self] in
//            simulationVM.availableResources[resource.id].signal()
//        }
       
        DispatchQueue.main.async { [unowned self] in
            status = .aguardando
            print("[Process \(id)] Liberou recurso \(resource.name)")
//            simulationVM.allocatedResources[self.id][resource.id] -= 1
        }
    }
    
    
    private func tryAllocate(resource: Resource) {
        DispatchQueue.main.async { [unowned self] in
////            status = .bloqueado
            print("[Process \(id)] Bloqueado aguardando \(resource.name)...")
        }
        
        simulationVM.availableResources[resource.id].wait()
        print("[Process \(id)] Obteve recurso \(resource.name), utilizando por \(intervalUse)s...")
        useResource(resource: resource)
//        DispatchQueue.main.async { [unowned self] in
////            status = .usando
////            simulationVM.requestedResources[self.id][resource.id] -= 1
////            simulationVM.allocatedResources[self.id][resource.id] += 1
            
//        }
    }
    
    private func cpuBound(seconds: TimeInterval) {
        let start = Date()
        var x = 0.0
        while Date().timeIntervalSince(start) < seconds {
            x += sin(Double.random(in: 0..<Double.pi))
        }
    }
}
