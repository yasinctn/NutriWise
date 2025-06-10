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
    let predictedInfo: NutritionInfo
    let onAdd: () -> Void
    let onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Bu bir \(foodName) mı?")
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)

            Stepper("Miktar: \(quantity)", value: $quantity, in: 1...10)

            HStack(spacing: 24) {
                nutritionItem(title: "Kalori", value: "\(predictedInfo.calories ?? 0) kcal")
                nutritionItem(title: "Protein", value: "\(predictedInfo.protein ?? 0.0) g")
            }

            HStack(spacing: 24) {
                nutritionItem(title: "Karbonhidrat", value: "\(predictedInfo.carbs ?? 0.0) g")
                nutritionItem(title: "Yağ", value: "\(predictedInfo.fat ?? 0.0) g")
            }

            Spacer()

            Button(action: {
                onAdd()
                onDismiss()
            }) {
                Text("Ekle")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.bottom)
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
