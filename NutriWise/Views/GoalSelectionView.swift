//
//  GoalSelectionView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 4.06.2025.
//

import SwiftUI

struct GoalSelectionView: View {
    var name: String
    var gender: String
    var age: String
    var height: String

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Merhaba \(name)!")
                .font(.title)
            Text("Burada ne yapıyorsunuz?")

            
            GoalButton(label: "Kilo vermek") {
                IdealWeightView(goal: "Kilo vermek")
            }
           
            
            GoalButton(label: "Kas kazanmak ve yağ kaybetmek") {
                IdealWeightView(goal: "Kas kazanmak ve yağ kaybetmek")
            }
            
            GoalButton(label: "Kas kazanmak, yağ kaybetmek ikinci planda") {
                IdealWeightView(goal: "Kas kazanmak, yağ kaybetmek ikinci planda")
            }
            
            GoalButton(label: "Kilo vermeden daha sağlıklı beslenmek") {
                IdealWeightView(goal: "Kilo vermeden daha sağlıklı beslenmek")
            }
            
          
            Spacer()
        }
        .padding()
    }
}

#Preview {
    GoalSelectionView(name: "", gender: "", age: "", height: "")
}


// MARK: - Goal Button

struct GoalButton<Destination: View>: View {
    var label: String
    let destination: () -> Destination

    var body: some View {
        NavigationLink(destination: destination()) {
            HStack {
                Text(label)
                    .fontWeight(.medium)
                    .padding(8)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(red: 246/255, green: 248/255, blue: 252/255))
            .foregroundColor(Color.black)
            .cornerRadius(12)
            Spacer()
        }
    }
}
