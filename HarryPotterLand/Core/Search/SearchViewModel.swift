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
    
    func filterResults(characters: [CharacterModel]) {
        filteredCharacters = characters.filter( {$0.name.contains(searchText)} )
    }
    
    func filterResults(movies: [MovieModel]) {
        filteredMovies = movies.filter { movie in
            if let title = movie.originalTitle {
                return title.contains(searchText)
            }
            return false
        }
    }
    
    func getImageUrlFromTMBD(model: DetailCollectionViewProtocol?, imageSize: Int) -> String? {
        let url =  "https://image.tmdb.org/t/p/w\(imageSize)/\(model?.collectionImageUrl ?? "")"
        return url
    }
}

