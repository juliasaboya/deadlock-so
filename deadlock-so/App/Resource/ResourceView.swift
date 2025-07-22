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
        VStack(spacing: 0) {
            Text("\(resource.id): \(resource.name)")
                .font(.system(size: 15))
                .foregroundStyle(.black)
                .frame(width: 150, height: 27)
                .background(
                    UnevenRoundedRectangle(topLeadingRadius: 10, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 10)


                )
            Rectangle()
                .frame(width: 150, height: 2)
                .foregroundStyle(.black)
            Text("\(resource.totalInstances)")
                .font(.system(size: 15))
                .foregroundStyle(.black)
                .frame(width: 150, height: 58)
                .background(
                    UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 10, bottomTrailingRadius:10, topTrailingRadius: 0)


                )
        }


    }
}

#Preview {
    ResourceView(resource: Resource(name: "Impressora", id: 0, quantity: 0), rows: [])
        .frame(width: 200, height: 200)
}
