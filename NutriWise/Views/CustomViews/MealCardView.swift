//
//  MealCardView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 8.06.2025.
//

import SwiftUI

struct MealCardView: View {
    
    let selectedDate: Date
    let title: String
    let meals: [Food]
    var totalMealCalories: Int

    @State private var navigateToCapture: Bool = false
    @State private var dateWarningMessage: String = ""
    @State private var showDateWarningAlert: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Label {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                } icon: {
                    Image(systemName: emojiIcon(for: title))
                        .foregroundColor(.accentColor)
                }

                Spacer()

                Text("\(totalMealCalories) kcal")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Button(action: {
                    if Calendar.current.isDateInToday(selectedDate) {
                        navigateToCapture = true
                    } else if selectedDate < Calendar.current.startOfDay(for: Date()) {
                        dateWarningMessage = "Geçmiş bir güne öğün ekleyemezsiniz."
                        showDateWarningAlert = true
                    } else {
                        dateWarningMessage = "Gelecekteki bir güne öğün ekleyemezsiniz."
                        showDateWarningAlert = true
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                        .foregroundColor(.green)
                        .scaleEffect(1.1)
                        .shadow(radius: 1)
                }
                .buttonStyle(PlainButtonStyle())

                NavigationLink(destination: MealCaptureScreen(mealType: title), isActive: $navigateToCapture) {
                    EmptyView()
                }
                .hidden()
            }

            Divider()

            if meals.isEmpty {
                Text("Henüz öğün eklenmedi")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 4)
            } else {
                VStack(spacing: 8) {
                    ForEach(meals) { food in
                        HStack {
                            Text(food.name ?? "Bilinmiyor")
                                .font(.body)
                                .foregroundColor(.primary)
                            Spacer()
                            Text("\(String(format: "%.2f", Double(food.calories ?? 0))) kcal")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 2)
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.separator), lineWidth: 0.5)
        )
        .shadow(color: Color.black.opacity(0.07), radius: 6, x: 0, y: 3)
        .alert(isPresented: $showDateWarningAlert) {
            Alert(
                title: Text("Uyarı"),
                message: Text(dateWarningMessage),
                dismissButton: .default(Text("Tamam"))
            )
        }
    }

    func emojiIcon(for meal: String) -> String {
        switch meal {
        case "Kahvaltı": return "sunrise"
        case "Öğle Yemeği": return "sun.max"
        case "Akşam Yemeği": return "fork.knife"
        case "Atıştırmalık": return "takeoutbag.and.cup.and.straw"
        default: return "leaf"
        }
    }
}
