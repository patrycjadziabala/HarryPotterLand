//
//  SearchViewModel.swift
//  HarryPotterLand
//
//  Created by Patka on 21/06/2024.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var filteredCharacters: [CharacterModel] = []
    @Published var filteredMovies: [MovieModel] = []
    
    var allCharacters: [CharacterModel]
    var allMovies: [MovieModel]
    
    init(allCharacters: [CharacterModel], allMovies: [MovieModel]) {
        self.allCharacters = allCharacters
        self.allMovies = allMovies
    }
    
    func filterResults() {
        filterCharacters()
        filterMovies()
    }
    
    func filterCharacters() {
        filteredCharacters = allCharacters.filter( {$0.name.localizedCaseInsensitiveContains(searchText)} )
    }
    
    func filterMovies() {
        filteredMovies = allMovies.filter { movie in
            if let title = movie.originalTitle {
                return title.localizedCaseInsensitiveContains(searchText)
            }
            return false
        }
    }
}

