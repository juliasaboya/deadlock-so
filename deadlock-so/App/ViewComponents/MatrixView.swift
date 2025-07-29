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
    let constant: CGFloat
    var vectorData: [Int]
    var a_matrixData: [[Int]]
    var r_matrixData: [[Int]]

    init(proxy: GeometryProxy, vectorData: [Int], a_matrixData: [[Int]], r_matrixData: [[Int]]) {
        self.cellSize = proxy.size.width*0.025
        self.vectorData = vectorData
        self.a_matrixData = a_matrixData
        self.r_matrixData = r_matrixData
        self.constant = cellSize*0.35
    }


    var body: some View {
        VStack {
            HStack {
                Text("P100")
                    .font(.system(size: constant))
                    .bold()
                    .foregroundStyle(.clear)

                ZStack {
                    VStack(spacing: 0) {
                        ForEach(0..<1, id: \.self) { _ in
                            HStack(spacing: 0) {
                                ForEach(0..<columns, id: \.self) { col in
                                    Text("R\(col)")
                                        .font(.system(size: constant*1.5))
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
                Text("P100")
                    .font(.system(size: constant))
                    .bold()
                    .foregroundStyle(.clear)

                Text("Existente")
                    .bold()
                    .textCase(.uppercase)

                    .font(.system(size: constant))
            }
            HStack {
                Text("P100")
                    .font(.system(size: constant))
                    .bold()
                    .foregroundStyle(.clear)
                ZStack {
                    GridLines(rows: 1, columns: columns, cellSize: cellSize)
                        .stroke(.branco, lineWidth: 1.35)

                    VStack(spacing: 0) {
                        ForEach(0..<1, id: \.self) { _ in
                            HStack(spacing: 0) {
                                ForEach(vectorData, id: \.self) { data in
                                    Text("\(data)")
                                        .font(.system(size: constant))
                                        .frame(width: cellSize, height: cellSize)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(width: cellSize * CGFloat(columns), height: cellSize * CGFloat(1))
            }

            HStack {
                Text("P10")
                    .font(.system(size: constant))
                    .bold()
                    .foregroundStyle(.clear)
                Text("Corrente")
                    .textCase(.uppercase)
                    .bold()
                    .font(.system(size: constant))
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
                        ForEach(a_matrixData, id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(row, id: \.self) { data in
                                    // alimentar aqui
                                    Text("\(data)")
                                        .font(.system(size: constant))

                                        .frame(width: cellSize, height: cellSize)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
                .frame(width: cellSize * CGFloat(columns), height: cellSize * CGFloat(rows))

            }

            HStack {
                Text("P10")
                    .font(.system(size: constant))
                    .bold()
                    .foregroundStyle(.clear)
                Text("Requisições")
                    .textCase(.uppercase)
                    .font(.system(size: constant))
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
                        ForEach(r_matrixData, id: \.self) { row in
                            HStack(spacing: 0) {
                                ForEach(row, id: \.self) { data in
                                    Text("\(data)")
                                        .font(.system(size: constant))

                                        .frame(width: cellSize, height: cellSize)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
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
        for row in 0...rows {
            let y = CGFloat(row) * cellSize
            path.move(to: CGPoint(x: 0, y: y))
            path.addLine(to: CGPoint(x: CGFloat(columns) * cellSize, y: y))
        }
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
        MatrixView(
            proxy: proxy,
            vectorData: [3, 1, 4, 0, 2, 5, 6, 1, 0, 3], a_matrixData: [
                [0, 2, 1, 3, 0, 1, 0, 2, 0, 1],
                [1, 0, 0, 2, 3, 1, 0, 0, 0, 2],
                [2, 1, 0, 0, 1, 2, 3, 0, 0, 1],
                [0, 3, 2, 1, 0, 0, 1, 2, 1, 0],
                [1, 0, 1, 0, 2, 3, 0, 1, 0, 2],
                [0, 1, 0, 3, 2, 1, 0, 0, 2, 1],
                [1, 2, 0, 0, 3, 1, 2, 0, 1, 0],
                [0, 0, 1, 2, 0, 1, 0, 3, 2, 1],
                [1, 0, 2, 0, 1, 0, 3, 2, 0, 0],
                [0, 1, 0, 1, 2, 3, 0, 0, 1, 1]
            ],
            r_matrixData: [
                [0, 1, 0, 0, 1, 0, 1, 0, 2, 0],
                [1, 0, 1, 2, 0, 0, 1, 1, 0, 1],
                [0, 1, 2, 0, 0, 1, 0, 1, 1, 0],
                [1, 0, 1, 1, 0, 1, 2, 0, 0, 1],
                [0, 0, 2, 1, 0, 0, 1, 0, 2, 1],
                [2, 1, 0, 1, 0, 2, 0, 1, 0, 0],
                [0, 0, 1, 1, 2, 1, 0, 0, 1, 2],
                [1, 1, 0, 2, 1, 0, 0, 1, 1, 0],
                [0, 0, 1, 0, 2, 1, 1, 0, 0, 1],
                [1, 1, 0, 0, 1, 0, 2, 1, 0, 0]
            ])
    }
}
