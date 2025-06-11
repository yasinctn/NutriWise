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
    @StateObject private var mealVM = MealViewModel()
    @StateObject private var cameraVM = CameraViewModel()
    @StateObject private var coachVM = CoachViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(cameraVM)
                .environmentObject(mealVM)
                .environmentObject(userVM)
                .environmentObject(coachVM)
        }
    }
}
