//
//  RegistrationView.swift
//  HarryPotterLand
//
//  Created by Patka on 19/03/2024.
//

import SwiftUI

struct RegistrationView: View {
    
    @StateObject var registrationViewModel: RegistationViewModel
    
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    
    @FocusState private var firstPasswordFieldInFocus: Bool
    @FocusState private var secondPasswordFieldInFocus: Bool
    
    @State var showFirstPassword: Bool = false
    @State var showSecondPassword: Bool = false
    
    var body: some View {
        ZStack {
            //content based on registration state
            switch registrationViewModel.registrationState {
            case .welcomeScreen:
                welcomeScreen
                    .transition(transition)
            case .addLogin:
                addLoginSection
                    .transition(transition)
            case .addPassword:
                addPasswordSection
                    .transition(transition)
            case .addAge:
                addAgeSection
                    .transition(transition)
            case .addGender:
                addGenderSection
                    .transition(transition)
            default: welcomeScreen //fallback to welcome screen
            }
            
            VStack {
                Spacer()
                nextButton
            }
            .padding(30)
        }
        .alert(isPresented: $registrationViewModel.showAlert) {
            Alert(title: Text(registrationViewModel.alertTitle))
        }
    }
}

// MARK: - Components

extension RegistrationView {
    
    private var nextButton: some View {
        VStack {
            Text(Constants.Titles.pleaseSignIn)
                .withCustomTitleTextFormatting(fontType: .textFont, fontSize: 35)
                .overlay(
                    Capsule(style: .continuous)
                        .frame(height: 3)
                        .offset(y: 7)
                        .foregroundStyle(.white)
                    ,alignment: .bottom
                )
                .opacity(registrationViewModel.registrationState.rawValue == 0 ? 1 : 0.001)
                .padding()
            
            Text(buttonText)
                .withCustomTitleTextFormatting(fontType: .textFont, fontSize: 25, foregroundColor: .brown)
                .kerning(2)
                .shadow(radius: 1)
                .frame(height: 55)
                .background(Color.white)
                .cornerRadius(10)
                .onTapGesture {
                    registrationViewModel.handleNextButtonPressed()
                }
        }
    }
    
    private var welcomeScreen: some View {
        VStack(spacing: 40) {
            Spacer()
            Text(Constants.Titles.welcomeToHPWorld)
                .withCustomTitleTextFormatting(
                    fontType: .welcomeScreenFont,
                    fontSize: 73
                )
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
    
    private var addLoginSection: some View {
        VStack (spacing: 20) {
            Spacer()
            Text(Constants.Titles.pleaseEnterYourLogin)
                .withCustomTitleTextFormatting(
                    fontType: .titleFont,
                    fontSize: 35
                )
            TextField(Constants.Titles.yourLogin, text: $registrationViewModel.login)
                .autocorrectionDisabled(true)
            //                .focused($fieldInFocus)
                .withCustomTitleTextFormatting(
                    fontType: .titleFont,
                    fontSize: 25,
                    foregroundColor: .brown
                )
                .kerning(2)
                .frame(height: 55)
                .padding(.horizontal)
                .shadow(radius: 1)
                .background(.white)
                .cornerRadius(10)
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    private var addPasswordSection: some View {
        ZStack (alignment: .trailing) {
            VStack (spacing: 20) {
                Spacer()
                Text(Constants.Titles.pleaseEnterYourPassword)
                    .withCustomTitleTextFormatting(
                        fontType: .titleFont,
                        fontSize: 35
                    )
                
                passwordField(
                    showPassword: $showFirstPassword,
                    isFocused: $firstPasswordFieldInFocus,
                    password: $registrationViewModel.password,
                    placeholder: Constants.Titles.yourPassword,
                    opacity: registrationViewModel.validatePasswordCharacterCount()
                )
                
                passwordField(
                    showPassword: $showSecondPassword,
                    isFocused: $secondPasswordFieldInFocus,
                    password: $registrationViewModel.confirmPassword,
                    placeholder: Constants.Titles.confirmPassword,
                    opacity: registrationViewModel.validateConfirmPasswordCharacterCount()
                )
                .opacity(registrationViewModel.validatePasswordFirstTextfield() ? 1 : 0)
                .animation(.easeIn, value: registrationViewModel.password)
                
                Spacer()
                Spacer()
            }
            .padding(30)
        }
    }
    
    private func passwordField(showPassword: Binding<Bool>, isFocused: FocusState<Bool>.Binding, password: Binding<String>, placeholder: String, opacity: Bool) -> some View {
        
        ZStack (alignment: .trailing) {
            if showPassword.wrappedValue {
                TextField(placeholder, text: password)
                    .customTextFieldStyle(isFocused: isFocused)
            } else {
                SecureField(placeholder, text: password)
                    .customTextFieldStyle(isFocused: isFocused)
                
            }
            
            Button(action: {
                showPassword.wrappedValue.toggle()
                if showPassword.wrappedValue {
                    isFocused.wrappedValue = true
                }
            }, label: {
                let eyeIcon = showPassword.wrappedValue ? Constants.Images.eyeIcon : Constants.Images.eyeCrossedIcon
                Image(systemName: eyeIcon)
                    .foregroundColor(Color(Constants.Colors.hufflepuffLightBrown).opacity(0.8))
                    .padding()
                    .opacity(opacity ? 1 : 0)
            })
        }
    }
    
    private var addAgeSection: some View {
        VStack (spacing: 20) {
            Spacer()
            Text(Constants.Titles.pleaseEnterYourAge)
                .withCustomTitleTextFormatting(
                    fontType: .titleFont,
                    fontSize: 35
                )
                .shadow(radius: 1)
            Text("\(String(format: "%.0f", registrationViewModel.age))")
                .withCustomTitleTextFormatting(
                    fontType: .titleFont,
                    fontSize: 55
                )
            Slider(value: $registrationViewModel.age, in: 1...100, step: 1)
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
                .withCustomTitleTextFormatting(
                    fontType: .titleFont,
                    fontSize: 35
                )
            Picker(selection: $registrationViewModel.gender) {
                Text(Constants.Titles.selectGender).tag("G")
                Text(Constants.Titles.male).tag(Constants.Titles.male)
                Text(Constants.Titles.female).tag(Constants.Titles.female)
                Text(Constants.Titles.nonbinary).tag(Constants.Titles.nonbinary)
            } label: {
                Text(selectedGenderText)
                    .withCustomTitleTextFormatting(
                        fontType: .titleFont,
                        fontSize: 35
                    )
            }
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
        switch registrationViewModel.registrationState {
        case .welcomeScreen:
            return Constants.Titles.signIn
        case .addGender:
            return Constants.Titles.finish
        default:
            return Constants.Titles.next
        }
    }
    
    private var selectedGenderText: String {
        if registrationViewModel.gender.isEmpty {
            return Constants.Titles.selectGender
        } else {
            return registrationViewModel.gender
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(registrationViewModel: RegistationViewModel(notificationManager: NotificationManager()))
    }
}
