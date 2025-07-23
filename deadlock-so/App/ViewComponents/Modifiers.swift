//
//  SwiftUIView.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 23/07/25.
//

import SwiftUI

struct DropLightModifer: ViewModifier {
    var isOn: Bool
    func body(content: Content) -> some View {
        content
            .shadow(color: isOn ? .verdeProcessos : .clear, radius: 3, x: 0, y: 2)
            .shadow(color: isOn ? .verdeProcessos : .clear, radius: 3, x: 0, y: -2)
    }
}

extension View {
    func dropLight(isOn: Bool) -> some View {
        modifier(DropLightModifer(isOn: isOn))
    }
}
