//
//  NutritionBottomSheet.swift
//  NutriWise
//
//  Created by Yasin Cetin on 8.06.2025.
//

import SwiftUI

struct NutritionBottomSheet: View {
    let foodName: String
    @Binding var quantity: Int
    let predictedInfo: NutritionInfo?
    let isLoading: Bool
    let onAdd: () -> Void
    let onDismiss: () -> Void
    @Binding var isSending: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("Bu bir \(foodName) mı?")
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)

            Stepper("Miktar: \(quantity)", value: $quantity, in: 1...10)

            if isLoading {
                ProgressView("Besin bilgileri yükleniyor...")
            } else if let info = predictedInfo {
                HStack(spacing: 24) {
                    nutritionItem(title: "🔥 Kalori", value: "\(info.calories) kcal")
                    nutritionItem(title: "⚡️ Protein", value: "\(info.protein) g")
                }

                HStack(spacing: 24) {
                    nutritionItem(title: "🍞 Karbonhidrat", value: "\(info.carbs) g")
                    nutritionItem(title: "💧 Yağ", value: "\(info.fat) g")
                }
            } else {
                Text("❗Besin bilgisi bulunamadı.")
                    .foregroundColor(.red)
                    .font(.caption)
            }

            Spacer()

            if isSending {
                ProgressView()
            } else {
                Button("Ekle") {
                    onAdd()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }

            Button("İptal", role: .cancel) {
                onDismiss()
                print("Ekleye basıldı")
            }
            .foregroundColor(.gray)
        }
        .padding()
    }

    private func nutritionItem(title: String, value: String) -> some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(value)
                .font(.headline)
                .foregroundColor(.primary)
        }
    }
}
