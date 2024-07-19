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
    @StateObject private var userManager = UserManager()
    
    var body: some Scene {
        WindowGroup {
            WelcomeView(welcomeViewModel: WelcomeViewModel(soundManager: SoundManager(), persistenceManager: PersistenceManager()))
     
//            MainTabView(homeViewModel: HomeViewModel(imageLoader: ImageLoaderManager(), apiManager: APIManager()))
                .environmentObject(favouritesManager)
                .environmentObject(userManager)
        }
    }
}
