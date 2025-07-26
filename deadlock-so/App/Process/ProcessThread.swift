//
//  Process.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 14/07/25.
//

// A classe processos poderá ter várias instâncias, que devem simular os processos solicitando,
// utilizando e liberando recursos do sistema.

import Foundation

class ProcessThread: Thread {
    let id: Int
    let requestInterval: TimeInterval
    let usageInterval: TimeInterval
    let allResources: [Resource]
    private(set) var isRunning = true


    init(id: Int, requestInterval: TimeInterval, usageInterval: TimeInterval, allResources: [Resource]) {
        self.id = id
        self.requestInterval = requestInterval
        self.usageInterval = usageInterval
        self.allResources = allResources

    }

    override func start() {
        DispatchQueue.global().async {
            while self.isRunning {
                self.cpuBound(seconds: self.requestInterval)
                self.requestResourceAndUse()
            }
        }
    }

    func stop() {
        isRunning = false
    }

    private func requestResourceAndUse() {
        guard let resource = allResources.randomElement() else { return }
        print("[Process \(id)] Solicitando recurso \(resource.name)...")

//        resource.requestAccess(processId: id)
        print("[Process \(id)] Obteve recurso \(resource.name), utilizando por \(usageInterval)s...")

        useResource()

//        resource.releaseAccess(processId: id)
        print("[Process \(id)] Liberou recurso \(resource.name)")
    }

    private func useResource() {
        cpuBound(seconds: usageInterval)
    }

    private func cpuBound(seconds: TimeInterval) {
        let start = Date()
        var x = 0.0
        while Date().timeIntervalSince(start) < seconds {
            x += sin(Double.random(in: 0..<Double.pi))
        }
    }

}
