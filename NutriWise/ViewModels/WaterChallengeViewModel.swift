//
//  WaterChallengeViewModel.swift
//  NutriWise
//
//  Created by Yasin Cetin on 12.06.2025.
//
import Foundation
import SwiftUI

class WaterChallengeViewModel: ObservableObject {
    @AppStorage("dailyWaterIntake") private var storedIntake: Int = 0
    @AppStorage("dailyWaterGoal") private var storedGoal: Int = 8
    @AppStorage("lastUpdatedDate") private var lastUpdated: String = ""

    @Published var intake: Int = 0
    @Published var goal: Int = 8

    init() {
        checkDateReset()
        intake = storedIntake
        goal = storedGoal
    }

    func increment(to index: Int) {
        intake = index + 1
        store()
    }

    func updateGoal(to newGoal: Int) {
        goal = newGoal
        storedGoal = newGoal
        if intake > goal { intake = goal }
        store()
    }

    private func store() {
        storedIntake = intake
        storedGoal = goal
        lastUpdated = todayString()
    }

    private func checkDateReset() {
        if lastUpdated != todayString() {
            intake = 0
            storedIntake = 0
            lastUpdated = todayString()
        }
    }

    private func todayString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }

    var totalLiters: Double {
        Double(intake) * 0.25
    }

    var goalLiters: Double {
        Double(goal) * 0.25
    }
}

