//
//  ContentView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 4.06.2025.
//

import SwiftUI

struct ContentView: View {
    var isLoggedIn: Bool = false
    var body: some View {
        NavigationStack {
                    if isLoggedIn {
                        // Kullanıcı giriş yaptıysa ana ekrana yönlendir
                        
                    } else {
                        // Giriş yapılmamışsa karşılama ekranı
                        OnboardingEntryView()
                    }
                }
    }
}

#Preview {
    ContentView()
}
