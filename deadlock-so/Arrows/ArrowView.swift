//
//  ArrowView.swift
//  deadlock-so
//
//  Created by Yane dos Santos on 14/07/25.
//

import SwiftUI

struct ArrowView: View {
    @State private var positions: [Int : CGPoint] = [0:CGPoint(x: -100, y: 10), 1:CGPoint(x: 100, y: 10), 2:CGPoint(x: 300, y: 10)]
    @State var processes: [Int] = [3,4,5]
    var body: some View {
        ZStack {
            GeometryReader { geo in
                           ZStack {
                               ForEach(Array(processes.enumerated()), id: \.offset) { index, _ in
                                   RoundedRectangle(cornerRadius: 20)
                                       .frame(width: 100, height: 100)
                                       .foregroundColor(.orange)
                                       .anchorPreference(key: FramePreferenceKey.self, value: .center) {
                                           [index: $0]
                                       }
                                       .position(x: CGFloat(100 + index * 120), y: 100)
                               }
                           }
                           .onPreferenceChange(FramePreferenceKey.self) { prefs in
                               for (index, anchor) in prefs {
                                   positions[index] = geo[anchor]
                               }
                           }
                       }

                       // Quando as posições forem detectadas, desenha a seta
                       if let from = positions[0], let to = positions[1] {
                           ArrowConnector(from: from, to: to)
                       }
            Button {
                processes.append(10)
                print(processes.count)
            } label: {
                Text("Adicionar processos")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct FramePreferenceKey: PreferenceKey {
    static var defaultValue: [Int: Anchor<CGPoint>] = [:]
    static func reduce(value: inout [Int: Anchor<CGPoint>], nextValue: () -> [Int: Anchor<CGPoint>]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

#Preview {
    ArrowView()
}
