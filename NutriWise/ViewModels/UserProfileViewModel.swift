//
//  UserProfileViewModel.swift
//  NutriWise
//
//  Created by Yasin Cetin on 7.06.2025.
//

import Foundation
import SwiftUI
import Alamofire

class UserProfileViewModel: ObservableObject {
    // MARK: - Profil Bilgileri
    @Published var name = ""
    @Published var gender = ""
    @Published var age = ""
    @Published var height = ""
    @Published var weight = ""
    @Published var goal = ""
    @Published var targetWeight = ""
    //@Published var speed = 1.0 // Eğer backend'den gelmiyorsa kaldırılabilir

    @Published var calorieDifference: Int?

    // MARK: - Auth Bilgileri
    @Published var email = ""
    @Published var password = ""

    @AppStorage("userId") var userId: Int = 0

    // MARK: - Ağırlık Geçmişi
    @Published var weightHistory: [WeightEntry] = []

    // MARK: - Computed Properties
    var weightDouble: Double {
        Double(weight) ?? 0
    }

    var targetWeightDouble: Double {
        Double(targetWeight) ?? 0
    }

    var startingWeight: Double {
        weightHistory.last?.weight ?? 0
    }

    
    

    func addWeightEntry(weight: Double, completion: @escaping (Bool) -> Void) {
        guard userId > 0 else {
            completion(false)
            return
        }

        let url = "https://nutrionapp.up.railway.app/api/WeightTracking/update-weight"
        let parameters: [String: Any] = [
            "userId": userId,
            "newWeight": weight
        ]

        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .response { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success:
                        print("✅ Güncel ağırlık başarıyla gönderildi")
                        self.fetchWeightHistory()
                        completion(true)
                    case .failure(let error):
                        print("❌ Güncel ağırlık gönderme hatası:", error.localizedDescription)
                        completion(false)
                    }
                }
            }
    }
    
    func fetchUserBasicInfo() {
        let url = "https://nutrionapp.up.railway.app/api/User/all"

        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            if let error = error {
                print("⚠️ Kullanıcı listesi alınamadı:", error)
                return
            }

            guard let data = data else {
                print("⚠️ Veri boş")
                return
            }

            do {
                let allUsers = try JSONDecoder().decode([UserBasic].self, from: data)
                if let currentUser = allUsers.first(where: { $0.id == self.userId }) {
                    DispatchQueue.main.async {
                        self.name = currentUser.name
                        self.email = currentUser.email
                    }
                }
            } catch {
                print("❌ Decode hatası (UserBasic):", error)
            }
        }.resume()
    }


    // MARK: - Profil Bilgisi Getir
    func fetchUserProfile() {
        guard userId > 0 else { return }

        let urlString = "https://nutrionapp.up.railway.app/api/User/\(userId)/profile"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("⚠️ Profil verisi alınamadı:", error)
                return
            }

            guard let data = data else {
                print("⚠️ Veri boş")
                return
            }

            do {
                let profile = try JSONDecoder().decode(UserProfile.self, from: data)
                DispatchQueue.main.async {
                    self.updateViewModel(with: profile)
                }
            } catch {
                print("❌ Decode hatası:", error)
            }
        }.resume()
    }

    private func updateViewModel(with profile: UserProfile) {
        self.height = String(profile.height)
        self.weight = String(profile.weight)
        self.age = String(profile.age)
        self.gender = profile.gender
        self.targetWeight = String(profile.targetWeight)
        self.calorieDifference = profile.calorieDifference
        // hedef gün, adım sayısı vs. varsa burada devam edebilirsin
    }

    // MARK: - Ağırlık Geçmişi Getir
    func fetchWeightHistory() {
        guard userId > 0 else { return }

        let urlString = "https://nutrionapp.up.railway.app/api/WeightTracking/weight-history/\(userId)"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept") // ✅ JSON beklediğimizi belirtelim

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("⚠️ Ağırlık geçmişi alınamadı: \(error.localizedDescription)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("⚠️ Geçersiz yanıt nesnesi")
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                if let data = data, let message = String(data: data, encoding: .utf8) {
                    print("❗️ API Hata Yanıtı: \(message)")
                } else {
                    print("❗️ HTTP Hatası: \(httpResponse.statusCode)")
                }
                return
            }

            guard let data = data else {
                print("⚠️ Veri boş")
                return
            }

            // JSON'u logla
            if let rawJSON = String(data: data, encoding: .utf8) {
                print("📦 Gelen JSON:\n\(rawJSON)")
            }

            do {
                let history = try decoder.decode([WeightEntry].self, from: data)
                DispatchQueue.main.async {
                    self.weightHistory = history
                }
            } catch {
                print("❌ Decode hatası (WeightHistory):", error)
            }
        }.resume()
    }


    // MARK: - Kayıt
    func registerUser(completion: @escaping (Bool) -> Void) {
        guard let ageInt = Int(age),
              let heightInt = Int(height),
              let weightInt = Int(weight) else {
            completion(false)
            return
        }

        let request = RegisterRequest(
            name: name,
            email: email,
            password: password,
            height: heightInt,
            weight: weightInt,
            age: ageInt,
            gender: gender
        )

        AuthService.shared.register(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    completion(true)
                case .failure(let error):
                    print("Register error: \(error.localizedDescription)")
                    completion(false)
                }
            }
        }
    }

    // MARK: - Giriş
    func loginUser(completion: @escaping (Bool) -> Void) {
        let request = LoginRequest(email: email, password: password)

        AuthService.shared.login(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let id):
                    self.userId = id
                    completion(true)
                case .failure(let error):
                    print("Login failed: \(error.localizedDescription)")
                    completion(false)
                }
            }
        }
    }
}
