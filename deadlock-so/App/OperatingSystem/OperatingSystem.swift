//
//  OperatingSystem.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 14/07/25.
//

// A classe sistema operacional terá apenas uma
// instância e ficará responsável por detectar possíveis deadlocks.
import Foundation


class OperatingSystem: Thread {
    let simulationVM: SimulationViewModel
    var alive = true
    
    init(simulationVM: SimulationViewModel) {
        self.simulationVM = simulationVM
        super.init()
        self.name = "Operating System"
    }
    
    override func main() {
        while alive {
            _ = detectDeadlocks()
        }
    }
    
    func detectDeadlocks() -> [Int] {
        let n = simulationVM.allocatedResources.count // número de processos
        guard n > 0 else { return [] }
        let m = simulationVM.existingResources.count // número de tipos de recursos
        
        var available = simulationVM.existingResources
        for j in 0..<m {
            let totalAllocated = simulationVM.allocatedResources.reduce(0) { $0 + $1[j] }
            available[j] -= totalAllocated
        }
        
        var allocated = simulationVM.allocatedResources
        var requested = simulationVM.requestedResources
        var alive = true
        var finished = Array(repeating: false, count: n)
        
        while alive {
            alive = false
            for i in 0..<n {
                if !finished[i] {
                    // verifica se todos os recursos que o processo requisita estão disponíveis
                    let canExecute = (0..<m).allSatisfy { requested[i][$0] <= available[$0] }
                    
                    if canExecute {
                        
                        // entrega os recursos ao processo
                        for j in 0..<m {
                            allocated[i][j] += requested[i][j]
                            available[j] -= requested[i][j]
                        }

                        // libera os recursos alocados
                        for j in 0..<m {
                            available[j] += allocated[i][j]
                        }

                        finished[i] = true // marca o processo atual como finalizado
                        alive = true // pelo menos um processo foi executado, portanto roda de novo
                    }
                }
            }
        }
        // id dos processos em deadlock
        let deadlocked = finished.enumerated().compactMap { !$0.element ? $0.offset : nil }
        return deadlocked
    }
}
