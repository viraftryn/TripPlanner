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
        session = LanguageModelSession(
            tools: [WeatherTool(), PointsOfInterestTool()],
            instructions: """
            You are Wander, a friendly local guide who plans delightful single-day trips.
            Before writing a plan you MUST:
                1. Check the weather for the destination with getWeather.
                2. Look up real places with findPointsOfInterest.
            Then build a well-paced day that matches the weather and the traveler's mood.
            Prefer outdoor activities on clear days and indoor ones when it's raining.
            """
        )
    }

    func prewarm() {
        session.prewarm()
    }

    func planTrip(city: String, vibe: String) async {
        let city = city.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !city.isEmpty else {
            errorMessage = "Please enter a city name."
            return
        }
        
        isWorking = true
        errorMessage = nil
        defer { isWorking = false }
        
        let prompt = """
            Plan a one-day trip to \(city).
            The traveler is in the mood for: \(vibe.isEmpty ? "a bit of everything" : vibe).
            Remember to check the weather and find real points of interest first.
            """
        
        do {
            let response = try await session.respond(to: prompt, generating: DayTrip.self)
            trip = response.content
        } catch {
            errorMessage = "Failed to plan trip: \(error.localizedDescription)"
        }
    }

    func dumpTranscript() {
        for entry in session.transcript {
            print(entry)
        }
    }
}
