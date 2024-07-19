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

    let persistenceManager: PersistenceManagerProtocol
    var soundManager: SoundManagerProtocol
    @Published var allUsers: [User] = []
    
    init(soundManager: SoundManagerProtocol, persistenceManager: PersistenceManagerProtocol) {
        self.soundManager = soundManager
        self.persistenceManager = persistenceManager
        fetchUsers()
    }
    
//    func signOut() {
//        currentUserLogin = nil
//        currentUserAge = nil
//        currentUserGender = nil
//        withAnimation(.spring()) {
//            currentUserSignedIn = false
//        }
//    }
    
    private func fetchUsers() {
        persistenceManager.fetchUsers { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self.allUsers = users
                    print(users)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func playSound() {
        soundManager.playSound()
    }
    func stopSound() {
        soundManager.stopSound()
    }
}
