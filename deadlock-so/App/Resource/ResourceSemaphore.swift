//
//  ResourceSemaphore.swift
//  deadlock-so
//
//  Created by Cauan Lopes Galdino on 19/07/25.
//

import Foundation

final class ResourceSemaphore {
    private var semaphore: DispatchSemaphore
    private var count: Int
    private let lock = NSLock()

    init(value: Int) {
        self.semaphore = DispatchSemaphore(value: value)
        self.count = value
    }

    func wait() {
        semaphore.wait()
        lock.lock()
        count -= 1
        lock.unlock()
    }

    func signal() {
        semaphore.signal()
        lock.lock()
        count += 1
        lock.unlock()
    }
}
