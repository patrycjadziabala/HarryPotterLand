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
            // TODO: - fix double navigation bar (when entering character details there are two at the top)
 
                WelcomeView(welcomeViewModel: WelcomeViewModel(soundManager: SoundManager()))
     
//            MainTabView(homeViewModel: HomeViewModel(imageLoader: ImageLoaderManager(), apiManager: APIManager()))
                .environmentObject(favouritesManager)
        }
    }
}
