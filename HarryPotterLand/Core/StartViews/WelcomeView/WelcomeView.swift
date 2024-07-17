//
//  WelcomeView.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI

struct WelcomeView: View {
    
    @StateObject var welcomeViewModel: WelcomeViewModel
    @State private var scrollViewOffset: CGFloat = 0
    @State private var currentScale: CGFloat = 0
    @State private var showWelcomeView: Bool = true
    
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {
        Group {
            if showWelcomeView {
                welcomeContentView
            } else {
                MainTabView(homeViewModel: HomeViewModel(imageLoader: ImageLoaderManager(), apiManager: APIManager()))
            }
        }
    }
}

extension WelcomeView {
    
    private var welcomeContentView: some View {
        ZStack {
            colorBackground
            
            if currentUserSignedIn {
                signedInView
            } else {
                OnboardingView(onboardingViewModel: OnboardingViewModel(notificationManager: NotificationManager()))
                    .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
            }
        }
    }
    
    private var colorBackground: some View {
        ZStack {
            RadialGradient(
                colors: [
                    Color(
                        Constants.Colors.hufflepuffLightBrown
                    ).opacity(0.6),
                    Color(
                        Constants.Colors.ravenclawBlue
                    )
                ],
                center: .topTrailing,
                startRadius: 5,
                endRadius: 1700
            )
            
            Image(Constants.Images.hogwartsLogo)
                .withCustomImageModifier(frameWidth: UIScreen.main.bounds.width)
                .opacity(0.25)
                .offset(y: -90)
        }
        .ignoresSafeArea()
    }
    
    private var signedInView: some View {
        VStack (spacing: 20) {
            HStack {
                signOutButton
                Spacer()
                if let userInfo = userDisplayInfo {
                    VStack(spacing: -10) {
                        Text(userInfo.0)
                            .font(.custom(Constants.Fonts.fontSnitch, size: 65))
                        
                        Text(userInfo.1)
                            .font(.custom(Constants.Fonts.fontDumbledor, size: 20))
                    }
                    .foregroundStyle(.white)
                    .shadow(radius: 7)
                }
            }
            .padding(.horizontal)
            Spacer()
            titleView
            Spacer()
            imageView
            enterButtonLongPressView()
            enterButtonView
        }
        .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
    }
    
    var userDisplayInfo: (String, String)? {
        guard let userName = currentUserName,
              let userAge = currentUserAge,
              let userGender = currentUserGender,
              let firstCharacter = userName.first else {
            return nil
        }
        return ("\(firstCharacter)", "\(userGender), \(userAge)")
    }
    
    private var signOutButton: some View {
        Text(Constants.Titles.signOut)
            .foregroundColor(.white)
            .font(.headline)
            .frame(width: 100, height: 45)
            .background(Color.black)
            .cornerRadius(10)
            .padding(.horizontal)
            .onTapGesture {
                welcomeViewModel.signOut()
            }
    }
    
    private var titleView: some View {
        Text(Constants.Titles.titleHarryPotterLand)
            .font(Font.custom(Constants.Fonts.fontWelcomeScreen, size: 100))
            .kerning(2)
            .multilineTextAlignment(.center)
            .shadow(radius: 5)
    }
    
    private var imageView: some View {
        Image(Constants.Images.hogwartsCastleCartoon)
            .withCustomImageModifier(frameWidth: 155)
            .cornerRadius(90)
            .scaleEffect(1 + currentScale)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        currentScale = value - 1
                    }
                    .onEnded{ value in
                        withAnimation(.spring()) {
                            currentScale = 0
                        }
                    }
            )
    }
    
    private func enterButtonLongPressView() -> some View {
        Button("", action: {
            
        })
        .buttonStyle(
            WelcomeScreenButton(
                text: Constants.Titles.pressAndHold,
                height: nil,
                width: nil,
                performAction: {}
            )
        )
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.3)
                .onEnded { _ in
                    welcomeViewModel.playSound()
                }
        )
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onEnded{ _ in
                    welcomeViewModel.stopSound()
                })
    }
    
    private var enterButtonView: some View {
        Button {
            showWelcomeView.toggle()
        } label: {
            NavigationLink(
                destination: MainTabView(
                    homeViewModel: HomeViewModel(
                        imageLoader: ImageLoaderManager(),
                        apiManager: APIManager()
                    )
                )
            )
            {
            }
            .buttonStyle(
                WelcomeScreenButton(
                    text: Constants.Titles.enter,
                    height: nil,
                    width: nil,
                    performAction: {}
                )
            )
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(welcomeViewModel: WelcomeViewModel(soundManager: SoundManager()))
    }
}
