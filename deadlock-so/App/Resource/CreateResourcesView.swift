//
//  CreateResourcesView.swift
//  deadlock-so
//
//  Created by Yane dos Santos on 16/07/25.
//

import SwiftUI

struct CreateResourcesView: View {
    @State var parameters = SimulationParameters(resources: [], deltaT: 5)
    
    @State private var resourceName: String = ""
    @State private var resourceID: String = ""
    @State private var resourceInstances: String = ""
    
    @State private var path = NavigationPath()
    
    @State private var navegar = false
    var body: some View {
        NavigationStack (path: $path){
            HStack {
                VStack {
                    Text("Lista de recursos:")
                        .font(.title3)
                        .bold()
                        .padding()
                    ScrollView(.vertical) {
                        VStack(alignment: .leading, spacing: 5) {
                            ForEach(parameters.resources) { resource in
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

                        Text("Quantidade de instâncias do recurso:")
                            .font(.headline)
                        TextField("Ex: 2", text: Binding(
                            get: { resourceInstances },
                            set: { newValue in
                                // Mantém apenas dígitos (0–9)
                                let filtered = newValue.filter { $0.isNumber }
                                resourceInstances = filtered
                            }
                        ))
                    }

                    Button {
                        if let newID = generateNextID() {
                            parameters.resources.append(Resource(name: resourceName, id: newID, quantity: Int(resourceInstances)!))
                            print("Recurso adicionado com ID: \(newID)")
                            resourceName = ""
                            resourceInstances = ""
                        } else {
                            print("Todos os IDs de 0 a 9 já estão em uso.")
                        }
                    } label: {
                        Text("Adicionar recurso")
                            .font(.headline)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(resourceName.isEmpty || Int(resourceInstances) == nil || Int(resourceInstances)! <= 0 || generateNextID() == nil)
                    .keyboardShortcut(.defaultAction)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .padding([.top, .leading, .trailing], 16)
            Button {
                path.append(parameters)
            } label: {
                Text("Continuar")
            }
            .padding([.bottom, .top], 10)
            .disabled(parameters.resources.isEmpty)
            .navigationDestination(for: SimulationParameters.self) { parameters in
                SimulationView(parameters: parameters)
            }
        }
    }

    private func generateNextID() -> Int? {
        let usedIDs = parameters.resources.map { $0.id }
        return (0...9).first { !usedIDs.contains($0) }
    }
}

#Preview {
    CreateResourcesView()
}
