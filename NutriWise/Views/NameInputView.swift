//
//  NameInputView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 4.06.2025.
//

import SwiftUI

struct NameInputView: View {
    @EnvironmentObject var userVM: UserProfileViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Text("Hoş geldiniz")
                .font(.title)
            Text("Önce tanışalım 😊\nAdınız nedir?")
                .multilineTextAlignment(.center)
                .padding()
            
            AnimatedTextField(placeholder: "Ad", text: $userVM.name)
            
            Spacer()
            
            NavigationLink("İleri") {
                GenderAgeHeightView()
            }
            .disabled(userVM.name.isEmpty)
            .padding()
        }
        .padding()
    }
}

#Preview {
    NameInputView()
}
