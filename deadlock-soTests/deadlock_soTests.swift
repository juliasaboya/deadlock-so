//
//  deadlock_soTests.swift
//  deadlock-soTests
//
//  Created by Júlia Saboya on 14/07/25.
//

import XCTest
@testable import deadlock_so

final class ProcessSimulationTests: XCTestCase {

    func testProcessResourceSimulation() {
        let resources = [
            Resource(name: "Printer", id: 1, quantity: 2),
            Resource(name: "Scanner", id: 2, quantity: 1),
            Resource(name: "Disk", id: 3, quantity: 3)
        ]

        var processes: [ProcessThread] = []

        for i in 1...5 {
            let requestInterval = TimeInterval(Int.random(in: 1...2))
            let usageInterval = TimeInterval(Int.random(in: 2...3))
//            let process = ProcessThread(id: i, requestInterval: requestInterval, usageInterval: usageInterval, allResources: resources)
//            processes.append(process)
//            process.start()
        }

        let expectation = XCTestExpectation(description: "Espera a simulação terminar")
        DispatchQueue.global().asyncAfter(deadline: .now() + 10) {
//            processes.forEach { $0.stop() }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 15)
    }
}
