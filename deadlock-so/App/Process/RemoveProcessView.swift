//
//  RemoveProcessView.swift
//  deadlock-so
//
//  Created by Yane dos Santos on 27/07/25.
//

import SwiftUI

struct RemoveProcessView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var simulationVM: SimulationViewModel
    
    @State private var processID: Int = 0
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Remover Processo")
                .font(.title3)
                .bold()
            Picker("Processo a ser removido: ", selection: $processID) {
                ForEach(simulationVM.processes, id: \.self) { process in
                    Text("\(process.id)")
                        .tag(process.id)
                }
            }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancelar") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .destructiveAction) {
                Button("Remover") {
                    let processIndex = simulationVM.processes.firstIndex(where: { $0.id == processID })!
//                    print("id do processo sendo removido \(simulationVM.processes[processIndex].id)")
                    simulationVM.removeProcess(simulationVM.processes[processIndex])
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .disabled(Int(exactly: processID)! < 0)
            }
        }
    }
}

#Preview {
//    CreateProcessView(simulationVM: SimulationViewModel())
}
