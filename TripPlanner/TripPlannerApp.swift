//
//  TripPlannerApp.swift
//  TripPlanner
//
//  Created by Kristanto Sean on 2026-09-05.
//

import SwiftUI

@main
struct TripPlannerApp: App {
    var body: some Scene {
        WindowGroup {
            AvailabilityGate {
                TabView {
                    QuickChatView()
                        .tabItem { Label("Ask", systemImage: "bubble.left.and.text.bubble.right") }

                    TripPlannerView()
                        .tabItem { Label("Plan", systemImage: "map") }
                }
            }
        }
    }
}
