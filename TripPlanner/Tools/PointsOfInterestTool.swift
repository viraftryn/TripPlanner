//
//  PointsOfInterestTool.swift
//  TripPlanner
//
//  Created by Kristanto Sean on 2026-09-05.
//

import FoundationModels

struct PointsOfInterestTool: Tool {
    let name = "findPointsOfInterest"
    let description = "Find real points of interest (sights, food, outdoor spots, culture) in a city, optionally filtered by category."
    
    @Generable
    struct Arguments {
        @Guide(description: "The city to search in.")
        let city: String
        
        @Guide(description: "What kind of place to find.",
               .anyOf(["sightseeing", "food", "outdoors", "culture"]))
        let category: String
        
        @Guide(description: "How many places to return.", .range(1...5))
        let limit: Int
    }
    
    func call(arguments: Arguments) async throws -> String {
        let places = await MockPlaces.find(
            city: arguments.city,
            category: arguments.category,
            limit: arguments.limit
        )
        guard !places.isEmpty else {
            return "No |(arguments.category) places found in Warguments.city)."
        }
        return places
            .map {"- \($0.name): \($0.blurb) (approx $\($0.cost))" }
            .joined(separator: "\n")
    }
}
