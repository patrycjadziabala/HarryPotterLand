//
//  ReusableDetailsViewModel.swift
//  HarryPotterLand
//
//  Created by Patka on 13/03/2024.
//

import Foundation

class CharacterDetailsViewModel: ObservableObject {
    
    let model: CharacterModel
    var apiManager: APIManagerProtocol = APIManager()
    @Published var actorInMovies: [Cast] = []
    
    init(model: CharacterModel) {
        self.model = model
    }
    
    func buildUrlForCharacterFandom(character: CharacterModel) -> String? {
        let baseUrlString = "https://harrypotter.fandom.com/wiki/\(character.name.replacingOccurrences(of: " ", with: "_"))"
        let urlString = baseUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let urlString = urlString else {
            return nil
        }
        return urlString
    }
    
    func getActorId(model: CharacterModel) async throws -> Int? {
        guard let downloadedData: Results = try await apiManager.fetchData(url: nil, endpoint: .search, queryType: .person, query: model.actor, actorId: nil) else {
            return nil
        }
        return downloadedData.results?.first?.id ?? 0
    }
    
    func fetchActorMovieList(actorId: Int) async throws -> [Cast]? {
        guard let downloadedData: ActorInMoviesModel = try await apiManager.fetchData(url: nil, endpoint: nil, queryType: nil, query: nil, actorId: String(actorId)) else {
            return nil
        }
        return downloadedData.cast
    }
    
    func getHarryPotterMoviesForActor() async throws {
        guard let actorId = try await getActorId(model: model) else {
            return
        }
        let actorMoviesArray = try await fetchActorMovieList(actorId: actorId)
        let filteredArray = actorMoviesArray?.filter { $0.originalTitle.contains("Potter") == true }
        print(filteredArray?.count ?? 0)
        await MainActor.run {
            actorInMovies = filteredArray?.sorted(by: { $0.id < $1.id }) ?? [] }
    }
    
    func getImageUrlFromTMBD(model: Cast?, imageSize: Int) -> String? {
        let url =  "https://image.tmdb.org/t/p/w\(imageSize)\(model?.posterPath ?? "")"
        return url
    }
}

