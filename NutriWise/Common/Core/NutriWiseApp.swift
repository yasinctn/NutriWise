//
//  NutriWiseApp.swift
//  NutriWise
//
//  Created by Yasin Cetin on 4.06.2025.
//

import SwiftUI

@main
struct NutriWiseApp: App {
    
    @StateObject private var userVM = UserProfileViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(userVM)
        }
    }
}
