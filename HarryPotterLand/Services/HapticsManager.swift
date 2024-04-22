//
//  HapticsManager.swift
//  HarryPotterLand
//
//  Created by Patka on 05/04/2024.
//

import SwiftUI

class HapticsManager {
    
    static let instance = HapticsManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
