//
//  HarryPotterLandApp.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI

@main
struct HarryPotterLandApp: App {
    @StateObject var favouritesViewModel = FavouritesViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(favouritesViewModel)
        }
    }
}
