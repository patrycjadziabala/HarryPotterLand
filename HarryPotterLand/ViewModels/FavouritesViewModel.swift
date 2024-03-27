//
//  FavouritesViewModel.swift
//  HarryPotterLand
//
//  Created by Patka on 19/03/2024.
//

import Foundation

class FavouritesViewModel: ObservableObject {
    @Published var characters: [String] = [
    "Harry", "Ron", "snape"
    ]
    @Published var movies: [String] = [
    "HP1", "HP5"
    ]
    @Published var favouritesCount: Int = 0 
//    {
//        didSet {
//            countFavourites()
//        }
//    }
    
    init() {
        print(favouritesCount)
        countFavourites()
        print(favouritesCount)
    }
    
    func countFavourites() {
        favouritesCount = characters.count + movies.count
    }
}
