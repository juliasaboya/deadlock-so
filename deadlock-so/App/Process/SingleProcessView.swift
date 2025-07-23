//
//  SingleProcessView.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 23/07/25.
//

import SwiftUI


struct SingleProcessView: View {
    var process: ProcessThread
    var backgroundColor: Color {
        if process.isRunning {
            return .verdeProcessos
        }
        return .cinzaPadrao
    }
    var body: some View {
        Text("P\(process.id)")
            .font(.system(size: 28, weight: .bold))
            .frame(width: 80, height: 80)
            .background(backgroundColor)
            .clipShape(Circle())
            .dropLight(isOn: process.isRunning)
    }
}

#Preview {
    SingleProcessView(process: ProcessThread(id: 1, requestInterval: 2, usageInterval: 2, allResources: [Resource(name: "cpu", id: 1, quantity: 1)]))
        .frame(width: 400, height: 400)

}
