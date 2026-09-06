//
//  TripPlannerView.swift
//  TripPlanner
//
//  Created by Kristanto Sean on 2026-09-05.
//


import SwiftUI

struct TripPlannerView: View {
    @State private var planner = TripPlannerViewModel()
    @State private var city = "Kyoto"
    @State private var vibe = "relaxed, a little food, some history"

    var body: some View {
        NavigationStack {
            Form {
                Section("Where to?") {
                    TextField("City", text: $city)
                    TextField("What are you in the mood for?", text: $vibe, axis: .vertical)
                        .lineLimit(1...3)
                }

                Section {
                    Button {
                        Task { await planner.planTrip(city: city, vibe: vibe) }
                    } label: {
                        if planner.isWorking {
                            HStack { ProgressView(); Text("Planning your day…") }
                        } else {
                            Label("Plan my day", systemImage: "wand.and.stars")
                        }
                    }
                    .disabled(planner.isWorking)
                }

                if let message = planner.errorMessage {
                    Section {
                        Label(message, systemImage: "exclamationmark.triangle")
                            .foregroundStyle(.orange)
                    }
                }

                if let trip = planner.trip {
                    TripSection(trip: trip)
                }
            }
            .navigationTitle("Plan a Day")
            // Warm the model up as soon as the screen appears — the user is very likely about to tap "Plan my day".
            .task { planner.prewarm() }
        }
    }
}

private struct TripSection: View {
    let trip: DayTrip

    var body: some View {
        Section(trip.title) {
            Text(trip.summary)
                .font(.callout)
                .foregroundStyle(.secondary)

            ForEach(Array(trip.activities.enumerated()), id: \.offset) { _, activity in
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Label(activity.timeOfDay.label, systemImage: activity.timeOfDay.symbol)
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.tint)
                        Spacer()
                        Text(activity.estimatedCostUSD == 0 ? "Free" : "$\(activity.estimatedCostUSD)")
                            .font(.caption.monospacedDigit())
                            .foregroundStyle(.secondary)
                    }
                    Text(activity.name).font(.headline)
                    Text(activity.detail).font(.subheadline).foregroundStyle(.secondary)
                }
                .padding(.vertical, 4)
            }
        }
    }
}
