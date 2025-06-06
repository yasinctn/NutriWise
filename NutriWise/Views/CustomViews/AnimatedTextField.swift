//
//  AnimatedTextField.swift
//  NutriWise
//
//  Created by Yasin Cetin on 5.06.2025.
//

import SwiftUI

struct AnimatedTextField: View {
    var placeholder: String = ""
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var isSecure: Bool = false

    var backgroundColor: Color {
        text.isEmpty ?
            Color(red: 246/255, green: 248/255, blue: 252/255) :
            Color(red: 250/255, green: 237/255, blue: 215/255)
    }

    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .padding()
                    .background(
                        backgroundColor
                            .animation(.easeInOut(duration: 0.3), value: text)
                    )
                    .cornerRadius(18)
                    .keyboardType(keyboardType)
            } else {
                TextField(placeholder, text: $text)
                    .padding()
                    .background(
                        backgroundColor
                            .animation(.easeInOut(duration: 0.3), value: text)
                    )
                    .cornerRadius(18)
                    .keyboardType(keyboardType)
            }
        }
    }
}



