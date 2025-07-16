//
//  LogView.swift
//  deadlock-so
//
//  Created by Yane dos Santos on 16/07/25.
//

import SwiftUI

struct LogEntry: Identifiable, Hashable {
    let id = UUID()
    let message: String
}

struct LogView: View {
    let size: CGSize
    @ObservedObject var deadlockVM: DeadlockVM
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let columnCount = 3
    let maxRows = 5
    
    var columnLogs: [[LogEntry]] {
        var result: [[LogEntry]] = Array(repeating: [], count: columnCount)
        for (index, log) in deadlockVM.logs.prefix(columnCount * maxRows).enumerated() {
            let column = index / maxRows
            if column < columnCount {
                result[column].append(log)
            }
        }
        return result
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ForEach(0..<columnCount, id: \.self) { columnIndex in
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(columnLogs[columnIndex], id: \.self) { log in
                        Text(log.message)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(8)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)
                    }
                    // Preenche espaço se a coluna estiver incompleta
                    ForEach(0..<(maxRows - columnLogs[columnIndex].count), id: \.self) { _ in
                        Spacer()
                    }
                }
                .frame(height: size.height/3)
            }
        }
        .frame(width: size.width)
    }
}
