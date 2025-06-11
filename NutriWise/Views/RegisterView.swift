//
//  RegisterView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 6.06.2025.
//

import SwiftUI

struct RegisterView: View {
    @State private var isPasswordHidden: Bool = true

    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showStartButton = false

    @EnvironmentObject var userVM: UserProfileViewModel
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

    var body: some View {
        ZStack {
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

                Spacer()

                // Hesap Oluştur Butonu
                Button(action: {
                    isLoading = true
                    userVM.registerUser() { success in
                        if success {
                            alertTitle = "Kayıt Başarılı"
                            alertMessage = "Kaydınız başarıyla oluşturuldu."
                            showStartButton = true
                        } else {
                            alertTitle = "Hata"
                            alertMessage = "Kayıt oluşturulamadı. Lütfen tekrar deneyin."
                            showStartButton = false
                        }
                        isLoading = false
                        showAlert = true
                    }
                }) {
                    Text("Hesabımı Oluştur")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            (userVM.email.isEmpty || userVM.password.isEmpty)
                            ? Color(red: 210/255, green: 218/255, blue: 228/255)
                            : Color(.systemIndigo)
                        )
                        .clipShape(Capsule())
                        .padding()
                }
                .disabled(userVM.email.isEmpty || userVM.password.isEmpty)
            }
            .padding()

            // Loading ekranı
            if isLoading {
                LoadingView()
                    .transition(.opacity)
            }

            // Alert gösterimi
            if showAlert {
                CustomAlert(
                    title: alertTitle,
                    message: alertMessage,
                    confirmTitle: showStartButton ? "Başla" : "Tamam"
                ) {
                    showAlert = false
                    if showStartButton {
                        isLoading = true
                        userVM.loginUser() { loggedIn in
                            isLoading = false
                            if loggedIn {
                                isLoggedIn = true
                            }
                        }
                    }
                }
                .transition(.scale)
            }
        }
        .animation(.easeInOut, value: isLoading || showAlert)
    }
}


#Preview {
    RegisterView()
        .environmentObject(UserProfileViewModel())
}
