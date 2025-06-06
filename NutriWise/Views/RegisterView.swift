//
//  RegisterView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 6.06.2025.
//

import SwiftUI

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordHidden: Bool = true
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

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

            

            Spacer()

            // Sonraki butonu
            Button(action: {
                performRegistration(email: email, password: password)
            }) {
                Text("Hesabımı Oluştur")
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
    
    func performRegistration(email: String, password: String) {
            // giriş işlemi yapılacak
        }
    
}

#Preview {
    RegisterView()
}
