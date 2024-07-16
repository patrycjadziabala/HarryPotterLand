//
//  WelcomeViewMdoel.swift
//  HarryPotterLand
//
//  Created by Patka on 29/06/2024.
//

import Foundation
import SwiftUI

@MainActor
class WelcomeViewModel: ObservableObject {
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    
    var soundManager: SoundManagerProtocol
    
    init(soundManager: SoundManagerProtocol) {
        self.soundManager = soundManager
        print(currentUserSignedIn.description)
    }
    
    func signOut() {
        currentUserName = nil
        currentUserAge = nil
        currentUserGender = nil
        withAnimation(.spring()) {
            currentUserSignedIn = false
        }
    }
    
    func playSound() {
        soundManager.playSound()
    }
    func stopSound() {
        soundManager.stopSound()
    }
}
