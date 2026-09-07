//
//  WeatherTool.swift
//  TripPlanner
//
//  Created by Kristanto Sean on 2026-09-05.
//

import FoundationModels

struct WeatherTool: Tool {
    let name = "getWeather"
    let description = "Get today's weather forecast for a city so the day's plan can suit the conditions."
    
    @Generable
    struct Arguments {
        @Guide(description: "The city to get the weather for, e.g. \"Kyoto\" or \"Lisbon\".")
        let city: String
    }
    
    func call(arguments: Arguments) async throws -> String {
        await MockWeather.forecast(for: arguments.city)
    }
}
