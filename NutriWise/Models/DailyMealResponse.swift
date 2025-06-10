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
}


struct Meal: Codable {
    let mealType: String?
    let foods: [Food]?
    let totalMealCalories: Int?
}


struct Food: Codable, Identifiable, Hashable {
    var id = UUID() // ← decode işlemi dışı
    
    let name: String?
    let calories: Int?
    let protein: Int?
    let fat: Int?
    let carbs: Int?
    let quantity: Int?
    
    enum CodingKeys: String, CodingKey {
        case name, calories, protein, fat, carbs, quantity
    }
}
