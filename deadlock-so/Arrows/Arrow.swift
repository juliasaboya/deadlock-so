//
//  Arrow.swift
//  deadlock-so
//
//  Created by Yane dos Santos on 14/07/25.
//

import SwiftUI

private let strokeStyle = StrokeStyle(lineWidth: 1, lineJoin: .round)
private let shoulderRatio: CGFloat = 0.65

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let shoulderX = rect.minX + (rect.width * shoulderRatio)
        let rowHeight = rect.height/3
        let row1Y: CGFloat = rect.minY + rowHeight
        let row2Y: CGFloat = row1Y + rowHeight
        
        path.move(to: CGPoint(x: rect.minX, y: row1Y))
        path.addLine(to: CGPoint(x: shoulderX, y: row1Y))
        path.addLine(to: CGPoint(x: shoulderX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: shoulderX, y: rect.maxY))
        path.addLine(to: CGPoint(x: shoulderX, y: row2Y ))
        path.addLine(to: CGPoint(x: rect.minX, y: row2Y))

        return path
    }
}

struct ArrowConnector: View {
    let from: CGPoint
    let to: CGPoint

    var body: some View {
        let dx = to.x - from.x
        let dy = to.y - from.y
        let angle = atan2(dy, dx)
        let distance = hypot(dx, dy)

        return Arrow()
            .stroke(Color.blue, style: strokeStyle)
            .frame(width: distance, height: 30) // altura do arrow
            .rotationEffect(.radians(angle))
            .position(x: (from.x + to.x) / 2, y: (from.y + to.y) / 2)
    }
}
