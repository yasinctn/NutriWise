//
//  MealCaptureScreen.swift
//  NutriWise
//
//  Created by Yasin Cetin on 8.06.2025.
//

import SwiftUI

struct MealCaptureScreen: View {
    var mealType: String
    @AppStorage("userId") var userId: Int = 0
    @State private var selectedTab: CaptureTab = .search

    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Custom Segmented Picker
            VStack(spacing: 12) {
                Text("Öğün Ekleme Yöntemi")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 8)

                Picker("Seçim", selection: $selectedTab) {
                    ForEach(CaptureTab.allCases, id: \.self) { tab in
                        Text(tab.title)
                            .tag(tab)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
            }
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.secondarySystemBackground))
                    .padding(.horizontal)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
            )
            .padding(.vertical, 12)

            // MARK: - Tab Content
            switch selectedTab {
            case .search:
                SearchFoodView(mealType: mealType, userId: userId)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemBackground))
                    .transition(.opacity)
            case .camera:
                CameraView(mealType: mealType, userId: userId)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemBackground))
                    .transition(.opacity)
            case .myFoods:
                MyFoodsView(mealType: mealType)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemBackground))
                    .transition(.opacity)// Bu parametre eksikse ekleyebilirsin
            }
            
        }
        .navigationTitle(mealType)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
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



