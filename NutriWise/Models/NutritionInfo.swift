//
//  NutritionInfo.swift
//  NutriWise
//
//  Created by Yasin Cetin on 8.06.2025.
//

import Foundation

struct NutritionInfo: Codable, Identifiable {
    var id = UUID() // sadece SwiftUI için
    let name: String
    let calories: Double
    let protein: Double
    let carbs: Double
    let fat: Double
    let mealTypes: [Int]
    let portionGrams: Double

    private enum CodingKeys: String, CodingKey {
        case name, calories, protein, carbs, fat, mealTypes, portionGrams
        // id dahil edilmediği için JSON'dan parse edilmez
    }
}

