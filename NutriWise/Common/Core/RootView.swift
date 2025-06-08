//
//  RootView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 4.06.2025.
//

import SwiftUI

struct RootView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false

    var body: some View {
        Group {
            if isLoggedIn {
                MainTabView()
            } else {
                OnboardingEntryView()
            }
        }
    }
}



#Preview {
    RootView()
}
