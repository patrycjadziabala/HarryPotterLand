//
//  WelcomeView.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI

struct WelcomeView: View {
    @AppStorage("signed_in") var currentUserSignedIn: Bool = true
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [Color.gray, Color.blue], center: .center, startRadius: 5, endRadius: 500)
                .ignoresSafeArea()
            if currentUserSignedIn {
                VStack (spacing: 20) {
                    Text("Sign out")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .onTapGesture {
                            signOut()
                        }
                        .padding(.bottom, 20)
                    if let userName = currentUserName,
                       let userAge = currentUserAge {
                        Text("Hello \(userName), \(userAge)")
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                    }
                    title
                    Spacer()
                    Image(Constants.hogwartsCastleCartoon)
                        .withCustomImageModifier(frameWidth: 155)
                        .cornerRadius(90)
                    EnterButtonLongPressView()
                    EnterButtonView()
                }
            } else {
                OnboardingView()
            }
        }
    }
    
    var title: some View {
        Text(Constants.titleHarryPotterLand)
            .font(Font.custom(Constants.fontHPWelcomeScreen, size: 100))
            .kerning(2)
            .multilineTextAlignment(.center)
    }
    
    struct EnterButtonLongPressView: View {
        // play hogwarts theme song and enter once hold is released
        var body: some View {
            Button {
                // MainTabView()
            } label: {
                VStack {
                    Capsule()
                        .fill(Color.white)
                        .frame(width: 75, height: 75)
                        .shadow(radius: 10)
                        .overlay(
                            Text(Constants.pressAndHold)
                        )
                }
            }
        }
    }
    
    struct EnterButtonView: View {
        var body: some View {
            Button {
                // MainTabView()
            } label: {
                VStack {
                    Capsule()
                        .fill(Color.white)
                        .frame(width: 75, height: 75)
                        .shadow(radius: 10)
                        .overlay(
                            Text(Constants.enter)
                        )
                }
            }
        }
    }
    
    func signOut() {
        currentUserName = nil
        currentUserAge = nil
        currentUserGender = nil
        withAnimation(.spring()) {
            currentUserSignedIn = false
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
