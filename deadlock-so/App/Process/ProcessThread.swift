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
    var isRunning: Bool = true
    var freeResourcesTimes: [(Date, Int)] = []

    let simulationVM: SimulationViewModel
    
    let spaceTime = TimeInterval(1)
    var internalTime: Int = 0

    init(id: Int, intervalRequest: TimeInterval, intervalUse: TimeInterval, simulationVM: SimulationViewModel) {
        self.id = id
        self.intervalRequest = intervalRequest
        self.intervalUse = intervalUse
        self.simulationVM = simulationVM
    }

    override func main() {
        Thread.current.name = "Process \(id)"
        while isRunning {
            
            Thread.sleep(forTimeInterval: spaceTime)
            internalTime += 1
            
            if internalTime % Int(intervalRequest) == 0 {
                
                
                useResource(requestResource())
            }
            
            // MARK: outro if para tupla que verifica o tempo
            
             if internalTime == tupla[0][1] (?) {
             
                freeResource(resource)
             
             }
             
        }
        
    }

    func stop() {
        isRunning = false
    }

    private func requestResource() -> Resource {
        resource = nil
        if let resource = simulationVM.resources.randomElement() {
            
            print("[Process \(id)] Solicitando recurso \(resource.name)...")
            if let processIndex = simulationVM.processes.firstIndex(where: { $0.id == self.id }) {
                simulationVM.requestedResources[processIndex][resource.id] += 1
                // TODO: append na tupla (tempo, recurso)
                
            }
        }
    }

    private func useResource(_ resource: Resource) {
        print("[Process \(id)] Bloqueado aguardando \(resource.name)...")
        
        simulationVM.availableResources[resource.id].wait()
        
        // TODO: O append é aqui
        print("[Process \(id)] Obteve recurso \(resource.name), usando por \(intervalUse)s")

//        useResource(resource)
    }
    
    private func freeResource(_ resource: Resource) {
        print("[Process \(id)] Liberou recurso \(resource.name)")
        simulationVM.availableResources[resource.id].signal()
        //            // TODO: nesse momento dá um remove na lista de tuplas - momento da liberação, qual o recurso
    }

//    private func useResource(_ resource: Resource) {
//        timerUse = Timer.scheduledTimer(withTimeInterval: intervalUse, repeats: false) { [weak self] _ in
//            print("[Process \(self?.id ?? 0)] Liberou recurso \(resource.name)")
//            self?.simulationVM.availableResources[resource.id].signal()
    //            // TODO: tuplas N. (Tempo, recurso)

//
//        }
//
//        // Libera o recurso após o tempo de uso, sem bloquear a thread principal
//        //        DispatchQueue.global().asyncAfter(deadline: .now() + intervalUse) { [weak self] in
//        //            guard let self = self else { return }
//        
//        
//        //        }
//    }
    
    private func cpuBound(seconds: TimeInterval) {
        let start = Date()
        var x = 0.0
        while Date().timeIntervalSince(start) < seconds {
            x += sin(Double.random(in: 0..<Double.pi))
        }
    }
    
    private func requestResourceAndUse() {
        guard let resource = simulationVM.resources.randomElement() else { return }

        // TODO: verificar numero de instancias
        requestResource(resource)

        useResource(resource)

    }
}
