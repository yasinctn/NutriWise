//
//  GoalSelectionView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 4.06.2025.
//

import SwiftUI

struct GoalSelectionView: View {
    @EnvironmentObject var userVM: UserProfileViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Merhaba \(userVM.name)!")
                .font(.title)
            Text("Burada ne yapıyorsunuz?")

            
            GoalButton(goal: "Kilo vermek")
           
            
            GoalButton(goal: "Kas kazanmak ve yağ kaybetmek")
            
            GoalButton(goal: "Kas kazanmak, yağ kaybetmek ikinci planda")
            
            GoalButton(goal: "Kilo vermeden daha sağlıklı beslenmek")
            
          
            Spacer()
        }
        .padding()
    }
}

#Preview {
    GoalSelectionView()
}


// MARK: - Goal Button

struct GoalButton: View {
    @EnvironmentObject var userVM: UserProfileViewModel
    var goal: String

    var body: some View {
        NavigationLink(destination: IdealWeightView()) {
            HStack {
                Text(goal)
                    .fontWeight(.medium)
                    .padding(8)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(red: 246/255, green: 248/255, blue: 252/255))
            .foregroundColor(Color.black)
            .cornerRadius(12)
        }
        .simultaneousGesture(TapGesture().onEnded {
            userVM.goal = goal // 💡 Navigation öncesi hedef kaydı
        })
    }
}


