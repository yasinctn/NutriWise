//
//  SearchFoodView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 9.06.2025.
//

import SwiftUI

struct SearchFoodView: View {
    var mealType: String
    var userId: Int

    @EnvironmentObject var mealVM: MealViewModel
    @State private var query: String = ""
    @State private var searchResults: [Food] = []
    @State private var isLoading = false

    var body: some View {
        VStack {
            TextField("Yiyecek ara...", text: $query)
                .padding(12)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)

            if isLoading {
                ProgressView()
                    .padding()
            } else {
                List(searchResults) { food in
                    HStack {
                        Text(food.name ?? "Yiyecek")
                        Spacer()
                        Text("\(food.calories ?? 0) kcal")
                        Button {
                            // ekleme işlemi
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .onChange(of: query) { newValue in
            Task {
                await searchFood(query: newValue)
            }
        }
        .onAppear {
            Task {
                await searchFood(query: query) // ilk yüklemede tüm yiyecekleri göster
            }
        }
    }

    func searchFood(query: String) async {
        isLoading = true

        let allLabels = mealVM.getAllFoodLabels()

        let filtered: [String]
        if query.isEmpty {
            filtered = allLabels // tümünü göster
        } else {
            filtered = allLabels.filter { $0.localizedCaseInsensitiveContains(query) }
        }

        searchResults = filtered.map {
            Food(name: $0, calories: 100, protein: 95, fat: 95, carbs: 28, quantity: 1)
        }

        isLoading = false
    }
}
