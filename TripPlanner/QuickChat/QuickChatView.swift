//
//  QuickChatView.swift
//  TripPlanner
//
//  Created by Kristanto Sean on 2026-09-05.
//
import SwiftUI

struct QuickChatView: View {
    @State private var chat = QuickChatViewModel()
    @State private var prompt = "What's one underrated thing to do in Porto?"

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                TextField("Ask anything…", text: $prompt, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(1...4)

                Button {
                    Task { await chat.ask(prompt) }
                } label: {
                    Label("Ask", systemImage: "sparkles")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(chat.isResponding)

                ScrollView {
                    Text(chat.answer.isEmpty ? "The answer will stream in here." : chat.answer)
                        .foregroundStyle(chat.answer.isEmpty ? .secondary : .primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .textSelection(.enabled)
                }

                if chat.isResponding {
                    HStack(spacing: 8) {
                        ProgressView()
                        Text("Thinking on-device…").foregroundStyle(.secondary)
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Ask Wander")
        }
    }
}

#Preview {
    QuickChatView()
}
