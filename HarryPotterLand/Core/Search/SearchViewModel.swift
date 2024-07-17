//
//  SearchViewModel.swift
//  HarryPotterLand
//
//  Created by Patka on 21/06/2024.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var filteredCharacters: [Character] = []
    @Published var filteredMovies: [Movie] = []
    
    var allCharacters: [Character]
    var allMovies: [Movie]
    
    init(allCharacters: [Character], allMovies: [Movie]) {
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

