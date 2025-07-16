//
//  AddWeightView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 12.06.2025.
//

import SwiftUI

struct AddWeightView: View {
    
    @EnvironmentObject private var userProfileVM: UserProfileViewModel
    
    @Environment(\.dismiss) private var dismiss
    @State private var weightText = ""
    @State private var selectedDate = Date()

    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .foregroundColor(.blue)
                }
                Spacer()
                Text("Bir tartım ekle")
                    .font(.headline)
                Spacer()
                // Boş buton görünümü simetri için
                Image(systemName: "xmark")
                    .font(.title3)
                    .opacity(0)
            }


            HStack(spacing: 16) {
                Image(systemName: "scalemass.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.blue.opacity(0.7))

                TextField("ex: 65", text: $weightText)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.4)))

                Menu {
                    Text("kg") // Gelecekte birimi değiştirilebilir yapıda tutabilirsin
                } label: {
                    Text("kg")
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                }
            }

            Spacer()

            Button(action: {
                guard let weightValue = Double(weightText.replacingOccurrences(of: ",", with: ".")) else {
                    print("❌ Geçersiz kilo değeri")
                    return
                }

                userProfileVM.addWeightEntry(weight: weightValue) { success in
                    if success {
                        dismiss()
                    } else {
                        print("⚠️ Güncelleme başarısız")
                    }
                }
            }) {
                Text("Ekle")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
        .padding()
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}

