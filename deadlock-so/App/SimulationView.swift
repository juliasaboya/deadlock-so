//
//  ContentView.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 02/07/25.
//

import SwiftUI

struct SimulationView: View {
    
    @ObservedObject var simulationVM: SimulationViewModel
    @State var evenResources: [Resource] = []
    @State var oddResources: [Resource] = []
    let rows = Array(repeating: GridItem(.flexible()), count: 3)
    
    init(parameters: SimulationParameters) {
        self.simulationVM = .init(parameters: parameters)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if !simulationVM.isSOCreated {
                    Button {
                        simulationVM.createSOSheet = true
                    } label: {
                        Text("Criar sistema operacional")
                            .font(.headline)
                    }
                    .buttonStyle(.borderedProminent)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ZStack {
                        VStack {
                            ForEach(evenResources) { resource in
                                ResourceView(resource: resource, rows: rows)
                            }
                            .frame(alignment: .top)
                            
                            HStack {
                                Spacer()
                                ForEach(simulationVM.processes) { process in
                                    Circle()
                                        .frame(width: 100, height: 100)
                                        .foregroundStyle(.red)
                                }
                                Spacer()
                            }
                            .frame(alignment: .center)
                            
                            ForEach(oddResources) { resource in
                                ResourceView(resource: resource, rows: rows)
                            }
                            .frame(alignment: .bottom)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(.top)
                        Button {
                            simulationVM.createProcess = true
                        } label: {
                            Text("Criar processo")
                                .font(.headline)
                        }
                        .buttonStyle(.accessoryBarAction)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(.top)
                        Button {
                            simulationVM.removeProcessSheet = true
                       //     simulationVM.logs.append(LogEntry(message: "Impressora solicitou uma instância do recurso Impressora!"))
                        } label: {
                            Text("Criar fake log")
                                .font(.headline)
                        }
                        .buttonStyle(.borderedProminent)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                        LogView(size: geometry.size, simulationVM: simulationVM)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                        
                    }
                }
            }
            .background(Color.blue)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .sheet(isPresented: $simulationVM.createSOSheet) {
                CreateOSView(simulationVM: simulationVM)
            }
            .sheet(isPresented: $simulationVM.createProcess) {
                CreateProcessView(simulationVM: simulationVM)
            }
            .sheet(isPresented: $simulationVM.removeProcessSheet) {
                RemoveProcessView(simulationVM: simulationVM)
            }
            .onAppear {
                evenResources = simulationVM.resources.enumerated().filter {$0.offset % 2 == 0 }.map { $0.element }
                oddResources = simulationVM.resources.enumerated().filter { $0.offset % 2 != 0 }.map { $0.element }
            }
        }
    }
}

#Preview {
    SimulationView(parameters: SimulationParameters(resources: [], deltaT: 0))
}
