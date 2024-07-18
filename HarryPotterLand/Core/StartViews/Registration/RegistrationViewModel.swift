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
    @Published var registrationState: Int = 0
    
    //Registration inputs
    @Published var login: String = ""
    @Published var password: String = ""
   @Published var confirmPassword: String = ""
    @Published var age: Double = 50
    @Published var gender: String = "Male"
    
    //Alert properties
    @Published var alertTitle: String = ""
    @Published var showAlert: Bool = false
    
    //App storage
    @AppStorage("name") var currentUserLogin: String?
    @AppStorage("password") var currentUserPassword: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    let notificationManager: NotificationManagerProtocol
    
    init(notificationManager: NotificationManagerProtocol) {
        self.notificationManager = notificationManager
    }
    
    func handleNextButtonPressed() {
        //CHECK INPUTS
        switch registrationState {
        case 1:
            if !validateLogin() {
                return
            }
        case 2:
            if !validatePassword() { return }
        case 3:
            if !validateGender() { return }
        default:
            break
        }
        //GO TO NEXT SECTION
        if registrationState == 4 {
            signIn()
        } else {
            print(registrationState.description)
            withAnimation(.spring()) {
                registrationState += 1
                print(registrationState.description)
                
            }
        }
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
    // MARK: - Sign in
    
    private func signIn() {
        requestAutorisationForNotifications()
        currentUserLogin = login
        currentUserPassword = password
        currentUserAge = Int(age)
        currentUserGender = gender
        //        withAnimation(.spring()) {
        currentUserSignedIn = true
        //        }
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
