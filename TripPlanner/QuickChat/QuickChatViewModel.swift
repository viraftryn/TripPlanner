//
//  QuickChat.swift
//  TripPlanner
//
//  Created by Kristanto Sean on 2026-09-05.
//

import FoundationModels
import Observation
import Foundation

@MainActor
@Observable
final class QuickChatViewModel {
    var answer: String = ""
    var isResponding: Bool = false

    private let session = LanguageModelSession(
        instructions: """
        You are a warm, concise travel companion. Answer in at most three sentences.
        When you don't know something, say so plainly instead of inventing details.
        """
    )

    // Streaming Version
    func ask(_ prompt: String) async {
        guard !prompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        answer = ""
        isResponding = true
        defer { isResponding = false }
        
        do {
            let stream = session.streamResponse(to: prompt)
            for try await partial in stream {
                answer = partial.content
            }
        } catch {
            answer = "Something went wrong: \(error.localizedDescription)"
        }
    }

    // Non-Streaming Version
    func askOnce(_ prompt: String) async {
        isResponding = true
        defer { isResponding = false }
        do {
            let respons = try await session.respond(to: prompt)
            answer = respons.content
        } catch {
            answer = "Something went wrong: \(error.localizedDescription)"
        }
    }
}
