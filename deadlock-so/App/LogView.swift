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
    var logs: [LogEntry]
    var proxy: GeometryProxy
    init(logs: [LogEntry], proxy: GeometryProxy) {
        self.logs = logs
        self.proxy = proxy
    }

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                ForEach(logs.reversed(), id: \.self) { log in
                    Text(log.message)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: proxy.size.height*0.0175))
                        .fontWeight(.semibold)
                        .foregroundStyle(.branco)
                    Spacer()
                }


            }

        }

        .frame(width: 0.3*proxy.size.width, height: 0.19*proxy.size.height)
        .border(.blue)
    }
}

#Preview {
    GeometryReader { proxy in
        LogView(logs: [LogEntry(message: "[Processo 1] Liberou recurso Buffer de memória")], proxy: proxy)
    }
    .frame(width: 1440, height: 1024)
}
