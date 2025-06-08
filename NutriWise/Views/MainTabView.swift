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

            //AddMealView()
            //.tabItem {
            //    Label("Öğün Ekle", systemImage: "plus.circle")
            //}

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
