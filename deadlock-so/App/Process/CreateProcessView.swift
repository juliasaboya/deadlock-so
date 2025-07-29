//
//  CreateProcessView.swift
//  deadlock-so
//
//  Created by Yane dos Santos on 16/07/25.
//

import SwiftUI

struct CreateProcessView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var simulationVM: SimulationViewModel
    
    @State private var processID: String = ""
    @State private var intervalRequest: String = ""
    @State private var intervalUse: String = ""
    
    @State private var isValid: Bool = true
    @State private var lastID: String?
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Criar Processo")
                .font(.title3)
                .bold()
            VStack(alignment: .leading) {
                Text("Identificador do processo:")
                    .font(.headline)
                TextField("Ex: 2", text: $processID)
                Text("Processo com o ID \(lastID ?? "0") já adicionado. Tente outro.")
                    .opacity(isValid ? 0 : 1)
                    .font(.caption)
                    .foregroundStyle(.red)
                Text("Tempo de intervalo entre solicitações de recursos:")
                    .font(.headline)
                TextField("Em segundos", text: $intervalRequest)
                Text("Tempo de intervalo para utilização do recurso:")
                    .font(.headline)
                TextField("Em segundos", text: $intervalUse)
            }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancelar") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Salvar") {
                    if simulationVM.processes.contains(where: { $0.id == Int(processID)! }) {
                        isValid = false
                        lastID = processID
                    } else {
                        let process = ProcessThread(id: Int(processID)!, intervalRequest: TimeInterval(intervalRequest)!, intervalUse: TimeInterval(intervalUse)!, simulationVM: simulationVM)
                        process.start()
                        simulationVM.appendProcess(process)
                        dismiss()
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(Int(processID) == nil || Int(processID)! <= 0 || Int(intervalRequest) == nil || Int(intervalRequest)! <= 0 || Int(intervalUse) == nil || Int(intervalUse)! <= 0)
            }
        }
    }
}

#Preview {
//    CreateProcessView(simulationVM: SimulationViewModel())
}
