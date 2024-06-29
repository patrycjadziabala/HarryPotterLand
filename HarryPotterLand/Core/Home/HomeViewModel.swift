//
//  HomeViewModel.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import Foundation
import SwiftUI

// TODO: - write unit tests
// TODO: - review other view models for properties that should be injected
@MainActor
class HomeViewModel: ObservableObject {
    
    // TODO: - think if we could remove UIImage reference from view model and remove import SwiftUI so that viewmodel doesn't know about views
    @Published var image: UIImage? = nil
    let imageLoader: ImageLoaderManager
    var apiManager: APIManagerProtocol
    @Published var characters: [CharacterModel] = []
    @Published var movies: [MovieModel] = []
    
    init(imageLoader: ImageLoaderManager, apiManager: APIManagerProtocol) {
        self.imageLoader = imageLoader
        self.apiManager = apiManager
    }
    
    func fetchHogwartsCastleImage() async {
        // TODO: - check if this is right thing to do
        let image = try? await imageLoader.fetchHogwartsCastleImage()
        await MainActor.run {
            self.image = image
        }
    }
    
    func fetchCharacters() async throws {
        guard let downloadedData: [CharacterModel] = try await apiManager.fetchCharactersFromHpAPI() else {
            return
        }
        characters = downloadedData
    }
    
    func fetchMovieDetails() async throws {
        /* TODO: - use for loop to fetch those:
         use Constants.HPid.allIds (add the missing ones)
         for id in ids { try await fetch data and then append }
        */
        guard let downloadedData1: [MovieModel] = try await apiManager.fetchData(endpoint: .movie, id: Constants.HPid.idHP1),
              let downloadedData2: [MovieModel] = try await apiManager.fetchData(endpoint: .movie, id: Constants.HPid.idHP2),
              let downloadedData3: [MovieModel] = try await apiManager.fetchData(endpoint: .movie, id: Constants.HPid.idHP3),
              let downloadedData4: [MovieModel] = try await apiManager.fetchData(endpoint: .movie, id: Constants.HPid.idHP4),
              let downloadedData5: [MovieModel] = try await apiManager.fetchData(endpoint: .movie, id: Constants.HPid.idHP5),
              let downloadedData6: [MovieModel] = try await apiManager.fetchData(endpoint: .movie, id: Constants.HPid.idHP6),
              let downloadedData7: [MovieModel] = try await apiManager.fetchData(endpoint: .movie, id: Constants.HPid.idHP7),
              let downloadedData8: [MovieModel] = try await apiManager.fetchData(endpoint: .movie, id: Constants.HPid.idHP8)
        else {
            return
        }
        movies.append(contentsOf: downloadedData1)
        movies.append(contentsOf: downloadedData2)
        movies.append(contentsOf: downloadedData3)
        movies.append(contentsOf: downloadedData4)
        movies.append(contentsOf: downloadedData5)
        movies.append(contentsOf: downloadedData6)
        movies.append(contentsOf: downloadedData7)
        movies.append(contentsOf: downloadedData8)
    }
}

