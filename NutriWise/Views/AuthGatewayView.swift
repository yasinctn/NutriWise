//
//  AuthGatewayView.swift
//  NutriWise
//
//  Created by Yasin Cetin on 4.06.2025.
//

import SwiftUI



struct AuthGatewayView: View {
    let purpose: AuthPurpose

    var title: String {
        switch purpose {
        case .login: return "Hoş geldiniz!"
        case .signup: return "Yanıtlarınızı kaydedin"
        }
    }

    var subtitle: String {
        switch purpose {
        case .login: return "NutriWise hesabınıza erişmek için\nbağlanın"
        case .signup: return "Ayarlarınızı kaydetmek için hesabınızı\nkaydedin."
        }
    }

    var body: some View {
        VStack(spacing: 28) {
            Spacer()

            illustration

            Text(title)
                .font(.title)
                .fontWeight(.bold)

            Text(subtitle)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)

            VStack(spacing: 14) {
                SignInButton(label: "Apple ile bağlan", color: .black, textColor: .white, icon: "apple.logo") {
                    LoginView()
                }
                SignInButton(label: "Facebook ile devam et", color: Color(red: 59/255, green: 89/255, blue: 152/255), textColor: .white, icon: "f.circle.fill") {
                    LoginView()
                }
                SignInButton(label: "Google ile devam et", color: Color(.systemGray5), textColor: .black, icon: "g.circle.fill") {
                    LoginView()
                }
                
                switch purpose {
                case .login:
                    SignInButton(label: "E-posta ile devam et", color: Color(red: 246/255, green: 248/255, blue: 252/255), icon: "envelope.fill") {
                       
                        LoginView()
                    }
                case .signup:
                    SignInButton(label: "E-posta ile devam et", color: Color(red: 246/255, green: 248/255, blue: 252/255), icon: "envelope.fill") {
                       
                        RegisterView()
                    }
                }
                
                
            }
            .padding(.horizontal)

            Text("İzniniz olmadan hiçbir şeyi paylaşmayacak ya da göndermeyeceğiz.")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.top)

            Spacer()
        }
        .padding()
    }
    
    // MARK: - Illustration
        var illustration: some View {
            switch purpose {
            case .login:
                return AnyView(
                    ZStack {
                        Image(systemName: "book.closed.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.black)
                            .offset(x: -10)
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.orange)
                            .offset(x: 20, y: 20)
                    }
                )
            case .signup:
                return AnyView(
                    HStack(spacing: 16) {
                        Image(systemName: "leaf.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.green)
                        Image(systemName: "scalemass.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.blue)
                    }
                )
            }
        }

    
}


#Preview {
    AuthGatewayView(purpose: .signup)
}


// MARK: - SignInButton

struct SignInButton<Destination: View>: View {
    var label: String
    var color: Color
    var textColor: Color = .black
    var icon: String
    var destination: () -> Destination

    var body: some View {
        NavigationLink {
            destination()
        } label: {
            HStack {
                Image(systemName: icon)
                Text(label)
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .foregroundColor(textColor)
            .cornerRadius(12)
        }
        
        
    }
}



