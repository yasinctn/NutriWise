//
//  MealViewModel.swift
//  NutriWise
//
//  Created by Yasin Cetin on 8.06.2025.
//

import SwiftUI
import CoreML

@MainActor
class MealViewModel: ObservableObject {
    
    @Published var meals: [Meal] = []
    @Published var totalCaloriesForSelectedDate: Int = 0
    @Published var selectedDate: Date = Date()
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    let userId = 1 // İleride @AppStorage("userId") ile değiştirilecek

    func meals(for type: String) -> [Food] {
        meals.first(where: {
            let normalizedType = $0.mealType?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
            return normalizedType.contains(type.lowercased())
        })?.foods ?? []
    }


    
    func getAllFoodLabels() -> [String] {
        do {
            let model = try FoodClassifier(configuration: MLModelConfiguration())
            if let labels = model.model.modelDescription.classLabels as? [String] {
                return labels
            } else {
                print("🚫 Etiketler alınamadı.")
            }
        } catch {
            print("❌ Model yükleme hatası: \(error.localizedDescription)")
        }
        return []
    }
    
    
    @MainActor
    func fetchMealsForSelectedDate() async {
        isLoading = true
        errorMessage = nil

        do {
            let response = try await MealService.shared.fetchMeals(userId: userId, date: selectedDate)
            meals = response.meals ?? []
            totalCaloriesForSelectedDate = response.totalCaloriesToday ?? 0
        } catch {
            errorMessage = "Veriler alınırken bir hata oluştu: \(error.localizedDescription)"
        }

        isLoading = false
    }


    func goToNextDay() {
        selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
        Task { await fetchMealsForSelectedDate() }
    }

    func goToPreviousDay() {
        selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) ?? selectedDate
        Task { await fetchMealsForSelectedDate() }
    }
}
