//
//  DailyRecommendationView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 11.06.2025.
//

import SwiftUI


struct DailyRecommendationView: View {
    @EnvironmentObject private var coachVM: CoachViewModel
    @AppStorage("userId") var userId: Int = 0

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                if let alert = coachVM.recommendation?.alertMessage, !alert.isEmpty {
                    AlertMessageView(message: alert)
                }

                if let recommendation = coachVM.recommendation {
                    InfoBoxView(
                        calorieDifference: recommendation.calorieDifference,
                        recommendationType: recommendation.recommendationType
                    )

                    if !recommendation.recommendedFoods.isEmpty {
                        FoodRecommendationList(foods: recommendation.recommendedFoods)
                    } else {
                        ActivityRecommendationList(activities: recommendation.recommendedActivities)
                    }
                }
            }
            .padding(.top)
        }
        .onAppear {
            Task {
                await coachVM.loadCoachData(userId: userId)
            }
        }
        .navigationTitle("Günlük Öneri")
    }
}


struct AlertMessageView: View {
    let message: String

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.red)
            Text(message)
                .font(.headline)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.red.opacity(0.1))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct ActivityRecommendationList: View {
    let activities: [RecommendedActivity]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("🔥 Önerilen Aktiviteler")
                .font(.title3)
                .bold()
                .padding(.horizontal)

            ForEach(activities, id: \.name) { activity in
                ActivityCardView(activity: activity)
            }
        }
    }
}

struct ActivityCardView: View {
    let activity: RecommendedActivity

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(activity.name)
                .font(.headline)
            HStack {
                Image(systemName: "flame.fill")
                    .foregroundColor(.orange)
                Text("\(activity.caloriesBurned) kalori")
            }
            .font(.subheadline)
        }
        .padding()
        .background(Color.orange.opacity(0.1))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct InfoBoxView: View {
    let calorieDifference: Int
    let recommendationType: String

    var body: some View {
        VStack(spacing: 12) {
            infoRow(label: "Kalori Farkı", value: "\(-calorieDifference) kcal", icon: "flame", color: .orange)
            infoRow(label: "Öneri Tipi", value: recommendationType, icon: "lightbulb.fill", color: .blue)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }

    private func infoRow(label: String, value: String, icon: String, color: Color) -> some View {
        HStack {
            Label(label, systemImage: icon)
                .foregroundColor(color)
            Spacer()
            Text(value).bold()
        }
    }
}

struct FoodRecommendationList: View {
    let foods: [RecommendedFood]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("🍽️ Önerilen Yiyecekler")
                .font(.title3)
                .bold()
                .padding(.horizontal)

            ForEach(foods, id: \.name) { food in
                FoodCardView(food: food)
            }
        }
    }
}

struct FoodCardView: View {
    let food: RecommendedFood

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(food.name)
                .font(.headline)

            HStack(spacing: 16) {
                foodStat(icon: "flame.fill", value: "\(food.calories) cal")
                foodStat(icon: "circle.fill", value: "\(Int(food.protein))g", color: .blue)
                foodStat(icon: "bag.fill", value: "\(Int(food.carbs))g", color: .orange)
                foodStat(icon: "drop.fill", value: "\(Int(food.fat))g", color: .red)
            }
            .font(.caption)
        }
        .padding()
        .background(Color(.systemPink).opacity(0.1))
        .cornerRadius(12)
        .padding(.horizontal)
    }

    private func foodStat(icon: String, value: String, color: Color = .primary) -> some View {
        Label {
            Text(value)
        } icon: {
            Image(systemName: icon)
                .foregroundColor(color)
        }
    }
}
