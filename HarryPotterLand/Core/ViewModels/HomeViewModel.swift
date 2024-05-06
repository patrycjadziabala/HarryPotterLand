//
//  HomeViewModel.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import Foundation
import SwiftUI

@MainActor class HomeViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let imageLoader = ImageLoaderManager()
    var apiManager: APIManagerProtocol = APIManager()
    @Published var characters: [CharacterModel] = []
    @Published var movies: [MovieModel] = []
    
    func fetchHogwartsCastleImage() async {
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
        guard let downloadedData1: [MovieModel] = try await apiManager.fetchData(endpoint: .movie, id: Constants.idHP1),
              let downloadedData2: [MovieModel] = try await apiManager.fetchData(endpoint: .movie, id: Constants.idHP2),
              let downloadedData3: [MovieModel] = try await apiManager.fetchData(endpoint: .movie, id: Constants.idHP3)
        else {
            return
        }
        movies.append(contentsOf: downloadedData1)
        movies.append(contentsOf: downloadedData2)
        movies.append(contentsOf: downloadedData3)
    }
}
