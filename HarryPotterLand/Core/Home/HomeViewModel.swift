//
//  HomeViewModel.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import Foundation

// TODO: - write unit tests
@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var imageData: Data? = nil
    @Published var characters: [Character] = []
    @Published var movies: [Movie] = []
    
    let imageLoader: ImageLoaderManagerProtocol
    let apiManager: APIManagerProtocol
    
    init(imageLoader: ImageLoaderManagerProtocol, apiManager: APIManagerProtocol) {
        self.imageLoader = imageLoader
        self.apiManager = apiManager
    }
    
    func fetchHogwartsCastleImage() async {
        let image = try? await imageLoader.fetchHogwartsCastleImage()
        self.imageData = image?.pngData()
    }
    
    func fetchCharacters() async throws {
        guard let downloadedData: [Character] = try await apiManager.fetchCharactersFromHpAPI() else {
            return
        }
        characters = downloadedData
    }
    
    func fetchMovieDetails() async throws {
        var allMovies: [Movie] = []
        for id in Constants.HPid.allIds {
            if let movie = try await apiManager.fetchData(endpoint: .movie, id: id) as [Movie]? {
                allMovies.append(contentsOf: movie)
            }
        }
        self.movies = allMovies
    }
}

