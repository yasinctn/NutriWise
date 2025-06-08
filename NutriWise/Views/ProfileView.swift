//
//  ProfileView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 8.06.2025.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                
                Button(action: {
                    isLoggedIn = false
                }) {
                    Text("Çıkış Yap")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 24)

                Spacer()
            }
            .padding()
            .navigationTitle("Profil")
        }
    }
}

#Preview {
    ProfileView()
}
