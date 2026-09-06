//
//  AvailabilityGate.swift
//  TripPlanner
//
//  Created by Kristanto Sean on 2026-09-05.
//


import SwiftUI
import FoundationModels

struct AvailabilityGate<Content: View>: View {
    @ViewBuilder var content: () -> Content

    private let model = SystemLanguageModel.default

    var body: some View {
        switch model.availability {
        case .available:
            content()

        case .unavailable(let reason):
            ContentUnavailableView {
                Label("On-device model unavailable", systemImage: "brain.head.profile")
            } description: {
                Text(message(for: reason))
            }
        }
    }

    private func message(for reason: SystemLanguageModel.Availability.UnavailableReason) -> String {
        switch reason {
        case .deviceNotEligible:
            return "This device doesn't support Apple Intelligence, so the on-device model can't run here."
        case .appleIntelligenceNotEnabled:
            return "Turn on Apple Intelligence in Settings, then relaunch the app."
        case .modelNotReady:
            return "The model is still downloading or warming up. Give it a minute and try again."
        @unknown default:
            return "The model isn't available right now."
        }
    }
}
