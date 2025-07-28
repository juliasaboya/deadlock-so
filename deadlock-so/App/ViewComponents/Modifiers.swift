//
//  SwiftUIView.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 23/07/25.
//

import SwiftUI

struct Keyframes {
    var shadowRadius: CGFloat = 0
    var shadowX: CGFloat = 0
    var shadowY1: CGFloat = 0
    var shadowY2: CGFloat = 0


}

struct DropLightModifer: ViewModifier {
    var isOn: Bool
    func body(content: Content) -> some View {
        content

            .keyframeAnimator(initialValue: Keyframes(shadowRadius: 3, shadowY1: 2, shadowY2: -2), repeating: true) { view,frame  in
                view
                    .shadow(color: isOn ? .verdeProcessos : .clear, radius: frame.shadowRadius, x: frame.shadowX, y: frame.shadowY1)
                    .shadow(color: isOn ? .verdeProcessos : .clear, radius: frame.shadowRadius, x: frame.shadowX, y: frame.shadowY2)

            } keyframes: { _ in
                KeyframeTrack(\.shadowRadius){
                    LinearKeyframe(8, duration: 1)
                    LinearKeyframe(3, duration: 0.5)

                }
            }
    }
}

extension View {
    func dropLight(isOn: Bool) -> some View {
        modifier(DropLightModifer(isOn: isOn))
    }
}

#Preview {
    Circle()
        .frame(width: 100)
        .foregroundStyle(.verdeProcessos)
        .dropLight(isOn: true)
        .padding(40)
}
