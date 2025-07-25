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
    
    var timer: Timer?
    var timerUse: Timer?

    let simulationVM: SimulationViewModel

    init(id: Int, intervalRequest: TimeInterval, intervalUse: TimeInterval, simulationVM: SimulationViewModel) {
        self.id = id
        self.intervalRequest = intervalRequest
        self.intervalUse = intervalUse
        self.simulationVM = simulationVM
    }

    override func main() {
        Thread.current.name = "Process \(id)"

//        while isRunning {
            timer = Timer.scheduledTimer(withTimeInterval: intervalRequest, repeats: true) { [weak self] _ in
                        self?.requestResourceAndUse()
            }
//            Thread.sleep(forTimeInterval: intervalRequest)
//
//            guard let resource = simulationVM.resources.randomElement() else { continue }
//
//            requestResource(resource)
//
//            tryAllocate(resource)
            RunLoop.current.add(timer!, forMode: .default)

            // Inicia o run loop para manter a thread viva e escutando o timer
            RunLoop.current.run()
//        }
    }

    func stop() {
        isRunning = false
    }
    
    private func requestResourceAndUse() {
        guard let resource = simulationVM.resources.randomElement() else { return }
        
        requestResource(resource)
        
        tryAllocate(resource)
        
        useResource(resource)
    }

    private func requestResource(_ resource: Resource) {
        print("[Process \(id)] Solicitando recurso \(resource.name)...")
        if let processIndex = simulationVM.processes.firstIndex(where: { $0.id == self.id }) {
            simulationVM.requestedResources[processIndex][resource.id] += 1
        }
    }

    private func tryAllocate(_ resource: Resource) {
        print("[Process \(id)] Bloqueado aguardando \(resource.name)...")

        simulationVM.availableResources[resource.id].wait()

        print("[Process \(id)] Obteve recurso \(resource.name), usando por \(intervalUse)s")

//        useResource(resource)
    }

    private func useResource(_ resource: Resource) {
        timerUse = Timer.scheduledTimer(withTimeInterval: intervalUse, repeats: false) { [weak self] _ in
            print("[Process \(self?.id ?? 0)] Liberou recurso \(resource.name)")
            self?.simulationVM.availableResources[resource.id].signal()
        }
        // Libera o recurso após o tempo de uso, sem bloquear a thread principal
        //        DispatchQueue.global().asyncAfter(deadline: .now() + intervalUse) { [weak self] in
        //            guard let self = self else { return }
        
        
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
