//
//  NameInputView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 4.06.2025.
//

import SwiftUI

struct NameInputView: View {
    
    @State private var name = ""
    
    
    var body: some View {
        VStack {
            Spacer()
            Text("Hoş geldiniz")
                .font(.title)
            Text("Önce tanışalım 😊\nAdınız nedir?")
                .multilineTextAlignment(.center)
                .padding()
            
            AnimatedTextField(placeholder: "Ad", text: $name)
            
            Spacer()
            
            NavigationLink("İleri") {
                GenderAgeHeightView(name: name)
            }
            .disabled(name.isEmpty)
            .padding()
        }
        .padding()
    }
}

#Preview {
    NameInputView()
}
