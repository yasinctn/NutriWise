//
//  RecognizeResponse.swift
//  NutriWise
//
//  Created by Yasin Cetin on 10.06.2025.
//

import Foundation

struct RecognizeResponse: Decodable {
    let message: String
    let food: NutritionInfo
}
