    //
    //  DashboardView.swift
    //  NutriWise
    //
    //  Created by Yasin Cetin on 7.06.2025.
    //

    import SwiftUI

    struct DashboardView: View {
        
        @EnvironmentObject var mealVM: MealViewModel

        
        let totalGoal = 2750

        var remainingCalories: Int {
            max(mealVM.totalGoal - mealVM.totalCaloriesForSelectedDate, 0)
        }

        private let dateFormatter: DateFormatter = {
            let df = DateFormatter()
            df.dateStyle = .medium
            df.locale = Locale(identifier: "tr_TR")
            return df
        }()
        
        var body: some View {
            NavigationStack {
                ZStack {
                    VStack(spacing: 20) {
                        calorieRingView
                        dateSelector
                        
                        ScrollView {
                            VStack(spacing: 16) {
                                MealCardView(selectedDate: mealVM.selectedDate, title: "Kahvaltı", meals: mealVM.getFoods(for: "Kahvaltı"), totalMealCalories: mealVM.getMealCalories(for: "Kahvaltı"))
                                MealCardView(selectedDate: mealVM.selectedDate, title: "Öğle Yemeği", meals: mealVM.getFoods(for: "Öğle"), totalMealCalories: mealVM.getMealCalories(for: "Öğle Yemeği"))
                                MealCardView(selectedDate: mealVM.selectedDate, title: "Akşam Yemeği", meals: mealVM.getFoods(for: "Akşam"), totalMealCalories: mealVM.getMealCalories(for: "Akşam Yemeği"))
                                MealCardView(selectedDate: mealVM.selectedDate, title: "Atıştırmalık", meals: mealVM.getFoods(for: "Atıştırmalık"), totalMealCalories: mealVM.getMealCalories(for: "Atıştırmalık"))
                            }
                            .padding(.horizontal)
                        }
                        Spacer()
                    }
                    .padding(.top)
                    .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
                    .navigationTitle("Günlük")
                    .navigationBarHidden(true)
                    .task {
                        await mealVM.fetchMealsForSelectedDate()
                    }

                    if mealVM.isLoading {
                        LoadingView()
                    }

                    if let errorMessage = mealVM.errorMessage {
                        CustomAlert(
                            title: "Hata",
                            message: errorMessage,
                            confirmTitle: "Tamam",
                            onConfirm: {
                                mealVM.errorMessage = nil
                            }
                        )
                    }
                }
            }
            .task {
                await mealVM.fetchMealsForSelectedDate()
                await mealVM.fetchTotalGoalFromServer()
            }
            .onChange(of: mealVM.selectedDate) {
                Task {
                    await mealVM.fetchMealsForSelectedDate()
                    await mealVM.fetchTotalGoalFromServer()
                }
            }

        }

        var calorieRingView: some View {
            VStack(spacing: 12) {
                Text("🔥 \(mealVM.totalCaloriesForSelectedDate) Tüketilen")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 16)

                    Circle()
                        .trim(from: 0, to: min(Double(mealVM.totalCaloriesForSelectedDate) / Double(totalGoal), 1.0))
                        .stroke(Color.green, style: StrokeStyle(lineWidth: 16, lineCap: .round))
                        .rotationEffect(.degrees(-90))

                    VStack {
                        Text("\(remainingCalories)")
                            .font(.largeTitle)
                            .bold()
                        Text("kcal kalan")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(width: 160, height: 160)

                HStack(spacing: 20) {
                    macroItem(iconName: "drop.fill", label: "Yağlar", value: mealVM.totalFatToday)
                    macroItem(iconName: "bolt.fill", label: "Proteinler", value: mealVM.totalProteinToday)
                    macroItem(iconName: "takeoutbag.and.cup.and.straw.fill", label: "Karbonhidrat", value: mealVM.totalCarbsToday)
                }

                .font(.caption)
                .foregroundColor(.secondary)
            }
        }

        var dateSelector: some View {
            HStack {
                Button {
                    mealVM.goToPreviousDay()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .padding(.horizontal, 8)
                }

                Spacer()

                Text(dateFormatter.string(from: mealVM.selectedDate))
                    .font(.headline)

                Spacer()

                Button {
                    mealVM.goToNextDay()
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title3)
                        .padding(.horizontal, 8)
                }
            }
            .padding(.horizontal)
            .foregroundColor(.primary)
        }

        func macroItem(iconName: String, label: String, value: Double) -> some View {
            VStack(spacing: 4) {
                Image(systemName: iconName)
                    .foregroundStyle(Color.yellow)
                    
                Text(label)
                    .foregroundStyle(.primary)
                Text("\(String(format: "%.1f", value))g")
                    .foregroundStyle(Color.yellow)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }

    }
