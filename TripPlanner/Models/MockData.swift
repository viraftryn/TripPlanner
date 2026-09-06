//
//  MockWeather.swift
//  TripPlanner
//
//  Created by Kristanto Sean on 2026-09-05.
//


import Foundation

enum MockWeather {
    private static let conditions = ["sunny", "partly cloudy", "overcast", "light rain", "clear and crisp"]

    /// Returns a short natural-language forecast string. Tools that produce natural
    /// language can simply return a `String`.
    static func forecast(for city: String) -> String {
        var seed = seed(for: city)
        let condition = conditions[Int(seed % UInt64(conditions.count))]
        seed /= 7
        let high = 12 + Int(seed % 20)        // 12–31°C
        let low = high - (4 + Int((seed / 3) % 6))
        return "\(city): \(condition), high \(high)°C, low \(low)°C. \(advice(for: condition))"
    }

    private static func advice(for condition: String) -> String {
        switch condition {
        case "light rain": return "Pack a compact umbrella and lean on indoor activities."
        case "sunny", "clear and crisp": return "Great day to be outdoors."
        default: return "Mild enough for a mix of indoor and outdoor plans."
        }
    }
}

// MARK: - Points of interest

struct Place {
    let name: String
    let blurb: String
    let cost: Int      // approx cost for one person, USD
}

enum MockPlaces {
    private static let curated: [String: [String: [Place]]] = [
        "kyoto": [
            "sightseeing": [
                Place(name: "Fushimi Inari Shrine", blurb: "Thousands of vermilion torii gates winding up the mountain.", cost: 0),
                Place(name: "Kinkaku-ji (Golden Pavilion)", blurb: "A gold-leaf temple mirrored in a still pond.", cost: 5)
            ],
            "food": [
                Place(name: "Nishiki Market", blurb: "A covered alley of street food and pickle stalls.", cost: 20),
                Place(name: "Kaiseki dinner in Gion", blurb: "A multi-course seasonal tasting menu.", cost: 90)
            ],
            "outdoors": [
                Place(name: "Arashiyama Bamboo Grove", blurb: "A towering, whispering bamboo forest walk.", cost: 0),
                Place(name: "Philosopher's Path", blurb: "A canal-side stroll under cherry trees.", cost: 0)
            ],
            "culture": [
                Place(name: "Gion tea house district", blurb: "Historic lanes where you may spot a geiko.", cost: 0),
                Place(name: "Kyoto Kimono Experience", blurb: "Rent and wear a kimono for the day.", cost: 45)
            ]
        ],
        "lisbon": [
            "sightseeing": [
                Place(name: "Belém Tower", blurb: "A 16th-century fortress on the Tagus riverfront.", cost: 8),
                Place(name: "São Jorge Castle", blurb: "Hilltop ramparts with sweeping city views.", cost: 15)
            ],
            "food": [
                Place(name: "Time Out Market", blurb: "Dozens of top chefs under one roof.", cost: 25),
                Place(name: "Pastéis de Belém", blurb: "The original custard tart, still warm.", cost: 6)
            ],
            "outdoors": [
                Place(name: "Miradouro da Senhora do Monte", blurb: "The city's best sunset viewpoint.", cost: 0),
                Place(name: "Tram 28 ride", blurb: "A rattling vintage tram through old neighborhoods.", cost: 3)
            ],
            "culture": [
                Place(name: "Fado in Alfama", blurb: "Mournful traditional song in a tiny tavern.", cost: 35),
                Place(name: "Museu Nacional do Azulejo", blurb: "Five centuries of painted tiles.", cost: 8)
            ]
        ]
    ]

    private static let categories = ["sightseeing", "food", "outdoors", "culture"]

    static func find(city: String, category: String, limit: Int) -> [Place] {
        let key = city.lowercased()
        let cat = categories.contains(category) ? category : "sightseeing"

        let pool: [Place]
        if let places = curated[key]?[cat] {
            pool = places
        } else {
            pool = generated(city: city, category: cat)
        }
        return Array(pool.prefix(max(1, limit)))
    }

    // Deterministic filler so any city returns something sensible.
    private static func generated(city: String, category: String) -> [Place] {
        let templates: [String: [(String, String, Int)]] = [
            "sightseeing": [
                ("Old Town Square", "The historic heart of the city.", 0),
                ("Riverside Cathedral", "A landmark worth the climb for the view.", 10),
                ("Grand Market Hall", "A bustling covered market.", 0)
            ],
            "food": [
                ("Central Food Hall", "A sampler of local specialties.", 22),
                ("Corner Bakery", "Fresh pastries and strong coffee.", 8),
                ("Riverside Bistro", "A relaxed sit-down dinner.", 40)
            ],
            "outdoors": [
                ("City Park Loop", "A green walk away from the traffic.", 0),
                ("Harborfront Promenade", "A breezy waterside stroll.", 0),
                ("Botanical Gardens", "Quiet paths and glasshouses.", 7)
            ],
            "culture": [
                ("City Museum", "The story of the place in one building.", 12),
                ("Independent Cinema", "Local and arthouse films.", 14),
                ("Live Music Cellar", "An intimate evening gig.", 30)
            ]
        ]
        let list = templates[category] ?? templates["sightseeing"]!
        return list.map { Place(name: "\($0.0), \(city)", blurb: $0.1, cost: $0.2) }
    }
}

// Small stable string hash (Swift's built-in hashValue is randomized per launch).
private func seed(for string: String) -> UInt64 {
    var hash: UInt64 = 5381
    for byte in string.lowercased().utf8 {
        hash = (hash &* 33) &+ UInt64(byte)
    }
    return hash == 0 ? 1 : hash
}
