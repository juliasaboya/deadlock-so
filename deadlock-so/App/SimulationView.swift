//
//  ContentView.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 02/07/25.
//

import SwiftUI

struct SimulationView: View {
    @ObservedObject var deadlockVM: DeadlockVM
    
    @State var evenResources: [Resource] = []
    @State var oddResources: [Resource] = []
    let rows = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State private var createSOSheet: Bool = false
    @State private var createProcess: Bool = false
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if !deadlockVM.isSOCreated {
                    Button {
                        createSOSheet = true
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
                                ForEach(deadlockVM.process) { process in
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
                            createProcess = true
                        } label: {
                            Text("Criar processo")
                                .font(.headline)
                        }
                        .buttonStyle(.accessoryBarAction)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(.top)
                        Button {
                            deadlockVM.logs.append(LogEntry(message: "Impressora solicitou uma instância do recurso Impressora!"))
                        } label: {
                            Text("Criar fake log")
                                .font(.headline)
                        }
                        .buttonStyle(.borderedProminent)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                        LogView(size: geometry.size, deadlockVM: deadlockVM)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                        
                    }
                }
            }
            .background(Color.blue)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .sheet(isPresented: $createSOSheet) {
                CreateOSView(deadlockVM: deadlockVM)
            }
            .sheet(isPresented: $createProcess) {
                CreateProcessView(deadlockVM: deadlockVM)
            }
            .onAppear {
                evenResources = deadlockVM.resources.enumerated().filter {$0.offset % 2 == 0 }.map { $0.element }
                oddResources = deadlockVM.resources.enumerated().filter { $0.offset % 2 != 0 }.map { $0.element }
            }
        }
    }
}

#Preview {
    SimulationView(deadlockVM: DeadlockVM())
}
