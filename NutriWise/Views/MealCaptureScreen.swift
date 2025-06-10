//
//  MealCaptureScreen.swift
//  NutriWise
//
//  Created by Yasin Cetin on 8.06.2025.
//

import SwiftUI

struct MealCaptureScreen: View {
    var mealType: String
    var userId: Int = 1
    
    @State private var selectedTab: CaptureTab = .search
    
    var body: some View {
        VStack(spacing: 0) {
            Picker("Seçim", selection: $selectedTab) {
                ForEach(CaptureTab.allCases, id: \.self) { tab in
                    Text(tab.title).tag(tab)
                }
            }
            .pickerStyle(.segmented)
            .padding()

            Divider()

            switch selectedTab {
            case .search:
                SearchFoodView(mealType: mealType, userId: userId)
            case .camera:
                CameraView(mealType: mealType, userId: userId)
            case .myFoods:
                MyFoodsView(mealType: mealType) // örnek boş bir view
            }
        }
        .navigationTitle(mealType)
        .navigationBarTitleDisplayMode(.inline)
    }
}

enum CaptureTab: CaseIterable {
    case search, camera, myFoods
    
    var title: String {
        switch self {
        case .search: return "Ara"
        case .camera: return "Fotoğraf"
        case .myFoods: return "Yemeklerim"
        }
    }
}


