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

    }

    // Non-Streaming Version
    func askOnce(_ prompt: String) async {

    }
}
