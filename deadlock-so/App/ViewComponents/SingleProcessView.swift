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
        if process.alive {
            return .verdeProcessos
        }
        return .cinzaPadrao
    }
    
    @State var time: Int = 0

    init(process: ProcessThread, circleDiameter: CGFloat) {
        self.process = process
        self.circleDiameter = circleDiameter
    }
    var body: some View {
        VStack{
            Text("\(process.internalTime)")
            Text("P\(process.id)")
                .font(.system(size: circleDiameter/2.8, weight: .bold))
        }
        .frame(width: circleDiameter, height: circleDiameter)
        .background(backgroundColor)
        .clipShape(Circle())
        .dropLight(isOn: process.alive)
//        .onChange(of: process.simulationVM.processesTimes[process.processIndex]) {
//            print("internal time view: \(process.simulationVM.processesTimes[process.processIndex])")
////            time = process.internalTime
//        }
    }
}

