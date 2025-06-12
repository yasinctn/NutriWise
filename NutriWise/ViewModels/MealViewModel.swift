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
    
    @Published var totalGoal: Int = 2750
    
    @Published var meals: [Meal] = []
    @Published var totalProteinToday: Double = 0
    @Published var totalCarbsToday: Double = 0
    @Published var totalFatToday: Double = 0
    @Published var totalCaloriesForSelectedDate: Int = 0
    @Published var selectedDate: Date = Date()
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    @AppStorage("userId") var userId: Int = 5
    
    func getFoods(for type: String) -> [Food] {
        meals.first(where: {
            let normalizedType = $0.mealType?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
            return normalizedType.contains(type.lowercased())
        })?.foods ?? []
    }
    
    func getMealCalories(for mealType: String) -> Int {
        meals.first(where: {
            let normalizedType = $0.mealType?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() ?? ""
            return normalizedType.contains(mealType.lowercased())
        })?.totalMealCalories ?? 0
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
            totalCaloriesForSelectedDate = response.totalCalories ?? 0
            totalProteinToday = response.totalProtein ?? 0
            totalCarbsToday = response.totalCarbs ?? 0
            totalFatToday = response.totalFat ?? 0

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
    
    

    func fetchTotalGoalFromServer() async {
        do {
            let difference = try await MealService.shared.fetchCalorieDifference(userId: userId)
            // örnek olarak: hedef 2750, fark -500 ise tüketilen = 2250 => totalGoal = 2750
            // ancak doğrudan ihtiyaç duyulan hedef bu farkla güncellenebilir
            totalGoal = max(totalCaloriesForSelectedDate + abs(difference), 0)
        } catch {
            print("❌ Calorie difference çekilemedi: \(error.localizedDescription)")
        }
    }

}
