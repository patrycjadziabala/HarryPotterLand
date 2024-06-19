//
//  OnboardingView.swift
//  HarryPotterLand
//
//  Created by Patka on 19/03/2024.
//

import SwiftUI

struct OnboardingView: View {
    
    //Onboarding states:
    /*
     0 - Welcome screen
     1 - Add name
     2 - Add age
     3 - Add gender
     */
    
    @State var onboardingState: Int = 0
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    
    //onboarding inputs
    @State var name: String = ""
    @FocusState private var nameFieldInFocus: Bool
    @State var age: Double = 50
    @State var gender: String = ""
    
    //alert properties
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    //app storage
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {
        ZStack {
            //content
            switch onboardingState {
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
            default: welcomeScreen
            }
            //buttons
            VStack {
                Spacer()
                bottomButton
            }
            .padding(30)
        }
        .alert(isPresented: $showAlert) {
            return Alert(title: Text(alertTitle))
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .background(Color.purple)
    }
}

extension OnboardingView {
    
    private var bottomButton: some View {
        Text(onboardingState == 0 ? Constants.Titles.signIn :
                onboardingState == 3 ? Constants.Titles.finish :
                Constants.Titles.next)
        .font(.headline)
        .foregroundColor(.purple)
        .frame(height: 55)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .onTapGesture {
            handleNextButtonPressed()
        }
    }
    
    private var welcomeScreen: some View {
        VStack(spacing: 40) {
            Spacer()
            Text(Constants.Titles.welcomeToHPWorld)
                .font(.custom(Constants.Fonts.fontWelcomeScreen, size: 55))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .foregroundColor(.white)
            Image(Constants.Images.hogwartsCastleCartoon)
                .withCustomImageModifier(frameWidth: 350)
                .cornerRadius(35)
            Text(Constants.Titles.pleaseSignIn)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
            Spacer()
        }
    }
    
    private var addNameSection: some View {
        VStack (spacing: 20) {
            Spacer()
            Text(Constants.Titles.pleaseEnterYourName)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
            TextField(Constants.Titles.yourName, text: $name)
                .focused($nameFieldInFocus)
                .font(.headline)
                .frame(height: 55)
                .padding(.horizontal)
                .background(Color.white)
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
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Text("\(String(format: "%.0f", age))")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Slider(value: $age, in: 1...100, step: 1)
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
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Picker(selection: $gender) {
                Text(Constants.Titles.male).tag("Male")
                Text(Constants.Titles.female).tag("Female")
                Text(Constants.Titles.nonbinary).tag("Non-Binary")
            } label: {
                Text(gender.count > 1 ? gender : "Select a gender")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .pickerStyle(MenuPickerStyle())
            Spacer()
            Spacer()
        }
        .padding(30)
    }
}

//MARK: FUNCTIONS
extension OnboardingView {
    func handleNextButtonPressed() {
        //CHECK INPUTS
        switch onboardingState {
        case 1:
            guard name.count >= 3 else {
                nameFieldInFocus = true
                showAlert(title: Constants.Titles.alertName)
                return
            }
        case 3:
            guard gender.count > 1 else {
                showAlert(title: Constants.Titles.alertGender)
                return
            }
        default:
            break
        }
        //GO TO NEXT SECTION
        if onboardingState == 3 {
            signIn()
        } else {
            withAnimation(.spring()) {
                onboardingState += 1
            }
        }
    }
    
    func signIn() {
        NotificationManager.instance.requestAuthorisation()
        currentUserName = name
        currentUserAge = Int(age)
        currentUserGender = gender
        withAnimation(.spring()) {
            currentUserSignedIn = true
        }
    }
    
    func showAlert(title: String) {
        alertTitle = title
        showAlert.toggle()
    }
}
