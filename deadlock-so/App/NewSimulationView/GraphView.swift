//
//  GraphView.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 28/07/25.
//

import SwiftUI

struct GraphView: View {
    var resources: [Resource]
    var processes: [ProcessThread]

    init(resources: [Resource], processes: [ProcessThread]) {
        self.resources = resources
        self.processes = processes
    }

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: proxy.size.height * 0.18) {
                HStack(spacing: 0.02 * proxy.size.width) {
                    ForEach(0..<resources.count/2, id: \.self){
                        resourceIndex in
                        ResourceView(resource: resources[resourceIndex],
                                     width: proxy.size.width * 0.1,
                                     totalHeight: proxy.size.height * 0.1)
                    }
                }
                .frame(maxWidth: .infinity)
                HStack(spacing: 0.01 * proxy.size.width) {
                    ForEach(processes, id: \.self){
                        process in
                        SingleProcessView(process: process, circleDiameter: proxy.size.width/16)
                    }
                }
                HStack(spacing: 0.02 * proxy.size.width) {
                    ForEach(resources.count/2..<resources.count, id: \.self){
                        resourceIndex in
                        ResourceView(resource: resources[resourceIndex],
                                     width: proxy.size.width * 0.1,
                                     totalHeight: proxy.size.height * 0.1)

                    }
                }
                .frame(maxWidth: .infinity)
            }

        }
    }
}

#Preview {
    GraphView(resources: [

        Resource(name: "Buffer de memória", id: 0, quantity: 5),
        Resource(name: "Impressora", id: 1, quantity: 30),
        Resource(name: "Porta USB", id: 2, quantity: 1),
        Resource(name: "Scanner", id: 3, quantity: 3),
        Resource(name: "Leitor de cartão", id: 4, quantity: 12),
        Resource(name: "Unidade de fita", id: 5, quantity: 10),
        Resource(name: "Modem", id: 6, quantity: 2),
        Resource(name: "Disco rígido", id: 7, quantity: 6),
        Resource(name: "Placa de som", id: 8, quantity: 15),
        Resource(name: "Placa de vídeo", id: 9, quantity: 10),

    ],
              processes:
                [
                    ProcessThread(id: 1, intervalRequest: 2, intervalUse: 2, simulationVM: SimulationViewModel(parameters: SimulationParameters(resources: [], deltaT: 2))),
                    ProcessThread(id: 1, intervalRequest: 2, intervalUse: 2, simulationVM: SimulationViewModel(parameters: SimulationParameters(resources: [], deltaT: 2))),
                ]
    )
    .frame(width: 1440/2, height: 1024/2)

}
