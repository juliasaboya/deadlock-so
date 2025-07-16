//
//  CreateOSView.swift
//  deadlock-so
//
//  Created by Yane dos Santos on 16/07/25.
//

import SwiftUI

struct CreateOSView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var deadlockVM: DeadlockVM
    @State private var interval: String = ""
    var body: some View {
        VStack(spacing: 20) {
           Text("Criar Sistema Operacional")
                .font(.title3)
                .bold()
            VStack(alignment: .leading) {
                Text("Intervalo de verificação do SO:")
                    .font(.headline)
                TextField("Em segundos", text: $interval)
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
                    deadlockVM.isSOCreated = true
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .disabled(interval.isEmpty || Int(interval) == nil || Int(interval)! <= 0)
            }
        }
    }
}

#Preview {
    CreateOSView(deadlockVM: DeadlockVM())
}
