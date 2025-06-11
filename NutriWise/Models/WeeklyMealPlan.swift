//
//  WeeklyMealPlan.swift
//  NutriWise
//
//  Created by Yasin Cetin on 11.06.2025.
//

import Foundation

struct WeeklyMealPlan: Codable {
    let startDate: String
    let endDate: String
    let plannedMeals: [PlannedMeal]
}

struct PlannedMeal: Codable, Identifiable {
    var id: UUID = UUID()
    let day: String
    let mealType: Int
    let foods: [PlannedFood]

    private enum CodingKeys: String, CodingKey {
        case day, mealType, foods
    }
}

struct PlannedFood: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    let name: String
    let calories: Double
    let protein: Double
    let carbs: Double
    let fat: Double
    let mealTypes: [String]
    let portionGrams: Double

    private enum CodingKeys: String, CodingKey {
        case name, calories, protein, carbs, fat, mealTypes, portionGrams
    }
}
