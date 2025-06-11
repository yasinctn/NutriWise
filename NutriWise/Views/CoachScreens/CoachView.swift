//
//  CoachView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 11.06.2025.
//

import SwiftUI

struct CoachView: View {
    @EnvironmentObject private var coachVM: CoachViewModel
    @AppStorage("userId") private var userId: Int = 0

    var body: some View {
        TabView {
            Group {
                if coachVM.isLoadingRecommendation {
                    ProgressView("Günlük öneriler yükleniyor...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let recommendation = coachVM.recommendation {
                    DailyRecommendationView(recommendation: recommendation)
                } else if let error = coachVM.errorMessage {
                    ErrorView(title: "Günlük Öneri Hatası", message: error)
                } else {
                    WaitingView(message: "Günlük öneri hazırlanıyor")
                }
            }
            .tabItem {
                Label("Günlük", systemImage: "bolt.heart.fill")
            }

            Group {
                if coachVM.isLoadingWeeklyPlan {
                    ProgressView("Haftalık plan yükleniyor...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let weeklyPlan = coachVM.weeklyPlan {
                    WeeklyMealPlanView(weeklyPlan: weeklyPlan)
                } else if let error = coachVM.errorMessage {
                    ErrorView(title: "Haftalık Plan Hatası", message: error)
                } else {
                    WaitingView(message: "Haftalık plan hazırlanıyor")
                }
            }
            .tabItem {
                Label("Haftalık Plan", systemImage: "calendar")
            }

        }
        .onAppear {
            Task {
                await coachVM.loadCoachData(userId: userId)
            }
        }
    }
}



struct ErrorView: View {
    let title: String
    let message: String

    var body: some View {
        VStack {
            Text("❌ \(title)")
                .font(.title2)
            Text(message)
                .font(.caption)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct WaitingView: View {
    let message: String

    var body: some View {
        VStack {
            ProgressView()
            Text(message)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

