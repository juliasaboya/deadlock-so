//
//  MockResourceVM.swift
//  deadlock-so
//
//  Created by Yane dos Santos on 16/07/25.
//

import Foundation

class ProcessMock: Identifiable {
    let id: Int
    let intervalRequest: Int
    let intervalUse: Int
    init(id: Int, intervalRequest: Int, intervalUse: Int) {
        self.id = id
        self.intervalRequest = intervalRequest
        self.intervalUse = intervalUse
    }
}

class DeadlockVM: ObservableObject {
    @Published var resources: [Resource] = []
    @Published var isSOCreated: Bool = true
    @Published var logs: [LogEntry] = []
    @Published var process: [ProcessMock] = []
}
