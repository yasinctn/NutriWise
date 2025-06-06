//
//  IdealWeightView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 4.06.2025.
//

import SwiftUI

struct IdealWeightView: View {
    
    var goal: String

    @State private var targetWeight = ""
    @State private var speed = 1.0

    var animatedBackground: Color {
        targetWeight.isEmpty ?
            Color(red: 246/255, green: 248/255, blue: 252/255) : // Boşken gri
            Color(red: 250/255, green: 237/255, blue: 215/255)   // Doluysa sarımsı
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Burada \(goal.lowercased()) için varsınız!")
                .font(.headline)
                .padding()

            Text("İdeal Kilonuz Nedir?")
            
            AnimatedTextField(placeholder: "kg", text: $targetWeight, keyboardType: .numberPad)
            

            Text("Hedefinize hangi hızda ulaşmak istiyorsunuz?")
                .font(.subheadline)

            Slider(value: $speed, in: 1...3, step: 1) {
                Text("Speed")
            }

            HStack {
                Text("Yavaş ama emin")
                Spacer()
                Text("Yarı yolda")
                Spacer()
                Text("Mümkün olan\nen kısa sürede")
            }
            .font(.caption)

            Spacer()

            NavigationLink("Sonraki") {
                AuthGatewayView(purpose: .signup)
            }
            .disabled(targetWeight.isEmpty)
        }
        
        .padding()
    }
}
#Preview {
    IdealWeightView(goal: "")
}
