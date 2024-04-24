//
//  HarryPotterLandApp.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI

@main
struct HarryPotterLandApp: App {
    @StateObject private var favouritesViewModel = FavouritesViewModel()
    @StateObject private var homeViewModel = HomeViewModel()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(favouritesViewModel)
                .environmentObject(homeViewModel)
        }
    }
}
