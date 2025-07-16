//
//  DailyRecommendation.swift
//  NutriWise
//
//  Created by Yasin Cetin on 11.06.2025.
//

import Foundation

struct DailyRecommendation: Codable {
    let calorieDifference: Int
    let recommendationType: String
    let totalProtein: Double
    let totalCarbs: Double
    let totalFat: Double
    let recommendedFoods: [RecommendedFood]
    let recommendedActivities: [RecommendedActivity]
    let alertMessage: String
}

struct RecommendedFood: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    let name: String
    let calories: Double
    let protein: Double
    let carbs: Double
    let fat: Double

    private enum CodingKeys: String, CodingKey {
        case name, calories, protein, carbs, fat
    }
}

struct RecommendedActivity: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    let name: String
    let caloriesBurned: Int

    private enum CodingKeys: String, CodingKey {
        case name, caloriesBurned
    }
}


