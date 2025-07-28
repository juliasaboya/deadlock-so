//
//  ProcessRowView.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 28/07/25.
//

import SwiftUI

struct ProcessRowView: View {
    var processes: [ProcessThread] = [
//        ProcessThread(id: 1, requestInterval: 0.1, usageInterval: 0.1, allResources: [], isRunning: true),
//        ProcessThread(id: 2, requestInterval: 0.1, usageInterval: 0.1, allResources: [], isRunning: true),
//        ProcessThread(id: 3, requestInterval: 0.1, usageInterval: 0.1, allResources: [], isRunning: false),
//        ProcessThread(id: 4, requestInterval: 0.1, usageInterval: 0.1, allResources: [], isRunning: true),
//        ProcessThread(id: 5, requestInterval: 0.1, usageInterval: 0.1, allResources: [], isRunning: true),
//        ProcessThread(id: 6, requestInterval: 0.1, usageInterval: 0.1, allResources: [], isRunning: false),
//        ProcessThread(id: 7, requestInterval: 0.1, usageInterval: 0.1, allResources: [], isRunning: false),
//        ProcessThread(id: 8, requestInterval: 0.1, usageInterval: 0.1, allResources: [], isRunning: true),
//        ProcessThread(id: 9, requestInterval: 0.1, usageInterval: 0.1, allResources: [], isRunning: false),
//        ProcessThread(id: 10, requestInterval: 0.1, usageInterval: 0.1, allResources: [], isRunning: true),
    ]
    var body: some View {

        GeometryReader { proxy in
            HStack {
                ForEach(processes, id: \.self){ process in
                    SingleProcessView(process: process, circleDiameter: proxy.size.width/12)
                }
            }
            .padding()
        }

    }
}

#Preview {
    ProcessRowView()
        .frame(height: 80)
}
