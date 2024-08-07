//
//  ReusableDetailsViewModel.swift
//  HarryPotterLand
//
//  Created by Patka on 13/03/2024.
//

import Foundation

class CharacterDetailsViewModel: ObservableObject {
    
    let model: Character
    var apiManager: APIManagerProtocol
    @Published var actorInMovies: [Cast] = []
    
    init(model: Character, apiManager: APIManagerProtocol) {
        self.model = model
        self.apiManager = apiManager
    }
    
    func buildUrlForCharacterFandom(character: Character) -> String? {
        let baseUrlString = "https://harrypotter.fandom.com/wiki/\(character.name.replacingOccurrences(of: " ", with: "_"))"
        let urlString = baseUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return urlString
    }
    
    func getActorId(model: Character) async throws -> Int? {
        guard let downloadedData: Results = try await apiManager.fetchData(
            url: nil,
            endpoint: .search,
            queryType: .person,
            query: model.actor,
            actorId: nil
        ) else {
            return nil
        }
        return downloadedData.results?.first?.id
    }
    
    func fetchActorMovieList(actorId: Int) async throws -> [Cast]? {
        guard let downloadedData: ActorInMovies = try await apiManager.fetchData(
            url: nil,
            endpoint: nil,
            queryType: nil,
            query: nil,
            actorId: String(
                actorId
            )
        ) else {
            return nil
        }
        return downloadedData.cast
    }
    
    func getHarryPotterMoviesForActor() async throws {
        guard let actorId = try await getActorId(model: model) else {
            return
        }
        let actorMoviesArray = try await fetchActorMovieList(actorId: actorId)
        let filteredArray = actorMoviesArray?.filter { $0.originalTitle.contains("Potter") }
        await MainActor.run {
            actorInMovies = filteredArray?.sorted(by: { $0.id < $1.id }) ?? [] }
    }
}

