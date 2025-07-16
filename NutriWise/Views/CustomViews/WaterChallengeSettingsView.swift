//
//  WaterChallengeSettingsView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 12.06.2025.
//

import SwiftUI

struct WaterChallengeSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var newGoal: Int
    let onConfirm: (Int) -> Void

    init(goal: Int, onConfirm: @escaping (Int) -> Void) {
        self._newGoal = State(initialValue: goal)
        self.onConfirm = onConfirm
    }

    var body: some View {
        VStack(spacing: 24) {
            Text("Meydan Okumalar")
                .font(.title2.bold())

            VStack {
                Text("Günlük hedef")
                    .font(.headline)

                Text("\(Double(newGoal) * 0.25, specifier: "%.2f") L")
                    .font(.title.bold())

                Text("\(newGoal) Bardak")
                    .font(.title2)
                    .foregroundColor(.secondary)
            }

            Slider(value: Binding(
                get: { Double(newGoal) },
                set: { newGoal = Int($0) }
            ), in: 1...12, step: 1)

            HStack {
                Button("İptal") {
                    dismiss()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                .cornerRadius(12)

                Button("Onayla") {
                    onConfirm(newGoal)
                    dismiss()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
        }
        .padding()
    }
}

