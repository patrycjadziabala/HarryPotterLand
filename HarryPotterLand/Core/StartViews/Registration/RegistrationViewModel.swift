//
//  OnboardingViewModel.swift
//  HarryPotterLand
//
//  Created by Patka on 08/07/2024.
//

import Foundation
import SwiftUI

@MainActor
class OnboardingViewModel: ObservableObject {
    
    //Onboarding states:
    /*
     0 - Welcome screen
     1 - Add name
     2 - Add age
     3 - Add gender
     */
    @Published var onboardingState: Int = 0

    //Onboarding inputs
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var age: Double = 50
    @Published var gender: String = "Male"
    
    //Alert properties
    @Published var alertTitle: String = ""
    @Published var showAlert: Bool = false
    
    //App storage
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    let notificationManager: NotificationManagerProtocol
    
    init(notificationManager: NotificationManagerProtocol) {
        self.notificationManager = notificationManager
    }
    
    func handleNextButtonPressed() {
        //CHECK INPUTS
        switch onboardingState {
        case 1:
            guard name.count >= 3 else {
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
    
    private func showAlert(title: String) {
        alertTitle = title
        showAlert.toggle()
    }
    
    private func signIn() {
        requestAutorisationForNotifications()
        currentUserName = name
        currentUserAge = Int(age)
        currentUserGender = gender
//        withAnimation(.spring()) {
            currentUserSignedIn = true
//        }
    }
    
    private func requestAutorisationForNotifications() {
        notificationManager.requestAuthorisation()
    }
}
