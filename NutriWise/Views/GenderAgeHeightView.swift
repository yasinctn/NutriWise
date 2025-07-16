//
//  GenderAgeHeightView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 4.06.2025.
//

import SwiftUI

struct GenderAgeHeightView: View {
    
    @EnvironmentObject var userVM: UserProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Cinsiyetiniz nedir?")
                .font(.headline)

            HStack {
                GenderButton(label: "Erkek", selected: $userVM.gender)
                GenderButton(label: "Kadın", selected: $userVM.gender)
                GenderButton(label: "Non-binary", selected: $userVM.gender)
            }
            Text("Kaç yaşındasınız?")
            AnimatedTextField(
                text: $userVM.age,
                keyboardType: .numberPad
            )
            Text("Boyunuz nedir?")
            AnimatedTextField(
                placeholder: "cm",
                text: $userVM.height,
                keyboardType: .numberPad
            )
            Text("Şu anki kilonuz?")
            AnimatedTextField(
                placeholder: "kg",
                text:$userVM.weight,
                keyboardType: .numberPad
            )
            Spacer()

            NavigationLink("İleri") {
                GoalSelectionView()
            }
            Spacer()
            .disabled(userVM.gender.isEmpty || userVM.age.isEmpty || userVM.height.isEmpty)
            .padding()
        }
        .padding()
        
    }
}

// MARK: - GenderButtonView

struct GenderButton: View {
    var label: String
    @Binding var selected: String

    var body: some View {
        Button(action: {
            selected = label
        }) {
            Text(label)
                .padding()
                .frame(maxWidth: .infinity)
                .foregroundStyle(selected==label ? .black : .gray)
                .background(selected == label ? Color.orange.opacity(0.4) : Color.gray.opacity(0.2))
                .cornerRadius(10)
        }
    }
}
#Preview{
    GenderAgeHeightView()
}
