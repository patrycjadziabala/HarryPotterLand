//
//  WelcomeView.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI

struct WelcomeView: View {
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    
    var body: some View {
        ZStack {
//            colorBackground
//            Image(Constants.Images.hogwartsLogo)
//                .withCustomImageModifier(frameWidth: UIScreen.main.bounds.width)
//                .opacity(0.25)
//                .offset(y: -90)
            
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
                        .padding(.bottom)
                }
                .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
            } else {
                OnboardingView()
                    .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
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
    
    private var colorBackground: some View {
        ZStack{
//            RadialGradient(
//                colors: [
//                    Color(
//                        Constants.Colors.ravenclawGold
//                    ),
//                    Color(
//                        Constants.Colors.slytherinGreen
//                    )
//                ],
//                center: .bottomLeading,
//                startRadius: 5,
//                endRadius: 700
//            )
//            
//            RadialGradient(
//                colors: [
//                    Color(
//                        Constants.Colors.ravenclawDarkBlue
//                    ).opacity(0.3),
//                    Color(
//                        Constants.Colors.slytherinDarkSilver
//                    ).opacity(0.3)
//                ],
//                center: .topTrailing,
//                startRadius: 5,
//                endRadius: 300
//            )
        }
        .ignoresSafeArea()
    }
    
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
            .font(Font.custom(Constants.Fonts.fontWelcomeScreen, size: 100))
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
        
        private var soundManager = SoundManager()
        
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
                    soundManager.playSound()
                    print("started")
                }
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onEnded{ _ in
                            soundManager.stopSound()
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
