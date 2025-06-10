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
    
    let session = AVCaptureSession()
    private let output = AVCapturePhotoOutput()
    private let queue = DispatchQueue(label: "camera.queue")
    
    @Published var capturedImage: UIImage?
    @Published var predictedLabel: String?
    @Published var isLoadingNutrition = false
    @Published var nutritionInfo: NutritionInfo?
    @Published var showNutritionPopup = false
    @Published var confirmedFoodName: String = ""
    @Published var quantity: Int = 1
    @Published var errorMessage: String?
    
    
    
    func configure() {
        queue.async {
            self.session.beginConfiguration()
            guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
                  let input = try? AVCaptureDeviceInput(device: device),
                  self.session.canAddInput(input),
                  self.session.canAddOutput(self.output) else { return }
            self.session.addInput(input)
            self.session.addOutput(self.output)
            self.session.commitConfiguration()
            self.session.startRunning()
        }
    }
    
    func closeCamera() {
        session.stopRunning()
    }
    
    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: self)
    }
    
    func resetState() {
        self.capturedImage = nil
        self.predictedLabel = nil
        self.nutritionInfo = nil
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
                self.errorMessage = "Model giriş formatına uygun değil."
                return
            }
            
            let prediction = try model.prediction(image: resizedBuffer)
            
            DispatchQueue.main.async {
                // prediction.target yerine classLabel kullan
                let label = prediction.target
                self.predictedLabel = label
                self.confirmedFoodName = label
                self.sendToBackend(userId: self.userId ?? 1, mealType: self.mealType ?? "öğün")
            }
            
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = "Tahmin hatası: \(error.localizedDescription)"
            }
        }
    }
    
    
    func sendToBackend(userId: Int, mealType: String) {
        isLoadingNutrition = true
        errorMessage = nil
        
        MealService.shared.recognizeMeal(
            userId: userId,
            mealType: mealType,
            foodName: confirmedFoodName,
            quantity: quantity
        ) { result in
            DispatchQueue.main.async {
                self.isLoadingNutrition = false
                switch result {
                case .success(let info):
                    print(info)
                    self.nutritionInfo = info
                    self.showNutritionPopup = true
                case .failure(let error):
                    self.errorMessage = "Sunucu hatası: \(error.localizedDescription)"
                }
            }
        }
    }
    
    
}



