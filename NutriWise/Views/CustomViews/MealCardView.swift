//
//  MealCardView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 8.06.2025.
//

import SwiftUI

struct MealCardView: View {
    let title: String
    let meals: [Food] // Güncel tip
    let goal: Int

    var totalCalories: Int {
        meals.map(\.calories!).reduce(0, +)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label(title, systemImage: emojiIcon(for: title))
                    .font(.headline)

                Spacer()

                Text("\(totalCalories) / \(goal) kcal")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                NavigationLink(destination: MealCaptureScreen(mealType: title)) {
                    Image(systemName: "plus.circle.fill")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }

            if meals.isEmpty {
                Text("Henüz öğün eklenmedi")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 4)
            } else {
                ForEach(meals) { food in
                    HStack {
                        Text(food.name ?? "boş")
                            .font(.body)
                        Spacer()
                        Text("\(food.calories) kcal")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }

    func emojiIcon(for meal: String) -> String {
        switch meal {
        case "Kahvaltı": return "face.smiling"
        case "Öğle yemeği": return "fork.knife"
        case "Akşam yemeği": return "takeoutbag.and.cup.and.straw"
        case "Atıştırmalık": return "cup.and.saucer"
        default: return "leaf"
        }
    }
}
