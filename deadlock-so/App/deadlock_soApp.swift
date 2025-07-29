//
//  deadlock_soApp.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 02/07/25.
//

import SwiftUI

@main
struct deadlock_soApp: App {
    var body: some Scene {
        WindowGroup {
//            CreateResourcesView()
            NewSimulationView(
                simulationVM: SimulationViewModel(
                    parameters: SimulationParameters(
                resources: [
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

            ], deltaT: 2)))
        }
    }
}
