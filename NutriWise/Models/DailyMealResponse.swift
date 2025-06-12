//
//  DailyMealResponse.swift
//  NutriWise
//
//  Created by Yasin Cetin on 8.06.2025.
//

import Foundation

struct DailyMealResponse: Codable {
    let meals: [Meal]?
    let totalCalories: Int?
    let totalProtein: Double?
    let totalCarbs: Double?
    let totalFat: Double?
}



struct Meal: Codable {
    let mealType: String?
    let foods: [Food]?
    let totalMealCalories: Int?
    let totalMealProtein: Double?
    let totalMealCarbs: Double?
    let totalMealFat: Double?
}

struct Food: Codable, Identifiable, Hashable {
    var id = UUID() // Decoding dışında tutulur
    
    let name: String?
    let calories: Double?
    let protein: Double?
    let fat: Double?
    let carbs: Double?
    let quantity: Int?
    
    enum CodingKeys: String, CodingKey {
        case name, calories, protein, fat, carbs, quantity
    }
}

