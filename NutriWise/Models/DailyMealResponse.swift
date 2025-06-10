//
//  DailyMealResponse.swift
//  NutriWise
//
//  Created by Yasin Cetin on 8.06.2025.
//

import Foundation

struct DailyMealResponse: Codable {
    let meals: [Meal]?
    let totalCaloriesToday: Int?
}

struct Meal: Codable {
    let mealType: String?
    let foods: [Food]?
    let totalMealCalories: Int?
}


struct Food: Codable, Identifiable {
    var id = UUID()
    let name: String?
    let calories: Int?
    let protein: Int?
    let fat: Int?
    let carbs: Int?
    let quantity: Int?
}
