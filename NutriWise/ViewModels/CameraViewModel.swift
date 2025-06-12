//
//  CameraViewModel.swift
//  NutriWise
//
//  Created by Yasin Cetin on 8.06.2025.
//

import Foundation
import AVFoundation
import CoreML
import SwiftUI
import UIKit

class CameraViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    var userId: Int?
    var mealType: String?

    private var isConfigured = false
    
    @Published var isSendingToBackend = false
    @Published var showAlertMessage = false
    @Published var capturedImage: UIImage?
    @Published var predictedLabel: String?
    @Published var isLoadingNutrition = false
    @Published var nutritionInfo: NutritionInfo?
    @Published var showNutritionPopup = false
    @Published var confirmedFoodName: String = ""
    @Published var quantity: Int = 1
    @Published var errorMessage: String?


    let session = AVCaptureSession()
    private let output = AVCapturePhotoOutput()
    private let queue = DispatchQueue(label: "camera.queue")

    func configure() {
        queue.async {
            guard !self.isConfigured else { return } // tekrar configure etme
            self.session.beginConfiguration()
            defer {
                self.session.commitConfiguration()
                self.session.startRunning()
                self.isConfigured = true // ✅ tamamlandığında işaretle
            }
            
            guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
                  let input = try? AVCaptureDeviceInput(device: device),
                  self.session.canAddInput(input),
                  self.session.canAddOutput(self.output) else { return }
            
            self.session.addInput(input)
            self.session.addOutput(self.output)
        }
    }
    func closeCamera() {
        queue.async {
            if self.session.isRunning {
                self.session.stopRunning()
            }
            self.isConfigured = false
        }
    }

    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: self)
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let data = photo.fileDataRepresentation(),
           let image = UIImage(data: data) {
            DispatchQueue.main.async {
                self.capturedImage = image
                self.predict(image: image)
            }
        }
    }

    private func predict(image: UIImage) {
        do {
            let model = try FoodClassifier(configuration: MLModelConfiguration())
            guard let inputDesc = model.model.modelDescription.inputDescriptionsByName["image"],
                  let imageConstraint = inputDesc.imageConstraint,
                  let resizedBuffer = image.pixelBuffer(width: imageConstraint.pixelsWide, height: imageConstraint.pixelsHigh) else {
                self.errorMessage = "Model giriş formatı hatalı."
                return
            }

            let prediction = try model.prediction(image: resizedBuffer)
            let label = prediction.target

            DispatchQueue.main.async {
                self.predictedLabel = label
                self.confirmedFoodName = label
                self.showNutritionPopup = true
                //self.fetchNutritionInfo(userId: self.userId ?? 1, mealType: self.mealType ?? "", foodName: label, quantity: self.quantity)
            }

        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Tahmin hatası: \(error.localizedDescription)"
            }
        }
    }

    func fetchNutritionInfo(userId: Int, mealType: String, foodName: String, quantity: Int) {
        isLoadingNutrition = true
        errorMessage = nil

        MealService.shared.recognizeMeal(
            userId: userId,
            mealType: mealType,
            foodName: foodName,
            quantity: quantity
        ) { result in
            DispatchQueue.main.async {
                self.isLoadingNutrition = false
                switch result {
                case .success(let info):
                    self.nutritionInfo = info
                case .failure:
                    self.nutritionInfo = nil
                }
            }
        }
    }

    func sendToBackend(userId: Int, mealType: String) {
        isSendingToBackend = true
        errorMessage = nil
        print("Ekleme gönderiliyor: \(confirmedFoodName), miktar: \(quantity)")

        MealService.shared.recognizeMeal(
            userId: userId,
            mealType: mealType,
            foodName: confirmedFoodName,
            quantity: quantity
        ) { result in
            DispatchQueue.main.async {
                self.isSendingToBackend = false
                switch result {
                case .success:
                    self.showNutritionPopup = false
                    self.showAlertMessage = true
                case .failure(let error):
                    self.errorMessage = "Sunucu hatası: \(error.localizedDescription)"
                }
            }
        }
    }
}

