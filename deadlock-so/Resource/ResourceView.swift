//
//  ResourceView.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 11/07/25.
//

import SwiftUI

struct ResourceView: View {
    var body: some View {
        VStack {
            Text("R1")
                .bold()
                .frame(maxHeight: .infinity, alignment: .top)
                .padding()

            Grid {

            }
        }
        .frame(width: 100, height: 100)
        .background {
            RoundedRectangle(cornerRadius: 2)
                .foregroundStyle(.gray)
        }

    }
}

#Preview {
    ResourceView()
        .frame(width: 200, height: 200)
}
