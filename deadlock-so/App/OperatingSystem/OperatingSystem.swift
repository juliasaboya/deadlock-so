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
    var systemTime = 0
    
    init(simulationVM: SimulationViewModel) {
        self.simulationVM = simulationVM
        super.init()
        self.name = "Operating System"
    }
    
    override func main() {
        while alive {
            Thread.sleep(forTimeInterval: 1)
            systemTime += 1
            if systemTime % Int(simulationVM.deltaT) == 0 {
//                print("\(simulationVM.isDeadlocked = (detectDeadlocks() == [] ? false : true ))")
                DispatchQueue.main.sync { [unowned self] in
                    simulationVM.logs.append(LogEntry(message: "[Sistema Operacional] Processos em DeadLock: \(detectDeadlocks())"))
                    print("[Sistema Operacional] Processos em DeadLock: \(detectDeadlocks())")
                }
                
//
            }
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
        var changed = true
        var finished = Array(repeating: false, count: n)
        
        while changed {
            changed = false
            for i in 0..<n {
                if !finished[i] {
                    // 1. Verificar se a requisição pode ser atendida com os recursos disponíveis
                    let canProceed = (0..<m).allSatisfy { requested[i][$0] <= available[$0] }
                    if canProceed {
                        // 2. Simular entrega dos recursos requisitados:
                        for j in 0..<m {
                            // "Entrega": adiciona R[i][j] em C[i][j], zera R[i][j]
                            allocated[i][j] += requested[i][j]
                            available[j] -= requested[i][j]
                            requested[i][j] = 0
                        }

                        // 3. Simular conclusão do processo (liberação dos recursos)
                        for j in 0..<m {
                            available[j] += allocated[i][j] // libera os recursos alocados
                            allocated[i][j] = 0
                        }

                        // 4. Marca processo como finalizado
                        finished[i] = true
                        changed = true
                    }
                }
            }
        }
        // id dos processos em deadlock
        let deadlocked = finished.enumerated().compactMap { !$0.element ? $0.offset : nil }
        return deadlocked
    }
}
