//
//  NewSimulationView.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 28/07/25.
//

import SwiftUI

struct NewSimulationView: View {
    @ObservedObject var simulationVM: SimulationViewModel

    var body: some View {
        GeometryReader { proxy in
            HStack {
                MatrixView()
                    .frame(width: proxy.size.width/3, height: proxy.size.height*0.9)
                VStack {
//                    GraphView(resources: simulationVM.resources, processes: simulationVM.process)
                }
            }

        }
    }
}

#Preview {
    NewSimulationView(simulationVM: SimulationViewModel(parameters: SimulationParameters(
        resources:[
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

        ], deltaT: 3)))
    // versao 66% reduzida da tela para preview
    .frame(width: 1440, height: 1024)
}
