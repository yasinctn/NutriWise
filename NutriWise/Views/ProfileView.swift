//
//  ProfileView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 8.06.2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var userProfileVM: UserProfileViewModel

    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @AppStorage("userId") var userId: Int = 0

    @State private var showAddWeight = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {

                    // MARK: Kullanıcı Bilgileri
                    VStack(spacing: 12) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.green)

                        Text(userProfileVM.name.isEmpty ? "Kullanıcı" : userProfileVM.name)
                                .font(.title.bold())
                        
                        Text(userProfileVM.email)
                                .font(.subheadline)
                                .foregroundColor(.secondary)


                        Text(userProfileVM.gender)
                            .foregroundColor(.secondary)

                        if let calorie = userProfileVM.calorieDifference {
                            Text("\(calorie) kcal / gün")
                                .font(.headline)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color(.systemGray6))
                                .cornerRadius(16)
                        }
                    }

                    // MARK: Ağırlık Bilgisi
                    VStack(spacing: 12) {
                        HStack(spacing: 16) {
                            weightItem(label: "Başlangıç kilosu", value: userProfileVM.weightDouble)
                            weightItem(label: "Mevcut kilo", value: userProfileVM.startingWeight )
                            weightItem(label: "Hedef Ağırlık", value: userProfileVM.targetWeightDouble)
                        }

                        Button(action: {
                            showAddWeight = true
                        }) {
                            Text("Bir tartım ekle")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    }

                    // MARK: Kilo Grafiği
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Kilo hedefi")
                            .font(.headline)

                        let lost = userProfileVM.startingWeight - userProfileVM.weightDouble
                        Text("Başlangıçtan bu yana kaydedilen \(lost, specifier: "%.1f") kg ")
                            .font(.subheadline)
                            .foregroundColor(.green)

                        WeightChartView(weightHistory: userProfileVM.weightHistory)

                    }
                    .padding(.horizontal)

                    // MARK: Çıkış Yap
                    Button(action: {
                        isLoggedIn = false
                    }) {
                        Text("Çıkış Yap")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
                .sheet(isPresented: $showAddWeight) {
                    AddWeightView()
                }
            }
            .navigationTitle("Profil")
            .onAppear {
                userProfileVM.fetchUserProfile()
                userProfileVM.fetchWeightHistory()
                userProfileVM.fetchUserBasicInfo() 
            }

        }
    }

    func weightItem(label: String, value: Double) -> some View {
        VStack(spacing: 4) {
            Text("\(value, specifier: "%.1f") kg")
                .font(.headline)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }
}


