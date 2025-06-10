//
//  MealService.swift
//  NutriWise
//
//  Created by Yasin Cetin on 8.06.2025.
//

import Foundation
import Alamofire

class MealService {
    static let shared = MealService()
    private let baseURL = "https://nutrionapp.up.railway.app"

    
    func fetchMeals(userId: Int, date: Date) async throws -> DailyMealResponse {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
        let dateString = formatter.string(from: date)

        guard let encodedDate = dateString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            throw URLError(.badURL)
        }

        let urlString = "\(baseURL)/api/Meal/daily/\(userId)/\(encodedDate)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let response = try await AF.request(url)
            .validate()
            .serializingDecodable(DailyMealResponse.self)
            .value

        return response
    }


    func recognizeMeal(userId: Int, mealType: String, foodName: String, quantity: Int, completion: @escaping (Result<NutritionInfo, Error>) -> Void) {
        let url = "\(baseURL)/api/Meal/recognize"

        let request = RecognizeMealRequest(
            userId: userId,
            mealType: mealType,
            foodName: foodName,
            quantity: quantity
        )

        AF.request(url, method: .post, parameters: request, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: NutritionInfo.self) { response in
                debugPrint(response)

                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    print("🔥 Recognition API error:", error.localizedDescription)

                    if let data = response.data {
                        print("Gelen veri:", String(data: data, encoding: .utf8) ?? "decode edilemedi")
                    }

                    completion(.failure(error))
                }
            }

    }

}
