//
//  OnboardingView.swift
//  HarryPotterLand
//
//  Created by Patka on 19/03/2024.
//

import SwiftUI

struct OnboardingView: View {
    
    @StateObject var onboardingViewModel: OnboardingViewModel
    
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    
    @FocusState private var nameFieldInFocus: Bool
    
    var body: some View {
        ZStack {
            //content
            switch onboardingViewModel.onboardingState {
            case 0:
                welcomeScreen
                    .transition(transition)
            case 1:
                addNameSection
                    .transition(transition)
            case 2:
                addAgeSection
                    .transition(transition)
            case 3:
                addGenderSection
                    .transition(transition)
            default: welcomeScreen //fallback to welcome screen
            }
            
            VStack {
                Spacer()
                signInButton
            }
            .padding(30)
        }
        .alert(isPresented: $onboardingViewModel.showAlert) {
            Alert(title: Text(onboardingViewModel.alertTitle))
        }
    }
}

// MARK: - Components

extension OnboardingView {
    
    private var signInButton: some View {
        VStack {
            Text(Constants.Titles.pleaseSignIn)
                .font(.custom(Constants.Fonts.fontDumbledor, size: 35))
                .foregroundColor(.white)
                .overlay(
                    Capsule(style: .continuous)
                        .frame(height: 3)
                        .offset(y: 7)
                        .foregroundStyle(.white)
                    ,alignment: .bottom
                )
                .opacity(onboardingViewModel.onboardingState == 0 ? 1 : 0.001)
                .padding()
            
            Text(buttonText)
                .font(.custom(Constants.Fonts.fontDumbledor, size: 25))
                .foregroundColor(.brown)
                .kerning(2)
                .shadow(radius: 1)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .onTapGesture {
                    onboardingViewModel.handleNextButtonPressed()
                }
        }
    }
    
    private var welcomeScreen: some View {
        VStack(spacing: 40) {
            Spacer()
            Text(Constants.Titles.welcomeToHPWorld)
                .font(.custom(Constants.Fonts.fontWelcomeScreen, size: 73))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .shadow(radius: 4)
                .padding(.horizontal, 3)
            Image(Constants.Images.hogwartsCastleCartoon)
                .withCustomImageModifier(frameWidth: 350)
                .cornerRadius(35)
                .opacity(0.8)
                .shadow(radius: 10)
            Spacer()
            Spacer()
        }
    }
    
    private var addNameSection: some View {
        VStack (spacing: 20) {
            Spacer()
            Text(Constants.Titles.pleaseEnterYourName)
                .font(.custom(Constants.Fonts.fontDumbledor, size: 35))
                .foregroundColor(.white)
            TextField(Constants.Titles.yourName, text: $onboardingViewModel.name)
                .focused($nameFieldInFocus)
                .font(.custom(Constants.Fonts.fontDumbledor, size: 25))
                .kerning(2)
                .frame(height: 55)
                .padding(.horizontal)
                .foregroundStyle(.brown)
                .shadow(radius: 1)
                .background(.white)
                .cornerRadius(10)
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    private var addAgeSection: some View {
        VStack (spacing: 20) {
            Spacer()
            Text(Constants.Titles.pleaseEnterYourAge)
                .font(.custom(Constants.Fonts.fontDumbledor, size: 35))
                .foregroundColor(.white)
                .shadow(radius: 1)
            Text("\(String(format: "%.0f", onboardingViewModel.age))")
                .font(.custom(Constants.Fonts.fontDumbledor, size: 55))
                .foregroundStyle(.white)
            Slider(value: $onboardingViewModel.age, in: 1...100, step: 1)
                .tint(.white)
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    private var addGenderSection: some View {
        VStack (spacing: 20) {
            Spacer()
            Text(Constants.Titles.pleaseSelectYourGender)
                .font(.custom(Constants.Fonts.fontDumbledor, size: 35))
                .foregroundColor(.white)
            Picker(selection: $onboardingViewModel.gender) {
                Text(Constants.Titles.selectGender).tag("G")
                Text(Constants.Titles.male).tag(Constants.Titles.male)
                Text(Constants.Titles.female).tag(Constants.Titles.female)
                Text(Constants.Titles.nonbinary).tag(Constants.Titles.nonbinary)
            } label: {
                Text(selectedGenderText)
                    .foregroundColor(.white)
            }
            .font(.custom(Constants.Fonts.fontDumbledor, size: 35))
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(10)
            .pickerStyle(MenuPickerStyle())
            .tint(.brown)
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    // Computed properties
    
    private var buttonText: String {
        switch onboardingViewModel.onboardingState {
        case 0:
            return Constants.Titles.signIn
        case 3:
            return Constants.Titles.finish
        default:
            return Constants.Titles.next
        }
    }
    
    private var selectedGenderText: String {
        if onboardingViewModel.gender.isEmpty {
            return Constants.Titles.selectGender
        } else {
            return onboardingViewModel.gender
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(onboardingViewModel: OnboardingViewModel(notificationManager: NotificationManager()))
    }
}
