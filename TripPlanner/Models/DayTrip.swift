//
//  DayTrip.swift
//  TripPlanner
//
//  Created by Kristanto Sean on 2026-09-05.
//

import FoundationModels

@Generable
struct DayTrip: Equatable {
    @Guide(description: "A short, evocative title for the day, e.g. \"A Rainy-Day Ramble Through Old Kyoto\".")
    let title: String
    
    @Guide(description: "Thee to five things to do, in chronological order from morning to evening")
    let activities: [Activity]
    
    @Guide(description: "One or two sentences capturing the overall mood of the day")
    let summary: String
}
