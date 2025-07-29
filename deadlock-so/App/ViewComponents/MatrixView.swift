//
//  MatrizView.swift
//  deadlock-so
//
//  Created by Júlia Saboya on 27/07/25.
//

import SwiftUI

struct MatrixView: View {
    let rows = 10
    let columns = 10
    var cellSize: CGFloat
    init(proxy: GeometryProxy) {
        self.cellSize = proxy.size.width*0.025
    }

    var body: some View {
        VStack {
            HStack {
                Text("P10")
                    .font(.system(size: 0.55*cellSize))
                    .bold()
                    .foregroundStyle(.clear)

                ZStack {
                    VStack(spacing: 0) {
                        ForEach(0..<1, id: \.self) { _ in
                            HStack(spacing: 0) {
                                ForEach(0..<columns, id: \.self) { col in
                                    Text("R\(col)")
                                        .font(.system(size: 0.55*cellSize))
                                        .bold()
                                        .frame(width: cellSize, height: cellSize)
                                }
                            }
                        }
                    }
                }
                .frame(width: cellSize * CGFloat(columns), height: cellSize * CGFloat(1))
            }
            HStack {
                Text("P10")
                    .font(.system(size: 0.55*cellSize))
                    .bold()
                    .foregroundStyle(.clear)

                Text("Existente")
                    .bold()
                    .textCase(.uppercase)

                    .font(.system(size: 0.55*cellSize))
            }
            HStack {
                Text("P10")
                    .font(.system(size: 0.55*cellSize))
                    .bold()
                    .foregroundStyle(.clear)
            ZStack {
                GridLines(rows: 1, columns: columns, cellSize: cellSize)
                    .stroke(.branco, lineWidth: 1.35)

                VStack(spacing: 0) {
                    ForEach(0..<1, id: \.self) { _ in
                        HStack(spacing: 0) {
                            ForEach(0..<columns, id: \.self) { _ in
                                // alimentar aqui
                                Text("0")
                                    .font(.system(size: 0.55*cellSize))

                                    .frame(width: cellSize, height: cellSize)
                            }
                        }
                    }
                }
            }
            .frame(width: cellSize * CGFloat(columns), height: cellSize * CGFloat(1))
            }

            HStack {
                Text("P10")
                    .font(.system(size: 0.55*cellSize))
                    .bold()
                    .foregroundStyle(.clear)
                Text("Corrente")
                    .textCase(.uppercase)
                    .bold()
                    .font(.system(size: 0.55*cellSize))
            }

            HStack {
                ZStack {
                    VStack(spacing: 0) {
                        ForEach(0..<rows, id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(0..<1, id: \.self) { _ in

                                    Text("P\(row+1)")
                                        .font(.system(size: 0.5*cellSize))
                                        .bold()
                                        .frame(width: cellSize, height: cellSize)
                                }
                            }
                        }
                    }
                }
                .frame(width: cellSize * CGFloat(1), height: cellSize * CGFloat(rows))
                ZStack {
                    GridLines(rows: rows, columns: columns, cellSize: cellSize)
                        .stroke(.branco, lineWidth: 1.35)
                    
                    VStack(spacing: 0) {
                        ForEach(0..<rows, id: \.self) { _ in
                            HStack(spacing: 0) {
                                ForEach(0..<columns, id: \.self) { _ in
                                    // alimentar aqui
                                    Text("0")
                                        .font(.system(size: 0.55*cellSize))

                                        .frame(width: cellSize, height: cellSize)
                                }
                            }
                        }
                    }
                }
                .frame(width: cellSize * CGFloat(columns), height: cellSize * CGFloat(rows))

            }

            HStack {
                Text("P10")
                    .font(.system(size: 0.55*cellSize))
                    .bold()
                    .foregroundStyle(.clear)
                Text("Requisições")
                    .textCase(.uppercase)
                    .font(.system(size: 0.55*cellSize))
            }
            HStack {
                ZStack {
                    VStack(spacing: 0) {
                        ForEach(0..<rows, id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(0..<1, id: \.self) { _ in

                                    Text("P\(row+1)")
                                        .font(.system(size: 0.5*cellSize))
                                        .bold()
                                        .frame(width: cellSize, height: cellSize)
                                }
                            }
                        }
                    }
                }
                .frame(width: cellSize * CGFloat(1), height: cellSize * CGFloat(rows))
                ZStack {
                    GridLines(rows: rows, columns: columns, cellSize: cellSize)
                        .stroke(.branco, lineWidth: 1.35)
                    
                    VStack(spacing: 0) {
                        ForEach(0..<rows, id: \.self) { _ in
                            HStack(spacing: 0) {
                                ForEach(0..<columns, id: \.self) { _ in
                                    Text("0")
                                        .font(.system(size: 0.55*cellSize))

                                        .frame(width: cellSize, height: cellSize)
                                }
                            }
                        }
                    }
                }
                .frame(width: cellSize * CGFloat(columns), height: cellSize * CGFloat(rows))
            }
    }
    }
}

struct GridLines: Shape {
    let rows: Int
    let columns: Int
    let cellSize: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Desenhar linhas horizontais
        for row in 0...rows {
            let y = CGFloat(row) * cellSize
            path.move(to: CGPoint(x: 0, y: y))
            path.addLine(to: CGPoint(x: CGFloat(columns) * cellSize, y: y))
        }

        // Desenhar linhas verticais
        for column in 0...columns {
            let x = CGFloat(column) * cellSize
            path.move(to: CGPoint(x: x, y: 0))
            path.addLine(to: CGPoint(x: x, y: CGFloat(rows) * cellSize))
        }

        return path
    }
}

#Preview {
    GeometryReader { proxy in
        MatrixView(proxy: proxy)
    }
}
