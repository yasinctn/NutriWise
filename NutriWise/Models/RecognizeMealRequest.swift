//
//  RecognizeMealRequest.swift
//  NutriWise
//
//  Created by Yasin Cetin on 8.06.2025.
//

import Foundation

struct RecognizeMealRequest: Codable {
    let userId: Int
    let mealType: String
    let foodName: String
    let quantity: Int
}
