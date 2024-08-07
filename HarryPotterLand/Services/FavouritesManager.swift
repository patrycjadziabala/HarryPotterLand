//
//  FavouritesManager.swift
//  HarryPotterLand
//
//  Created by Patka on 19/03/2024.
//

import Foundation

class FavouritesManager: ObservableObject {
    
    // TODO: - it
    @Published var characters: [String] = [
    "Harry", "Ron", "snape"
    ]
    @Published var movies: [String] = [
    "HP1", "HP5"
    ]
    @Published var favouritesCount: Int = 0
    private var hapticsManager: HapticsManagerProtocol
    
//    {
//        didSet {
//            countFavourites()
//        }
//    }
    
    init(hapticsManager: HapticsManagerProtocol) {
        self.hapticsManager = hapticsManager
//        print(favouritesCount)
        countFavourites()
//        print(favouritesCount)
    }
    
    func countFavourites() {
        favouritesCount = characters.count + movies.count
    }
    
    func addToFavourites() {
        hapticsManager.notification(type: .success)
    }
    
    func removeFromFavourites() {
        hapticsManager.notification(type: .error)
    }
}
