//
//  WeeklyMealPlanView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 11.06.2025.
//

import SwiftUI

struct WeeklyMealPlanView: View {
    
    @EnvironmentObject private var coachVM: CoachViewModel
    @AppStorage("userId") var userId: Int = 0
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Haftalık Öğün Planı")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
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
            .padding(.vertical)
        }
        .onAppear {
            Task {
                await coachVM.loadCoachData(userId: userId)
            }
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
    
    private var sortedGroupedMeals: [String: [PlannedMeal]] {
        Dictionary(grouping: coachVM.weeklyPlan?.plannedMeals ?? [], by: { String($0.day.prefix(10)) })
    }
    
    private func formattedDate(from iso: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: iso) {
            formatter.dateStyle = .medium
            formatter.locale = Locale(identifier: "tr_TR")
            return formatter.string(from: date)
        }
        return iso
    }
}

struct MealCard: View {
    let meal: PlannedMeal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(mealTypeText(meal.mealType))
                .font(.headline)
                .foregroundColor(.accentColor)
            
            Image(mealImageName(meal.mealType))
                .resizable()
                .scaledToFill()
                .frame(height: 150)
                .cornerRadius(10)
                .clipped()
            
            ForEach(meal.foods, id: \.name) { food in
                VStack(alignment: .leading, spacing: 4) {
                    Text(food.name)
                        .font(.subheadline.bold())
                        .foregroundColor(.primary)
                    
                    HStack(spacing: 12) {
                        foodStat(icon: "flame.fill", value: "\(Int(food.calories)) cal", color: .pink)
                        foodStat(icon: "circle.grid.cross.fill", value: "\(Int(food.protein))g", color: .blue)
                        foodStat(icon: "bag.fill", value: "\(Int(food.carbs))g", color: .orange)
                        foodStat(icon: "drop.fill", value: "\(Int(food.fat))g", color: .red)
                    }
                    .font(.caption)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.secondarySystemBackground)))
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    private func foodStat(icon: String, value: String, color: Color) -> some View {
        Label {
            Text(value)
        } icon: {
            Image(systemName: icon)
                .foregroundColor(color)
        }
        .foregroundColor(.primary)
    }
    
    private func mealTypeText(_ type: Int) -> String {
        switch type {
        case 0: return "Kahvaltı"
        case 1: return "Öğle Yemeği"
        case 2: return "Akşam Yemeği"
        case 3: return "Atıştırmalık"
        default: return "Bilinmeyen"
        }
    }
    
    private func mealImageName(_ type: Int) -> String {
        switch type {
        case 0: return "kahvaltı"
        case 1: return "ogle"
        case 2: return "akşam"
        case 3: return "atıştırma"
        default: return "Bilinmeyen"
        }
    }
}


private func foodStat(icon: String, value: String, color: Color) -> some View {
    Label {
        Text(value)
    } icon: {
        Image(systemName: icon)
            .foregroundColor(color)
    }
    .foregroundColor(.primary)
}

private func mealTypeText(_ type: Int) -> String {
    switch type {
    case 0: return "kahvaltı"
    case 1: return "ogle"
    case 2: return "akşam"
    case 3: return "atıştırma"
    default: return "Bilinmeyen"
    }
}


