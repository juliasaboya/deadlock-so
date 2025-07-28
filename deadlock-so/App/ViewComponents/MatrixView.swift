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
    let cellSize: CGFloat = 36

    var body: some View {
        VStack {
            HStack {
                Text("P10")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(.clear)

                ZStack {
                    VStack(spacing: 0) {
                        ForEach(0..<1, id: \.self) { _ in
                            HStack(spacing: 0) {
                                ForEach(0..<columns, id: \.self) { col in
                                    Text("R\(col)")
                                        .font(.system(size: 20))
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
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(.clear)

                Text("Existente")
                    .bold()
                    .font(.system(size: 20))
            }
            HStack {
                Text("P10")
                    .font(.system(size: 20))
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
                                    .frame(width: cellSize, height: cellSize)
                            }
                        }
                    }
                }
            }
            .frame(width: cellSize * CGFloat(columns), height: cellSize * CGFloat(1))
            }

            Text("Corrente")
                .font(.system(size: 20))

            HStack {
                ZStack {
                    VStack(spacing: 0) {
                        ForEach(0..<rows, id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(0..<1, id: \.self) { _ in

                                    Text("P\(row+1)")
                                        .font(.system(size: 20))
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
                                        .frame(width: cellSize, height: cellSize)
                                }
                            }
                        }
                    }
                }
                .frame(width: cellSize * CGFloat(columns), height: cellSize * CGFloat(rows))

            }

        Text("Requisições")
                .font(.system(size: 20))
            HStack {
                ZStack {
                    VStack(spacing: 0) {
                        ForEach(0..<rows, id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(0..<1, id: \.self) { _ in

                                    Text("P\(row+1)")
                                        .font(.system(size: 20))
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
    MatrixView()
        .frame(height: 900)
}
