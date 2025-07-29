//
//  ButtonView.swift
//  deadlock-so
//
//  Created by Yane dos Santos on 28/07/25.
//

import SwiftUI

struct ButtonView: View {
    let topText: String
    let imageSymbol: String
    let imageButton: String
    let proxy: GeometryProxy
    var body: some View {
        ZStack {
            Image("\(imageButton)")
                .resizable()
                .frame(width: proxy.size.width/12, height: proxy.size.height*0.19)
                .background(Color.clear)
            VStack(spacing: 20) {
                Text(topText)
                    .bold()
                    .font(.system(size: proxy.size.height*0.02))
                Image(systemName: "\(imageSymbol)")
                    .resizable()
                    .bold()
                    .frame(
                        width: proxy.size.height*0.045,
                        height: proxy.size.height*0.045
                    )
                Text("Processo")
                    .bold()
                    .font(.system(size: proxy.size.height*0.02))
            }
        }
    }
}

#Preview {
    GeometryReader { proxy in
        ButtonView(topText: "Criar", imageSymbol: "plus.circle", imageButton: "CriarProcessoImagem", proxy: proxy)
    }
    .frame(width: 1440, height: 1024)
    
}
