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
    
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            colorBackground
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Text("Tap here")
                            .foregroundStyle(.black)
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        
                    }
                }
            
            if currentUserSignedIn {
                VStack (spacing: 20) {
                    HStack {
                        signOutButton
                        Spacer()
                        if let userName = currentUserName,
                           let userAge = currentUserAge,
                           let userGender = currentUserGender {
                            VStack(spacing: -10) {
                                Text("\(userName.first!)")
                                    .font(.custom(Constants.Fonts.fontSnitch, size: 65))
                                Text("\(userGender), \(userAge)")
                                    .font(.custom(Constants.Fonts.fontDumbledor, size: 20))
                            }
                            .shadow(radius: 1)
                            .foregroundStyle(Color(Constants.Colors.hufflepuffDarkBrown))
                        }
                    }
                    .padding(.horizontal)
                    Spacer()
                    titleView
                    Spacer()
                    imageView
                    EnterButtonLongPressView(soundManager: SoundManager())
                    EnterButtonView()
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
            RadialGradient(
                colors: [
                    Color(
                        Constants.Colors.hufflepuffDarkBrown
                    ).opacity(0.7),
                    Color(
                        Constants.Colors.slytherinDarkSilver
                    ).opacity(0.3)
                ],
                center: .topTrailing,
                startRadius: 5,
                endRadius: 1500
            )
            
            Image(Constants.Images.hogwartsLogo)
                .withCustomImageModifier(frameWidth: UIScreen.main.bounds.width)
                .opacity(0.25)
                .offset(y: -90)
        }
        .ignoresSafeArea()
    }
    
    private var signOutButton: some View {
        Text("Sign out")
            .foregroundColor(.white)
            .font(.headline)
            .frame(width: 100, height: 45)
            .background(Color.black)
            .cornerRadius(10)
            .padding(.horizontal)
            .onTapGesture {
                signOut()
            }
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
        
        private var soundManager: SoundManager
        
        init(soundManager: SoundManager) {
            self.soundManager = soundManager
        }
        
        var body: some View {
            Button("", action: {
                
            })
            .buttonStyle(WelcomeScreenButton(text: Constants.Titles.pressAndHold, performAction: {
                
            }))
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0.3)
                    .onEnded { _ in
                        soundManager.playSound()
                    }
            )
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
                Text("")
            }
            .buttonStyle(WelcomeScreenButton(text: Constants.Titles.enter, performAction: {
                // action here
            }))
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
