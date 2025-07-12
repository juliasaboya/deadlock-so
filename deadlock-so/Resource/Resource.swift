//
//  Resource.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 11/07/25.
//

import Foundation

class Resource {
    let name: String
    let id: Int
    let totalInstances: Int
    private let semaphore: DispatchSemaphore
    private let lock = NSLock()

    init(name: String, id: Int, quantity: Int) {
        self.name = name
        self.id = id
        self.totalInstances = quantity
        self.semaphore = DispatchSemaphore(value: quantity)
    }

    func requestAccess(processId: Int) {
        semaphore.wait()
    }

    func releaseAccess(processId: Int) {
        semaphore.signal()
    }
}
