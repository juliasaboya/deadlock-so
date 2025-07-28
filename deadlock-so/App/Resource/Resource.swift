//
//  Resource.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 11/07/25.
//

import Foundation

class Resource: Identifiable, Hashable, Equatable {
    let name: String
    let id: Int
    let totalInstances: Int

    init(name: String, id: Int, quantity: Int) {
        self.name = name
        self.id = id
        self.totalInstances = quantity
    }

    static func == (lhs: Resource, rhs: Resource) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.totalInstances == rhs.totalInstances
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(totalInstances)
    }
}
