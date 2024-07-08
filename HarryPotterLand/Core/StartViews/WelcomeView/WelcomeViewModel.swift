//
//  WelcomeViewMdoel.swift
//  HarryPotterLand
//
//  Created by Patka on 29/06/2024.
//

import Foundation

class WelcomeViewModel: ObservableObject {
    var soundManager: SoundManagerProtocol
    
    init(soundManager: SoundManagerProtocol) {
        self.soundManager = soundManager
    }
}
