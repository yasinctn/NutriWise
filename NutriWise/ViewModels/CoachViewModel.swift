//
//  CoachViewModel.swift
//  NutriWise
//
//  Created by Yasin Cetin on 11.06.2025.
//

import Foundation
import SwiftUI

@MainActor
class CoachViewModel: ObservableObject {
    @Published var recommendation: DailyRecommendation?
    @Published var weeklyPlan: WeeklyMealPlan?
    
    @Published var isLoadingRecommendation = false
    @Published var isLoadingWeeklyPlan = false
    @Published var errorMessage: String?

    func loadCoachData(userId: Int) async {
        await fetchRecommendation(userId: userId)
        await fetchWeeklyPlan(userId: userId)
    }

    func fetchRecommendation(userId: Int) async {
        isLoadingRecommendation = true
        do {
            let result = try await CoachService.shared.fetchDailyRecommendation(for: userId)
            self.recommendation = result
        } catch {
            self.errorMessage = "Öneri verisi alınamadı: \(error.localizedDescription)"
        }
        isLoadingRecommendation = false
    }

    func fetchWeeklyPlan(userId: Int) async {
        isLoadingWeeklyPlan = true
        do {
            let result = try await CoachService.shared.fetchWeeklyMealPlan(for: userId)
            self.weeklyPlan = result
        } catch {
            self.errorMessage = "Haftalık plan alınamadı: \(error.localizedDescription)"
        }
        isLoadingWeeklyPlan = false
    }
}
