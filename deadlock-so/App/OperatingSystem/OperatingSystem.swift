//
//  OperatingSystem.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 14/07/25.
//

// A classe sistema operacional terá apenas uma
// instância e ficará responsável por detectar possíveis deadlocks.
import Foundation


class OperatingSystem {
    let existingResources: [Int] = [2,3]
    var availableResources: [DispatchSemaphore] = [DispatchSemaphore(value: 2), DispatchSemaphore(value: 3)]
    
    init(availableResources: [DispatchSemaphore]) {
        self.availableResources = availableResources
    }
}
