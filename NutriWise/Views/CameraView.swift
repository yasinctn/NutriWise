//
//  CameraView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 8.06.2025.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    
    var mealType: String
    var userId: Int
    
    @StateObject private var cameraVM = CameraViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            CameraPreview(session: cameraVM.session)
                .ignoresSafeArea()
                .overlay {
                    Rectangle()
                        .stroke(Color.green, lineWidth: 3)
                        .frame(width: 360, height: 360)
                }

            VStack {
                Spacer()
                Button(action: {
                    cameraVM.capturePhoto()
                }) {
                    Circle()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: 70, height: 70)
                        .overlay(Circle().stroke(Color.black, lineWidth: 2))
                        .shadow(radius: 3)
                }
                .padding(.bottom, 30)
            }

            if cameraVM.isLoadingNutrition {
                LoadingView()
            }

            if let error = cameraVM.errorMessage {
                CustomAlert(
                    title: "Hata",
                    message: error,
                    confirmTitle: "Tamam",
                    onConfirm: {
                        cameraVM.errorMessage = nil
                    }
                )
            }
        }.sheet(isPresented: $cameraVM.showNutritionPopup) {
            if let info = cameraVM.nutritionInfo {
                NutritionBottomSheet(
                    foodName: cameraVM.predictedLabel ?? "Bilinmeyen",
                    quantity: $cameraVM.quantity,
                    predictedInfo: info,
                    onAdd: {
                        cameraVM.sendToBackend(userId: userId, mealType: mealType)
                    },
                    onDismiss: {
                        cameraVM.showNutritionPopup = false
                    },
                    isSending: $cameraVM.isSendingToBackend
                )
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
            }
        }
        .alert("Kayıt başarıyla eklendi", isPresented: $cameraVM.showSuccessToast) {
            Button("Tamam") {
                dismiss()
            }
        }
        .onAppear {
            cameraVM.userId = userId
            cameraVM.mealType = mealType
            cameraVM.configure()
        }
        .onDisappear { cameraVM.closeCamera() }
        .navigationBarBackButtonHidden(false)
    }
}




// MARK: - Camera
struct CameraPreview: UIViewRepresentable {
    
    let session: AVCaptureSession
    
    class VideoPreviewView: UIView {
        override class var layerClass: AnyClass {
            AVCaptureVideoPreviewLayer.self
        }
        
        var videoPreviewLayer: AVCaptureVideoPreviewLayer {
            return layer as! AVCaptureVideoPreviewLayer
        }
    }
    
    func makeUIView(context: Context) -> VideoPreviewView {
        let view = VideoPreviewView()
        view.videoPreviewLayer.session = session
        view.videoPreviewLayer.videoGravity = .resizeAspectFill
        return view
    }
    
    func updateUIView(_ uiView: VideoPreviewView, context: Context) {}
}
