//
//  WaterChallengeView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 12.06.2025.
//
import SwiftUI

struct WaterChallengeView: View {
    @StateObject private var vm = WaterChallengeViewModel()
    @State private var showSettings = false
    
    // Satırda kaç ikon olacağını belirle
    private let columns = [GridItem(.adaptive(minimum: 40), spacing: 16)]
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Su Mücadelesi")
                        .font(.title2.bold())
                    
                    Spacer()
                    
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                            .foregroundColor(.primary)
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Su")
                        .font(.headline)
                    Text("Hedef: \(String(format: "%.2f", vm.goalLiters)) L")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(0..<vm.goal, id: \.self) { index in
                        Image(systemName: index < vm.intake ? "drop.fill" : "drop")
                            .resizable()
                            .frame(width: 28, height: 34)
                            .foregroundColor(index < vm.intake ? .blue : .gray.opacity(0.3))
                            .onTapGesture {
                                vm.increment(to: index)
                            }
                    }
                }
                
                HStack {
                    Spacer()
                    Text("\(String(format: "%.2f", vm.totalLiters)) L")
                        .font(.headline)
                }
                
                if vm.intake >= vm.goal {
                    HStack(spacing: 12) {
                        Image(systemName: "trophy.fill")
                            .foregroundColor(.yellow)
                        VStack(alignment: .leading) {
                            Text("Tebrikler!")
                                .bold()
                            Text("Hedefinizi tamamladınız! Spor yapıyorsanız daha fazla içebilirsiniz.")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .shadow(radius: 4)
            .padding()
            
            .overlay(
                Group {
                    if showSettings {
                        ZStack {
                            // Karartılmış arka plan, tüm ekranı kaplar
                            Color.black.opacity(0.4)
                                .ignoresSafeArea()

                            // Ortalanmış içerik
                            VStack {
                                WaterChallengeSettingsView(goal: vm.goal) { newGoal in
                                    vm.updateGoal(to: newGoal)
                                    showSettings = false
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color(uiColor: .systemBackground))
                                        .shadow(radius: 10)
                                )
                                .frame(maxWidth: 340)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .contentShape(Rectangle())
                        }
                    }
                }
            )
            .animation(.easeInOut, value: showSettings)

        }
        
    }
}
