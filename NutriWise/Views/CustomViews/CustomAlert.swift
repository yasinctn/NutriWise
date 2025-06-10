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
            //Color.black.opacity(0.3).ignoresSafeArea()

            VStack(spacing: 16) {
                Text(title)
                    .font(.headline)

                Text(message)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.primary)

                Button(confirmTitle) {
                    onConfirm()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.secondary)
                .cornerRadius(10)
            }
            .padding()
            .frame(maxWidth: 300)
            .background(Color.secondary)
            .cornerRadius(16)
            .shadow(radius: 10)
        }
    }
}

