//
//  MainTabView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 8.06.2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Ana Sayfa", systemImage: "house")
                }
            
            DailyRecommendationView()
                .tabItem {
                    Label("Koç", systemImage: "figure.walk.circle")
                }
            
            WeeklyMealPlanView()
                .tabItem {
                    Label("Plan", systemImage: "list.clipboard")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profil", systemImage: "person.crop.circle")
                }
        }
    }
}


#Preview {
    MainTabView()
}
