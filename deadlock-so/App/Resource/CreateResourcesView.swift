//
//  CreateResourcesView.swift
//  deadlock-so
//
//  Created by Yane dos Santos on 16/07/25.
//

import SwiftUI

struct CreateResourcesView: View {
    @State var parameters = SimulationParameters(resources: [], deltaT: 0)
    
    @State private var resourceName: String = ""
    @State private var resourceInstances: String = ""
    @State private var interval: String = ""
    
    @State private var path = NavigationPath()
    
    @State private var navegar = false
    var body: some View {
        GeometryReader { geometry in
            NavigationStack (path: $path){
                HStack {
                    VStack {
                        Text("Lista de recursos:")
                            .font(.system(size: geometry.size.height/20))
                            .bold()
                            .padding()
                        ScrollView(.vertical) {
                            VStack(alignment: .leading, spacing: 5) {
                                ForEach(parameters.resources) { resource in
                                    Text("\(resource.name) (ID: \(resource.id))")
                                        .font(.system(size: geometry.size.height/30))
                                        .bold()
                                    Text("Quantidade de instâncias: \(resource.totalInstances)")
                                        .font(.system(size: geometry.size.height/30))
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
                            .font(.system(size: geometry.size.height/20))
                            .bold()
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Nome do recurso:")
                                .font(.system(size: geometry.size.height/30))
                            TextField("Digite o nome do recurso", text: $resourceName)
                                .textFieldStyle(CustomTextFieldStyle())
                            
                            Text("Quantidade de instâncias do recurso:")
                                .font(.system(size: geometry.size.height/30))
                            TextField("Ex: 2", text: Binding(
                                get: { resourceInstances },
                                set: { newValue in
                                    let filtered = newValue.filter { $0.isNumber }
                                    resourceInstances = filtered
                                }
                            ))
                            .textFieldStyle(CustomTextFieldStyle())
                            
                            
                        }
                        
                        Button {
                            if let newID = generateNextID() {
                                parameters.resources.append(Resource(name: resourceName, id: newID, quantity: Int(resourceInstances)!))
                                resourceName = ""
                                resourceInstances = ""
                            } else {
                                print("Todos os IDs de 0 a 9 já estão em uso.")
                            }
                        } label: {
                            Text("Adicionar recurso")
                                .font(.system(size: geometry.size.height/30))
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(resourceName.isEmpty || Int(resourceInstances) == nil || Int(resourceInstances)! <= 0 || generateNextID() == nil || parameters.resources.count == 10)
                        .keyboardShortcut(.defaultAction)
                        
                        Text("Intervalo de detecção de deadlocks (em segundos):")
                            .font(.system(size: geometry.size.height/30))
                        TextField("Ex: 2", text: Binding(
                            get: { interval },
                            set: { newValue in

                                let filtered = newValue.filter { $0.isNumber }
                                interval = filtered
                            }
                        ))
                        .textFieldStyle(CustomTextFieldStyle())
                        
                        Button {
                            parameters.deltaT = TimeInterval(Int(interval)!)
                            path.append(parameters)
                        } label: {
                            Text("Continuar")
                                .font(.system(size: geometry.size.height/30))
                        }
                        .padding([.bottom, .top], 10)
                        .disabled(parameters.resources.isEmpty || interval == "")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                }
                .padding([.top, .leading, .trailing], 16)
                
                .navigationDestination(for: SimulationParameters.self) { parameters in
                    NewSimulationView(simulationVM: SimulationViewModel(parameters: parameters))
                }
            }
        }
        .toolbar(.hidden)
    }

    private func generateNextID() -> Int? {
        let usedIDs = parameters.resources.map { $0.id }
        return (0...9).first { !usedIDs.contains($0) }
    }
}

public struct CustomTextFieldStyle : TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.largeTitle)
    }
}

#Preview {
    CreateResourcesView()
}
