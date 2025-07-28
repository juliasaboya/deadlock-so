//
//  ResourceSemaphore.swift
//  deadlock-so
//
//  Created by Cauan Lopes Galdino on 19/07/25.
//

import Foundation

final class ResourceSemaphore {
    private var semaphore: DispatchSemaphore
    private(set) var count: Int
    private let mutex = DispatchSemaphore(value: 1)

    init(value: Int) {
        self.semaphore = DispatchSemaphore(value: value)
        self.count = value
    }

    func wait() {
        semaphore.wait()
        mutex.wait()
        count -= 1
        mutex.signal()
    }

    func signal() {
        semaphore.signal()
        mutex.wait()
        count += 1
        mutex.signal()
    }
}
