//
//  WeightEntry.swift
//  NutriWise
//
//  Created by Yasin Cetin on 12.06.2025.
//

import Foundation

struct WeightEntry: Codable, Identifiable {
    var id: UUID = UUID() // Grafikte Identifiable olması için
    let date: String
    let weight: Double

    enum CodingKeys: String, CodingKey {
        case date, weight
    }
}
