//
//  HarryPotterLandApp.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI

@main
struct HarryPotterLandApp: App {
    
    @StateObject private var favouritesManager = FavouritesManager(hapticsManager: HapticsManager())
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(favouritesManager)
        }
    }
}
