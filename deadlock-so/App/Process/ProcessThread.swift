//
//  Process.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 14/07/25.
//

// A classe processos poderá ter várias instâncias, que devem simular os processos solicitando,
// utilizando e liberando recursos do sistema.

import Foundation
import SwiftUI

@Observable
class ProcessThread: Thread, Identifiable/*, ObservableObject*/ {
    let id: Int
    let intervalRequest: TimeInterval
    let intervalUse: TimeInterval
    var alive: Bool = true
    var isRunning: Bool = true
    var freeResourcesTimes: [(freeTime: Int, resourceId: Int)] = [] // (tempo, recurso)
    var processIndex: Int = 0

    let simulationVM: SimulationViewModel
    
    let aSecond = TimeInterval(1)
    var internalTime: Int = 0
    
    init(id: Int, intervalRequest: TimeInterval, intervalUse: TimeInterval, simulationVM: SimulationViewModel) {
        self.id = id
        self.intervalRequest = intervalRequest
        self.intervalUse = intervalUse
        self.simulationVM = simulationVM
    }
    
    override func main() {
        Thread.current.name = "Process \(id)"
        while alive {
            Thread.sleep(forTimeInterval: aSecond)
            internalTime += 1
//            processIndex = simulationVM.processes.firstIndex(where: { $0.id == self.id })!
//            mutexTime.wait()
//            simulationVM.processesTimes[processIndex] += 1
//            mutexTime.signal()
            
            print("Tempo atual [Process \(id)]: \(internalTime)")
            
            if internalTime % Int(intervalRequest) == 0 {
                    useResource()
            }
            
            if internalTime == freeResourcesTimes.first?.0 && alive {
                    freeResources()
            }
        }
    }
    
    private func useResource() {
        // verifica se há recurso disponível que não auto bloqueie o processo, se não houver, não solicita
        guard let resource = selectResource() else {
            print("Não há recurso disponível para o processo \(self.id).")
            return
        }
        requestResource(resource)
        tryAllocate(resource)
    }
    
    private func selectResource() -> Resource? {
        // embaralha os recursos
        let shuffledResources = simulationVM.resources.shuffled()
        // como vai acessar a matriz, usa o mutex
        mutexAR.wait()
        defer { mutexAR.signal() } // garante que o mutex será liberado mesmo com retorno antecipado
        
        guard let processIndex = simulationVM.processes.firstIndex(where: { $0.id == self.id }) else {
            return nil
        }
        
        for resource in shuffledResources {
            // checa se o processo ainda não possui todas as instâncias do recurso
            if simulationVM.allocatedResources[processIndex][resource.id] < resource.totalInstances {
                return resource
            }
        }
        // se nenhum recurso estiver disponível, então retorna nil para não solicitar nenhum recurso
        
        return nil
    }
    
    private func requestResource(_ resource: Resource) {
        print("[Process \(id)] Solicitando recurso \(resource.name)...")
        if let processIndex = simulationVM.processes.firstIndex(where: { $0.id == self.id }) {
            //acessa a matriz de requisição com o mutex para solicitar
            mutexRR.wait()
            DispatchQueue.main.sync { [unowned self] in
                simulationVM.requestedResources[processIndex][resource.id] += 1
            }
            print("Requested: \(simulationVM.requestedResources)")
            mutexRR.signal()
        }
    }
    
    private func tryAllocate(_ resource: Resource) {
        print("[Process \(id)] Bloqueado aguardando \(resource.name)...")
        isRunning = false
        simulationVM.availableResources[resource.id].wait()
        if !alive {
            return
        }
        isRunning = true
        print("[Process \(id)] Obteve recurso \(resource.name), usando por \(intervalUse)s")
        print("Available: \(simulationVM.availableResources.map(\.count))")
        //conseguiu solicitar, retira a requisição da matriz de requisição e adiciona o recurso como alocado na matriz de alocação
        if let processIndex = simulationVM.processes.firstIndex(where: { $0.id == self.id }) {
            mutexRR.wait()
            DispatchQueue.main.sync { [unowned self] in
                simulationVM.requestedResources[processIndex][resource.id] -= 1
                print("Requested: \(simulationVM.requestedResources)")
            }
            mutexRR.signal()
            mutexAR.wait()
            DispatchQueue.main.sync { [unowned self] in
                simulationVM.allocatedResources[processIndex][resource.id] += 1
                print("Allocated: \(simulationVM.allocatedResources)")
            }
            mutexAR.signal()
            
            
            // append na tupla (tempo, recurso)
            let freeTime = internalTime + Int(intervalUse)
            freeResourcesTimes.append((freeTime, resource.id))
        }
        
    }
    
    private func freeResources() {
        let resourcesToFreeIds = freeResourcesTimes
            .filter { $0.freeTime == internalTime }
            .map { $0.resourceId }
        
        for resourceId in resourcesToFreeIds {
            let resource = simulationVM.resources.first(where: { $0.id == resourceId })!
            freeResource(resource)
        }
    }
    
    private func freeResource(_ resource: Resource) {
        self.simulationVM.availableResources[resource.id].signal()
        print("[Process \(self.id)] Liberou recurso \(resource.name)")
        print("Available: \(simulationVM.availableResources.map(\.count))")
        
        //terminou de usar, retira o recurso da matriz de requisição
        if let processIndex = simulationVM.processes.firstIndex(where: { $0.id == self.id }) {
            mutexAR.wait()
            DispatchQueue.main.sync { [unowned self] in
                simulationVM.allocatedResources[processIndex][resource.id] -= 1
            }
            print("Allocated: \(simulationVM.allocatedResources)")
            mutexAR.signal()
        }
        
        // nesse momento dá um remove na lista de tuplas - momento da liberação
        freeResourcesTimes.removeAll { $0.freeTime == internalTime && $0.resourceId == resource.id }
        
    }
}
