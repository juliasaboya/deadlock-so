//
//  CreateResourcesView.swift
//  deadlock-so
//
//  Created by Yane dos Santos on 16/07/25.
//

import SwiftUI

struct CreateResourcesView: View {
    @ObservedObject var deadlockVM: DeadlockVM = DeadlockVM()
    
    @State private var resourceName: String = ""
    @State private var resourceID: String = ""
    @State private var resourceInstances: String = ""
    
    @State private var navegar = false
    var body: some View {
        NavigationStack {
            HStack {
                VStack {
                    Text("Lista de recursos:")
                        .font(.title3)
                        .bold()
                        .padding()
                    ScrollView(.vertical) {
                        VStack(alignment: .leading, spacing: 5) {
                            ForEach(deadlockVM.resources) { resource in
                                Text("\(resource.name) (ID: \(resource.id))")
                                    .bold()
                                Text("Quantidade de instâncias: \(resource.totalInstances)")
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                RoundedRectangle(cornerRadius: 20)
                    .background(Color.white)
                    .frame(maxHeight: .infinity, alignment: .center)
                    .frame(width: 1)
                    .opacity(0.2)
                VStack(spacing: 20) {
                    Text("Adicionar novo recurso")
                        .font(.title3)
                        .bold()
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Nome do recurso:")
                            .font(.headline)
                        TextField("Digite o nome do recurso", text: $resourceName)
                        Text("Identificador do recurso:")
                            .font(.headline)
                        TextField("Ex: 1", text: $resourceID)
                        Text("Quantidade de instâncias do recurso:")
                            .font(.headline)
                        TextField("Ex: 2", text: $resourceInstances)
                    }
                    Button {
                        deadlockVM.resources.append(Resource(name: resourceName, id: Int(resourceID)!, quantity: Int(resourceInstances)!))
                        print("recurso adicionado !")
                        resourceID = ""
                        resourceName = ""
                        resourceInstances = ""
                    } label: {
                        Text("Adicionar recurso")
                            .font(.headline)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(String(resourceName).isEmpty || Int(resourceID) == nil || Int(resourceInstances) == nil || Int(resourceID) ?? 0 <= 0 || Int(resourceInstances) ?? 0 <= 0)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .padding([.top, .leading, .trailing], 16)
            Button {
                navegar = true
            } label: {
                Text("Continuar")
            }
            .padding([.bottom, .top], 10)
            .disabled(deadlockVM.resources.isEmpty)
            .navigationDestination(isPresented: $navegar) {
                SimulationView(deadlockVM: deadlockVM)
            }
        }
    }
}

#Preview {
    CreateResourcesView()
}
