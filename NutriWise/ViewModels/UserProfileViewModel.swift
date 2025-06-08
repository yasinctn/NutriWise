//
//  UserProfileViewModel.swift
//  NutriWise
//
//  Created by Yasin Cetin on 7.06.2025.
//

import Foundation

class UserProfileViewModel: ObservableObject {
    @Published var name = ""
    @Published var gender = ""
    @Published var age = ""
    @Published var height = ""
    @Published var weight = ""
    @Published var goal = ""
    @Published var targetWeight = ""
    @Published var speed = 1.0

    @Published var email = ""
    @Published var password = ""

    // MARK: - Register
    func registerUser(completion: @escaping (Bool) -> Void) {
        guard let ageInt = Int(age),
              let heightInt = Int(height),
              let weightInt = Int(weight) else {
            completion(false)
            return
        }

        self.email = email
        self.password = password

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

    // MARK: - Login
    func loginUser(completion: @escaping (Bool) -> Void) {

        let request = LoginRequest(email: email, password: password)

        AuthService.shared.login(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    completion(true)
                case .failure(let error):
                    print("Login failed: \(error.localizedDescription)")
                    completion(false)
                }
            }
        }
    }
}
