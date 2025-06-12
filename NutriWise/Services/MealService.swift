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

    func fetchCalorieDifference(userId: Int) async throws -> Int {
        let url = "\(baseURL)/api/Recommendation/\(userId)"
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url)
                .validate()
                .responseDecodable(of: CalorieRecommendationResponse.self) { response in
                    switch response.result {
                    case .success(let data):
                        continuation.resume(returning: data.calorieDifference ?? 0)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }

    
    func fetchMeals(userId: Int, date: Date) async throws -> DailyMealResponse {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)

        guard let encodedDate = dateString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            throw URLError(.badURL)
        }

        let urlString = "\(baseURL)/api/Meal/daily/\(userId)/\(encodedDate)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url)
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let decoded = try JSONDecoder().decode(DailyMealResponse.self, from: data)
                            continuation.resume(returning: decoded)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }

    func recognizeMeal(userId: Int, mealType: String, foodName: String, quantity: Int, completion: @escaping (Result<NutritionInfo, Error>) -> Void) {
        let url = "\(baseURL)/api/Meal/recognize"

        let request = RecognizeMealRequest(
            userId: userId,
            mealType: mealType,
            foodName: foodName,
            quantity: quantity
        )

        print("📤 Gönderilen veri: \(request)")

        AF.request(url, method: .post, parameters: request, encoder: JSONParameterEncoder.default)
            .validate()
            .responseDecodable(of: NutritionInfo.self) { response in
                switch response.result {
                case .success(let data):
                    print("✅ Decode edilen veri: \(data)")
                    completion(.success(data))
                case .failure(let error):
                    print("❌ API Hatası: \(error.localizedDescription)")
                    if let data = response.data {
                        
                        print("📨 Yanıt verisi: \(String(data: data, encoding: .utf8) ?? "decode edilemedi")")
                    }
                    completion(.failure(error))
                }
            }
    }

}
