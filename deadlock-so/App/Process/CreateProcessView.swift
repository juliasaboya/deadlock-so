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
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Criar Processo")
                .font(.title3)
                .bold()
            VStack(alignment: .leading) {
                Text("Identificador do processo:")
                    .font(.headline)
                TextField("Ex: 2", text: $processID)
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
                    simulationVM.process.append(ProcessMock(id: Int(processID)!, intervalRequest: Int(intervalRequest)!, intervalUse: Int(intervalRequest)!))
                    dismiss()
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
