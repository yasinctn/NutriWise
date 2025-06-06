//
//  LoginView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 5.06.2025.
//
import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordHidden: Bool = true

    var body: some View {
        VStack(spacing: 16) {
            Spacer()

            // E-posta Alanı
            AnimatedTextField(
                placeholder: "E-posta",
                text: $email,
                keyboardType: .emailAddress
            )

            // Şifre Alanı (özel toggle’lı)
            ZStack(alignment: .trailing) {
                AnimatedTextField(
                    placeholder: "Şifre",
                    text: $password,
                    keyboardType: .default,
                    isSecure: isPasswordHidden
                )

                Button(action: {
                    isPasswordHidden.toggle()
                }) {
                    Image(systemName: isPasswordHidden ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                        .padding(.trailing, 12)
                }
            }

            // Şifrenizi mi unuttunuz?
            Button(action: {
                // Şifre sıfırlama ekranı
            }) {
                Text("Şifrenizi mi unuttunuz?")
                    .font(.subheadline)
                    .underline()
                    .foregroundColor(.black)
            }
            .padding(.top, 8)

            Spacer()

            // Sonraki butonu
            Button(action: {
                // Giriş işlemi
            }) {
                Text("Sonraki")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 210/255, green: 218/255, blue: 228/255))
                    .cornerRadius(23)
            }
            .disabled(email.isEmpty || password.isEmpty)
        }
        .padding()
        
    }
}

#Preview {
    LoginView()
}
