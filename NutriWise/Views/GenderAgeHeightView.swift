//
//  GenderAgeHeightView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 4.06.2025.
//

import SwiftUI

struct GenderAgeHeightView: View {
    var name: String

    @State private var gender = ""
    @State private var age = ""
    @State private var height = ""
    @State private var weight = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Cinsiyetiniz nedir?")
                .font(.headline)

            HStack {
                GenderButton(label: "Erkek", selected: $gender)
                GenderButton(label: "Kadın", selected: $gender)
                GenderButton(label: "Non-binary", selected: $gender)
            }
            Text("Kaç yaşındasınız?")
            AnimatedTextField(
                text: $age,
                keyboardType: .numberPad
            )
            Text("Boyunuz nedir?")
            AnimatedTextField(
                placeholder: "cm",
                text: $height,
                keyboardType: .numberPad
            )
            Text("Şu anki kilonuz?")
            AnimatedTextField(
                placeholder: "kg",
                text:$weight,
                keyboardType: .numberPad
            )
            Spacer()

            NavigationLink("İleri") {
                GoalSelectionView(name: name, gender: gender, age: age, height: height)
            }
            .disabled(gender.isEmpty || age.isEmpty || height.isEmpty)
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
    GenderAgeHeightView(name: "Yasin")
}
