//
//  OnboardingEntryView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 4.06.2025.
//


import SwiftUI

struct OnboardingEntryView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("NutriWise")
                    .font(.largeTitle.bold())
                Text("Motivasyonlarınız ne olursa olsun, beslenme rehberiniz")
                    .multilineTextAlignment(.center)
                    .padding()

                Spacer()
                NavigationLink {
                    NameInputView()
                } label: {
                    Text("Başla")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.systemIndigo))
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding()
                

                
                NavigationLink {
                    AuthGatewayView(purpose: .login)
                } label: {
                    Text("Zaten bir hesabınız var mı? Giriş yap")
                        .foregroundStyle(.black)
                        .underline()
                }
                .padding(.bottom)
            }
            .padding()
            

        }
    }
}

#Preview {
    OnboardingEntryView()
}
