//
//  CoachService.swift
//  NutriWise
//
//  Created by Yasin Cetin on 11.06.2025.
//

import Foundation
import Alamofire

class CoachService {
    static let shared = CoachService()
    private let baseURL = "https://nutrionapp.up.railway.app"

    // Günlük öneri verisi
    func fetchDailyRecommendation(for userId: Int) async throws -> DailyRecommendation {
        let url = "\(baseURL)/api/Recommendation/\(userId)"
        let response = try await AF.request(url)
            .validate()
            .serializingDecodable(DailyRecommendation.self).value
        return response
    }

    // Haftalık plan verisi
    func fetchWeeklyMealPlan(for userId: Int) async throws -> WeeklyMealPlan {
        let url = "\(baseURL)/api/MealPlan/user/\(userId)/weekly-plan"
        let response = try await AF.request(url)
            .validate()
            .serializingDecodable(WeeklyMealPlan.self).value
        return response
    }
}
