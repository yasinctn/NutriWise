//
//  CustomAlert.swift
//  NutriWise
//
//  Created by Yasin Cetin on 8.06.2025.
//

import SwiftUI

struct CustomAlert: View {
    var title: String
    var message: String
    var confirmTitle: String
    var onConfirm: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.4) // Arka plan overlay
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(message)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)

                Button(confirmTitle) {
                    onConfirm()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            .frame(maxWidth: 300)
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.2), radius: 10)
            .padding(.horizontal)
        }
    }
}


