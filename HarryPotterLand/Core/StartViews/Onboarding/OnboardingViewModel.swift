//
//  OnboardingViewModel.swift
//  HarryPotterLand
//
//  Created by Patka on 08/07/2024.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    
    let notificationManager: NotificationManagerProtocol
    
    init(notificationManager: NotificationManagerProtocol) {
        self.notificationManager = notificationManager
    }
    
    func requestAutorisationForNotifications() {
        notificationManager.requestAuthorisation()
    }
}
