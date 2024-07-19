//
//  RegistationViewModel.swift
//  HarryPotterLand
//
//  Created by Patka on 08/07/2024.
//

import Foundation
import SwiftUI

@MainActor
class RegistationViewModel: ObservableObject {
    
    //Registration states:
    /*
     0 - Welcome screen
     1 - Add login
     2 - Add password
     3 - Add age
     4 - Add gender
     */
    @Published var registrationState: RegistrationState = .welcomeScreen
    
    //Registration inputs
    @Published var login: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var age: Double = 50
    @Published var gender: String = "Male"
    
    //Alert properties
    @Published var alertTitle: String = ""
    @Published var showAlert: Bool = false
    
    let notificationManager: NotificationManagerProtocol
    let persistenceManager: PersistenceManagerProtocol
    @Published var userManager: UserManagerProtocol
    
    init(notificationManager: NotificationManagerProtocol, persistenceManager: PersistenceManagerProtocol, userManager: UserManagerProtocol) {
        self.notificationManager = notificationManager
        self.persistenceManager = persistenceManager
        self.userManager = userManager
    }
    
    func handleNextButtonPressed() {
        //CHECK INPUTS
        switch registrationState {
        case .addLogin:
            guard validateLogin() else { return }
        case .addPassword:
            guard validatePassword() else { return }
        case .addGender:
            guard validateGender() else { return }
        default:
            break
        }
        
        //GO TO NEXT SECTION
        proceedToNextStateOrSignIn()
    }
    // MARK: - Validation functions
    
    private func validateLogin() -> Bool {
        guard login.count >= 3 else {
            showAlert(title: Constants.Titles.alertLogin)
            return false
        }
        return true
    }
    
    private func validatePassword() -> Bool {
        guard password.count >= 3 else {
            showAlert(title: Constants.Titles.alertPasswordLength)
            return false
        }
        guard containsSpecialCharacter(password: password) else {
            showAlert(title: Constants.Titles.alertPasswordSpecialCharacters)
            return false
        }
        guard password == confirmPassword else {
            showAlert(title: Constants.Titles.alertPasswordsDontMatch)
            return false
        }
        return true
    }
    
    private func containsSpecialCharacter(password: String) -> Bool {
        let specialCharacterRegex = ".*[!@#$%^&*(),.?\":{}|<>].*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex)
        return predicate.evaluate(with: password)
    }
    
    func validatePasswordFirstTextfield() -> Bool {
        return password.count >= 3
    }
    
    func validatePasswordCharacterCount() -> Bool {
        password.count >= 1
    }
    
    func validateConfirmPasswordCharacterCount() -> Bool {
        confirmPassword.count >= 1
    }
    
    private func validateGender() -> Bool {
        guard gender.count > 1 else {
            showAlert(title: Constants.Titles.alertGender)
            return false
        }
        return true
    }
    // MARK: - Helper Methods
    
    private func proceedToNextStateOrSignIn() {
        if registrationState == .addGender {
            registerUser()
        } else {
            withAnimation(.spring()) {
                registrationState = RegistrationState(rawValue: registrationState.rawValue + 1) ?? .welcomeScreen
            }
        }
    }
    // MARK: - Registration methods
    
    private func registerUser() {
        requestAutorisationForNotifications()
        persistenceManager.registerUser(login: login, password: password, age: age, gender: gender)
        withAnimation(.spring()) {
            signIn()
        }
    }
    
    private func signIn() {
        requestAutorisationForNotifications()
        let currentUser = User(
            id: UUID(),
            login: login,
            password: password,
            age: age,
            gender: gender,
            userSignedIn: true
        )
        
        userManager.loggedInUser = currentUser
        
        //            withAnimation(.spring()) {
        //                currentUserSignedIn = true
        //            }
    }
    //MARK: - Notifications
    
    private func showAlert(title: String) {
        alertTitle = title
        showAlert.toggle()
    }
    
    private func requestAutorisationForNotifications() {
        notificationManager.requestAuthorisation()
    }
}
