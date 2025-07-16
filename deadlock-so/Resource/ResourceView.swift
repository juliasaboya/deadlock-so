//
//  ResourceView.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 11/07/25.
//

import SwiftUI

struct ResourceView: View {
    let resource: Resource
    let rows: [GridItem]
    var body: some View {
        VStack(spacing: 8) {
            Text("\(resource.name) (ID: \(resource.id))")
                .font(.headline)
                .foregroundStyle(.black)
            
            LazyHGrid(rows: rows) {
                ForEach(0..<resource.totalInstances, id: \.self) { _ in
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.black)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.secondary)
        )
        .padding(.horizontal)
    }
//        VStack {
//            Text("R1")
//                .bold()
//                .frame(maxHeight: .infinity, alignment: .top)
//                .padding()
//
//            Grid {
//
//            }
//        }
//        .frame(width: 100, height: 100)
//        .background {
//            RoundedRectangle(cornerRadius: 2)
//                .foregroundStyle(.gray)
//        }
//
//    }
}

#Preview {
    ResourceView(resource: Resource(name: "", id: 0, quantity: 0), rows: [])
        .frame(width: 200, height: 200)
}
