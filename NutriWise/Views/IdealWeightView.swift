//
//  IdealWeightView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 4.06.2025.
//

import SwiftUI

struct IdealWeightView: View {

    @EnvironmentObject var userVM: UserProfileViewModel
    
    
    @State private var speed = 1.0

    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Burada \(userVM.goal.lowercased()) için varsınız!")
                .font(.headline)
                .padding()

            Text("İdeal Kilonuz Nedir?")
            
            AnimatedTextField(placeholder: "kg", text: $userVM.targetWeight, keyboardType: .numberPad)
            

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
            .disabled(userVM.targetWeight.isEmpty)
        }
        
        .padding()
    }
}
#Preview {
    IdealWeightView()
}
