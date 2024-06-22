//
//  SearchViewModel.swift
//  HarryPotterLand
//
//  Created by Patka on 21/06/2024.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    @Published var searchText: String = ""
//    @Published var characters: [CharacterModel]
    @Published var filteredCharacters: [CharacterModel] = []
    
//    init(characters: [CharacterModel]) {
//        self.characters = characters
//    }
    
    func filterResults(characters: [CharacterModel]) {
        filteredCharacters = characters.filter( {$0.name.contains(searchText)} )
    }
}

