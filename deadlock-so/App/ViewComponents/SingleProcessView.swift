//
//  SingleProcessView.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 23/07/25.
//

import SwiftUI


struct SingleProcessView: View {
    var process: ProcessThread
    let circleDiameter: CGFloat
    var backgroundColor: Color {
        if process.isRunning {
            return .verdeProcessos
        }
        return .cinzaPadrao
    }

    init(process: ProcessThread, circleDiameter: CGFloat) {
        self.process = process
        self.circleDiameter = circleDiameter
    }
    var body: some View {
        Text("P\(process.id)")
            .font(.system(size: circleDiameter/2.8, weight: .bold))
            .frame(width: circleDiameter, height: circleDiameter)
            .background(backgroundColor)
            .clipShape(Circle())
            .dropLight(isOn: process.isRunning)
    }
}

