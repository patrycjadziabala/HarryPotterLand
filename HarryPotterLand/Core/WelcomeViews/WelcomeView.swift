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
                    signOutButton
                    if let userName = currentUserName,
                       let userAge = currentUserAge {
                        Text("Hello \(userName), \(userAge)")
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                    }
                    titleView
                    Spacer()
                    imageView
                    EnterButtonLongPressView()
                    EnterButtonView()
                }
            } else {
                OnboardingView()
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

extension WelcomeView {
    
    private var signOutButton: some View {
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
    }
    
    var titleView: some View {
        Text(Constants.Titles.titleHarryPotterLand)
            .font(Font.custom(Constants.Fonts.fontHP, size: 100))
            .kerning(2)
            .multilineTextAlignment(.center)
    }
    
    private var imageView: some View {
        Image(Constants.Images.hogwartsCastleCartoon)
            .withCustomImageModifier(frameWidth: 155)
            .cornerRadius(90)
    }
    
    struct EnterButtonLongPressView: View {
        
        @State private var isPressingDown: Bool = false
        
        var body: some View {
            Capsule()
                .fill(Color.white)
                .frame(width: 75, height: 75)
                .shadow(radius: 10)
                .overlay(
                    Text(Constants.Titles.pressAndHold)
                        .multilineTextAlignment(.center)
                )
                .onLongPressGesture(minimumDuration: 0.3) {
                    SoundManager.instance.playSound()
                    print("started")
                }
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onEnded{ _ in
                            SoundManager.instance.stopSound()
                        }
                )
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
                            Text(Constants.Titles.enter)
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
