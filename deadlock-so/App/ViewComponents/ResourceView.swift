//
//  ResourceView.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 11/07/25.
//

import SwiftUI

struct ResourceView: View {
    let resource: Resource
    let width: CGFloat
    let totalHeight: CGFloat
    let cornerRadius: CGFloat
    var availableResources: [ResourceSemaphore]
    init(resource: Resource, availableResources: [ResourceSemaphore],width: CGFloat, totalHeight: CGFloat) {
        self.resource = resource
        self.availableResources = availableResources
        self.width = width
        self.totalHeight = totalHeight
        self.cornerRadius = 0.07 * totalHeight
    }
    var body: some View {
        VStack(spacing: 0) {
            Text("R\(resource.id): \(resource.name)")
                .font(.system(size: 0.17 * totalHeight))
                .multilineTextAlignment(.center)
                .bold()
                .foregroundStyle(.azulEscuro)
                .frame(width: width, height: 0.44 * totalHeight)
                .background(
                    Gradient(colors: [.cinzaEscuroRecursoGrad,.azulClaro, .cinzaMedioRecursoGradiente, ])
                )
                .clipShape(UnevenRoundedRectangle(topLeadingRadius: cornerRadius, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: cornerRadius))

            //linha divisora
            Rectangle()
                .frame(width: width, height: 0.009 * totalHeight)
                .foregroundStyle(.black)

            Text("\(resource.totalInstances)")
                .font(.system(size: 0.3 * totalHeight))
                .bold()
                .foregroundStyle(.azulEscuro)
                .frame(width: width, height: 0.56 * totalHeight)
                .background(
                    Gradient(colors: [.azulClaro, .cinzaMedioRecursoGradiente, .cinzaEscuroRecursoGrad])

                )
                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: cornerRadius, bottomTrailingRadius:cornerRadius, topTrailingRadius: 0))
        }


    }
}

#Preview {
    ResourceView(resource: Resource(name: "Buffer de memória", id: 500, quantity: 5000), availableResources: [ResourceSemaphore(value: 1)], width: 133, totalHeight: 104)
        .frame(width: 200, height: 200)
}
