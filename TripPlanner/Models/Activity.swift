//
//  Activity.swift
//  TripPlanner
//
//  Created by Kristanto Sean on 2026-09-06.
//

import FoundationModels

@Generable
struct Activity: Equatable {
    @Guide(description: "The name of the place or activity.")
    let name: String
    
    @Guide(description: "Roughly when in the day this happens.")
    let timeOfDay: TimeOfDay
    
    @Guide(description: "A vivid one-sentence description of what to do here.")
    let detail: String
    
    @Guide(description: "The estimated cost for one person, in USD.", .range(0...500))
    let estimatedCostUSD: Int
}
