//
//  TripPlanner.swift
//  TripPlanner
//
//  Created by Kristanto Sean on 2026-09-05.
//


import SwiftUI
import FoundationModels
import Observation

@MainActor
@Observable
final class TripPlannerViewModel {
    var trip: DayTrip?
    var errorMessage: String?
    var isWorking: Bool = false

    private let session: LanguageModelSession

    init() {
        // Tools are passed once, at session creation. Instructions set the ground rules.
        session = LanguageModelSession(instructions: """
            You are Wander, a friendly local guide who plans delightful single-day trips.
        """)
    }

    func prewarm() {
        session.prewarm()
    }

    func planTrip(city: String, vibe: String) async {

        
        
    }

    func dumpTranscript() {
        for entry in session.transcript {
            print(entry)
        }
    }
}
