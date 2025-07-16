//
//  UserProfile.swift
//  NutriWise
//
//  Created by Yasin Cetin on 12.06.2025.
//

import Foundation

struct UserProfile: Codable {
    let id: Int
    let userId: Int
    let height: Int
    let weight: Int
    let age: Int
    let gender: String
    let targetWeight: Int
    let targetDays: Int
    let calorieDifference: Int?
}
