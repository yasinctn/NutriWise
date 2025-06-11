//
//  WeeklyMealPlanView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 11.06.2025.
//

import SwiftUI

struct WeeklyMealPlanView: View {
    let weeklyPlan: WeeklyMealPlan

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Weekly Meal Planner")
                    .font(.title2).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                Text("Meal Plan for the Day")
                    .font(.headline)
                    .padding(.horizontal)

                ForEach(sortedGroupedMeals.keys.sorted(), id: \.self) { day in
                    VStack(alignment: .leading, spacing: 16) {
                        Text(formattedDate(from: day))
                            .font(.title3)
                            .bold()
                            .padding(.horizontal)

                        ForEach(sortedGroupedMeals[day] ?? [], id: \.mealType) { meal in
                            MealCard(meal: meal)
                                .padding(.horizontal)
                        }
                    }
                }
            }
        }
    }

    private var sortedGroupedMeals: [String: [PlannedMeal]] {
        Dictionary(grouping: weeklyPlan.plannedMeals, by: { String($0.day.prefix(10)) })
    }

    private func formattedDate(from iso: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: iso) {
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }
        return iso
    }
}

struct MealCard: View {
    let meal: PlannedMeal

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(mealTypeText(meal.mealType))
                .font(.headline)
                .padding(.bottom, 5)

            // Görsel temsil (şimdilik sistem simgesiyle)
            Image(systemName: "photo.on.rectangle")
                .resizable()
                .scaledToFill()
                .frame(height: 150)
                .cornerRadius(10)
                .clipped()

            ForEach(meal.foods, id: \.name) { food in
                VStack(alignment: .leading, spacing: 4) {
                    Text(food.name)
                        .font(.subheadline).bold()

                    HStack(spacing: 16) {
                        foodStat(icon: "flame.fill", value: "\(Int(food.calories)) cal")
                        foodStat(icon: "circle.fill", value: "\(Int(food.protein))g", color: .blue)
                        foodStat(icon: "bag.fill", value: "\(Int(food.carbs))g", color: .orange)
                        foodStat(icon: "drop.fill", value: "\(Int(food.fat))g", color: .red)
                    }
                    .font(.caption)
                }
            }
        }
        .padding()
        .background(Color(.systemPink).opacity(0.1))
        .cornerRadius(12)
    }

    private func foodStat(icon: String, value: String, color: Color = .primary) -> some View {
        Label {
            Text(value)
        } icon: {
            Image(systemName: icon)
                .foregroundColor(color)
        }
    }

    private func mealTypeText(_ type: Int) -> String {
        switch type {
        case 0: return "Kahvaltı"
        case 1: return "Öğle Yemeği"
        case 2: return "Akşam Yemeği"
        case 3: return "Atıştırmalık"
        default: return "Unknown"
        }
    }
}
