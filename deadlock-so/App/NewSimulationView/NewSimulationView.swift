//
//  NewSimulationView.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 28/07/25.
//

import SwiftUI

struct NewSimulationView: View {
    @ObservedObject var simulationVM: SimulationViewModel
    let mockProcesses: [ProcessThread] = [
        ProcessThread(id: 1, intervalRequest: 2, intervalUse: 2, simulationVM: SimulationViewModel(parameters: SimulationParameters(resources: [], deltaT: 2))),
        ProcessThread(id: 2, intervalRequest: 2, intervalUse: 2, simulationVM: SimulationViewModel(parameters: SimulationParameters(resources: [], deltaT: 2))),
        ProcessThread(id: 3, intervalRequest: 2, intervalUse: 2, simulationVM: SimulationViewModel(parameters: SimulationParameters(resources: [], deltaT: 2))),
        ProcessThread(id: 4, intervalRequest: 2, intervalUse: 2, simulationVM: SimulationViewModel(parameters: SimulationParameters(resources: [], deltaT: 2))),
        ProcessThread(id: 5, intervalRequest: 2, intervalUse: 2, simulationVM: SimulationViewModel(parameters: SimulationParameters(resources: [], deltaT: 2))),
        ProcessThread(id: 6, intervalRequest: 2, intervalUse: 2, simulationVM: SimulationViewModel(parameters: SimulationParameters(resources: [], deltaT: 2))),
        ProcessThread(id: 7, intervalRequest: 2, intervalUse: 2, simulationVM: SimulationViewModel(parameters: SimulationParameters(resources: [], deltaT: 2))),
        ProcessThread(id: 8, intervalRequest: 2, intervalUse: 2, simulationVM: SimulationViewModel(parameters: SimulationParameters(resources: [], deltaT: 2))),
        ProcessThread(id: 9, intervalRequest: 2, intervalUse: 2, simulationVM: SimulationViewModel(parameters: SimulationParameters(resources: [], deltaT: 2))),
        ProcessThread(id: 10, intervalRequest: 2, intervalUse: 2, simulationVM: SimulationViewModel(parameters: SimulationParameters(resources: [], deltaT: 2))),
    ]

    var body: some View {
        GeometryReader { proxy in
            HStack {
                MatrixView(proxy: proxy)
                    .padding()

                ZStack {
                    VStack(spacing: 0) {
                        GraphView(
                            resources: simulationVM.resources,
                            processes: mockProcesses
                        )
                        .padding(.top)
                        
                    }
                    HStack {
                        LogView(logs: simulationVM.logs, proxy: proxy)
                    }
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .padding(.leading, 24)
                    HStack(spacing: 10) {
                        Button {
                            simulationVM.createProcess = true
                        } label: {
                            ButtonView(topText: "Criar", imageSymbol: "plus.circle", imageButton: "CriarProcessoImagem", proxy: proxy)
                        }
                        .buttonStyle(.plain)
                        Button {
                            simulationVM.removeProcessSheet = true
                        } label: {
                            ButtonView(topText: "Remover", imageSymbol: "minus.circle", imageButton: "RemoverProcessoImagem", proxy: proxy)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding(.trailing, 10)
                }
            }

        }
        .sheet(isPresented: $simulationVM.createProcess) {
            CreateProcessView(simulationVM: simulationVM)
        }
        .sheet(isPresented: $simulationVM.removeProcessSheet) {
            RemoveProcessView(simulationVM: simulationVM)
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
    // versao 50% reduzida da tela para preview
    .frame(width: 1440/3, height: 1024/3)
}
