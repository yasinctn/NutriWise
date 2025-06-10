//
//  AuthService.swift
//  NutriWise
//
//  Created by Yasin Cetin on 7.06.2025.
//
import Foundation
import Alamofire

class AuthService {
    static let shared = AuthService()
    
    private let baseURL = "https://nutrionapp.up.railway.app"

    // MARK: - Register
    func register(request: RegisterRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = "\(baseURL)/api/user/register"
        
        AF.request(url, method: .post, parameters: request, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success:
                    print("Register successful with status code: \(response.response?.statusCode ?? 0)")
                    completion(.success(()))
                case .failure(let error):
                    print("Register failed: \(error)")
                    completion(.failure(error))
                }
            }
    }

    // MARK: - Login
    func login(request: LoginRequest, completion: @escaping (Result<Int, Error>) -> Void) {
        let url = "\(baseURL)/api/user/login"

        AF.request(url, method: .post, parameters: request, encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: LoginResponse.self) { response in
                switch response.result {
                case .success(let loginResponse):
                    print("Giriş başarılı. Kullanıcı ID: \(loginResponse.userId)")
                    completion(.success(loginResponse.userId))
                case .failure(let error):
                    print("Giriş başarısız: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
    }


}
