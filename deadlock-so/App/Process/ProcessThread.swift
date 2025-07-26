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
                // MARK: Ainda não verifica as instâncias
                guard let resource = simulationVM.resources.randomElement() else { return }
                // TODO: verificar numero de instancias
                requestResource(resource)
                tryAllocate(resource)
            }
            
            // MARK: outro if para tupla que verifica o tempo
            /*
             if internalTime == tupla[0][1] (?) {
             
                useResource(resource)
             
             }
             */
        }
        
    }

    func stop() {
        isRunning = false
    }
    
    private func requestResourceAndUse() {
        guard let resource = simulationVM.resources.randomElement() else { return }

        // TODO: verificar numero de instancias
        requestResource(resource)
        tryAllocate(resource)
    }

    private func requestResource(_ resource: Resource) {
        print("[Process \(id)] Solicitando recurso \(resource.name)...")
        if let processIndex = simulationVM.processes.firstIndex(where: { $0.id == self.id }) {
            //acessa a matriz de requisição com o mutex para solicitar
            mutexRR.wait()
            simulationVM.requestedResources[processIndex][resource.id] += 1
            // TODO: append na tupla (tempo, recurso)
            mutexRR.signal()
        }
    }

    private func tryAllocate(_ resource: Resource) {
        print("[Process \(id)] Bloqueado aguardando \(resource.name)...")
        
        simulationVM.availableResources[resource.id].wait()
        //conseguiu solicitar, retira a requisição da matriz de requisição e adiciona o recurso como alocado na matriz de alocação
        if let processIndex = simulationVM.processes.firstIndex(where: { $0.id == self.id }) {
            // TODO: append na tupla (tempo, recurso)
            mutexRR.wait()
            simulationVM.requestedResources[processIndex][resource.id] -= 1
            mutexRR.signal()
            mutexAR.wait()
            simulationVM.allocatedResources[processIndex][resource.id] += 1
            mutexAR.signal()
        }
        // TODO: O append é aqui
        mutexAR.wait()
        
        
        print("[Process \(id)] Obteve recurso \(resource.name), usando por \(intervalUse)s")
    }

    private func useResource(_ resource: Resource) {
            print("[Process \(self.id)] Liberou recurso \(resource.name)")
            self.simulationVM.availableResources[resource.id].signal()
            // TODO: nesse momento dá um remove na lista de tuplas - momento da liberação, qual o recurso
            // TODO: tuplas N. (Tempo, recurso)
        //terminou de usar, retira o recurso da matriz de requisição
        if let processIndex = simulationVM.processes.firstIndex(where: { $0.id == self.id }) {
            mutexAR.wait()
            simulationVM.allocatedResources[processIndex][resource.id] -= 1
            mutexAR.signal()
        }

    }
    
    private func cpuBound(seconds: TimeInterval) {
        let start = Date()
        var x = 0.0
        while Date().timeIntervalSince(start) < seconds {
            x += sin(Double.random(in: 0..<Double.pi))
        }
    }
}
