//
//  TimeOfDay.swift
//  TripPlanner
//
//  Created by Kristanto Sean on 2026-09-06.
//

import FoundationModels

@Generable
enum TimeOfDay: Equatable {
    case morning
    case midday
    case afternoon
    case evening
}

extension TimeOfDay {
    var label: String {
        switch self {
        case .morning:   "Morning"
        case .midday:    "Midday"
        case .afternoon: "Afternoon"
        case .evening:   "Evening"
        }
    }

    var symbol: String {
        switch self {
        case .morning:   "sunrise"
        case .midday:    "sun.max"
        case .afternoon: "cloud.sun"
        case .evening:   "moon.stars"
        }
    }
}
