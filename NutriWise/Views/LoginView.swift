//
//  LoginView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 5.06.2025.
//
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userVM: UserProfileViewModel
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @State private var isPasswordHidden: Bool = true
    @State private var isLoading = false
    @State private var showingErrorAlert = false

    var body: some View {
        VStack(spacing: 16) {
            Spacer()

            // E-posta Alanı
            AnimatedTextField(
                placeholder: "E-posta",
                text: $userVM.email,
                keyboardType: .emailAddress
            )

            // Şifre Alanı
            ZStack(alignment: .trailing) {
                AnimatedTextField(
                    placeholder: "Şifre",
                    text: $userVM.password,
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

            // Şifremi unuttum
            Button("Şifrenizi mi unuttunuz?") {
                // navigasyon yapılabilir
            }
            .font(.subheadline)
            .underline()
            .foregroundColor(.black)
            .padding(.top, 8)

            Spacer()

            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                    .scaleEffect(1.5)
            } else {
                Button("Sonraki") {
                    isLoading = true
                    userVM.loginUser() { success in
                        isLoading = false
                        if success {
                            isLoggedIn = true
                        } else {
                            showingErrorAlert = true
                        }
                    }
                }
                .disabled(userVM.email.isEmpty || userVM.password.isEmpty)
                .fontWeight(.semibold)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    (userVM.email.isEmpty || userVM.password.isEmpty)
                    ? Color(red: 210/255, green: 218/255, blue: 228/255)
                    : Color(.systemIndigo)
                )
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding()

            }
        }
        .padding()
        .alert("Giriş başarısız", isPresented: $showingErrorAlert) {
            Button("Tamam", role: .cancel) { }
        } message: {
            Text("E-posta ya da şifre hatalı. Lütfen tekrar deneyin.")
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(UserProfileViewModel())
}
