//
//  RegisterRequest.swift
//  NutriWise
//
//  Created by Yasin Cetin on 7.06.2025.
//

import Foundation

struct RegisterRequest: Codable {
    let name: String
    let email: String
    let password: String
    let height: Int
    let weight: Int
    let age: Int
    let gender: String
}
