//
//  ResourceView.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 11/07/25.
//

import SwiftUI

struct ResourceView: View {
    let resource: Resource
    var body: some View {
        VStack(spacing: 0) {
            Text("\(resource.id): \(resource.name)")
                .font(.system(size: 14))
                .bold()
                .foregroundStyle(.azulEscuro)
                .frame(width: 150, height: 27)
                .background(
                    Gradient(colors: [.cinzaEscuroRecursoGrad,.azulClaro, .cinzaMedioRecursoGradiente, ])
                )
                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 8, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 8))

            //linha divisora
            Rectangle()
                .frame(width: 150, height: 2)
                .foregroundStyle(.black)

            Text("\(resource.totalInstances)")
                .font(.system(size: 32))
                .bold()
                .foregroundStyle(.azulEscuro)
                .frame(width: 150, height: 58)
                .background(
                    Gradient(colors: [.azulClaro, .cinzaMedioRecursoGradiente, .cinzaEscuroRecursoGrad])

                )
                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 8, bottomTrailingRadius:8, topTrailingRadius: 0))
        }


    }
}

#Preview {
    ResourceView(resource: Resource(name: "Buffer de memória", id: 0, quantity: 5))
        .frame(width: 200, height: 200)
}
