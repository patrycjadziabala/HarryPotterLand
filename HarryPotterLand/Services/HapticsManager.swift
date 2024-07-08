//
//  HapticsManager.swift
//  HarryPotterLand
//
//  Created by Patka on 05/04/2024.
//

import SwiftUI

// implement impact func when testing on physical device

protocol HapticsManagerProtocol {
    func notification(type: UINotificationFeedbackGenerator.FeedbackType)
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle)
}

class HapticsManager: HapticsManagerProtocol {
        
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
