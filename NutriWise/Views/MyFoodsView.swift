//
//  MyFoodsView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 9.06.2025.
//
import SwiftUI

struct MyFoodsView: View {
    @EnvironmentObject var mealVM: MealViewModel
    @State private var searchText = ""
    @State private var selectedDate = Date()

    var body: some View {
        VStack {
            
            TextField("Yemek ara...", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            
            if mealVM.totalCaloriesForSelectedDate > 0 {
                VStack(spacing: 6) {
                    Text("Toplam Günlük Değerler")
                        .font(.headline)

                    HStack(spacing: 12) {
                        summaryItem(title: "Kalori", value: "\(mealVM.totalCaloriesForSelectedDate) kcal", color: .red)
                        summaryItem(title: "Protein", value: "\(Int(mealVM.totalProteinToday)) g", color: .blue)
                        summaryItem(title: "Karbonhidrat", value: "\(Int(mealVM.totalCarbsToday)) g", color: .orange)
                        summaryItem(title: "Yağ", value: "\(Int(mealVM.totalFatToday)) g", color: .purple)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
            }

            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if mealVM.meals.isEmpty {
                        Text("Bugün için kayıtlı öğün bulunamadı.")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ForEach(mealVM.meals, id: \.mealType) { meal in
                            let filteredFoods = (meal.foods ?? []).filter { food in
                                searchText.isEmpty || (food.name?.lowercased().contains(searchText.lowercased()) ?? false)
                            }

                            if !filteredFoods.isEmpty {
                                Section(header: Text(meal.mealType ?? "Öğün")
                                            .font(.headline)
                                            .padding(.horizontal)) {
                                    ForEach(filteredFoods, id: \.self) { food in
                                        foodCard(food)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.top)
            }
        }
        .navigationTitle("Yediklerim")
        .onAppear {
            mealVM.selectedDate = selectedDate
            Task { await mealVM.fetchMealsForSelectedDate() }
        }
    }

    
    private func foodCard(_ food: Food) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(food.name ?? "Bilinmeyen")
                .font(.headline)

            HStack(spacing: 16) {
                foodStat(icon: "flame.fill", value: "\(Int(food.calories ?? 0)) cal")
                foodStat(icon: "circle.fill", value: "\(Int(food.protein ?? 0))g", color: .blue)
                foodStat(icon: "bag.fill", value: "\(Int(food.carbs ?? 0))g", color: .orange)
                foodStat(icon: "drop.fill", value: "\(Int(food.fat ?? 0))g", color: .red)
            }
            .font(.caption)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }

    // 🔢 Toplamlar için Kutu
    private func summaryItem(title: String, value: String, color: Color) -> some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.subheadline).bold()
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity)
    }

    // 🍎 Makro Stat
    private func foodStat(icon: String, value: String, color: Color = .primary) -> some View {
        Label {
            Text(value)
        } icon: {
            Image(systemName: icon)
                .foregroundColor(color)
        }
    }
}
