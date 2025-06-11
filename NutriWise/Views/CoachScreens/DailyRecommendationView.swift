//
//  DailyRecommendationView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 11.06.2025.
//

import SwiftUI

struct DailyRecommendationView: View {
    let recommendation: DailyRecommendation

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Uyarı mesajı
                VStack(alignment: .center, spacing: 10) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.red)
                    Text(recommendation.alertMessage)
                        .font(.headline)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)

                // Kalori ve öneri tipi
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Label("Kalori Farkı", systemImage: "flame")
                            .foregroundColor(.orange)
                        Spacer()
                        Text("\(recommendation.calorieDifference) kcal")
                            .bold()
                    }

                    HStack {
                        Label("Öneri Tipi", systemImage: "lightbulb.fill")
                            .foregroundColor(.blue)
                        Spacer()
                        Text(recommendation.recommendationType)
                            .bold()
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)

                // Önerilen yiyecekler
                VStack(alignment: .leading, spacing: 10) {
                    Text("🍽️ Önerilen Yiyecekler")
                        .font(.title3)
                        .bold()

                    ForEach(recommendation.recommendedFoods, id: \.name) { food in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(food.name)
                                .font(.headline)

                            HStack(spacing: 16) {
                                foodStat(icon: "flame.fill", value: "\(food.calories) cal")
                                foodStat(icon: "circle.fill", value: "\(Int(food.protein))g", color: .blue)
                                foodStat(icon: "bag.fill", value: "\(Int(food.carbs))g", color: .orange)
                                foodStat(icon: "drop.fill", value: "\(Int(food.fat))g", color: .red)
                            }
                            .font(.caption)
                        }
                        .padding()
                        .background(Color(.systemPink).opacity(0.1))
                        .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .navigationTitle("Günlük Öneri")
    }

    private func foodStat(icon: String, value: String, color: Color = .primary) -> some View {
        Label {
            Text(value)
        } icon: {
            Image(systemName: icon)
                .foregroundColor(color)
        }
    }
}
