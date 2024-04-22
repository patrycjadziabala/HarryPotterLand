//
//  APIManager.swift
//  HarryPotterLand
//
//  Created by Patka on 06/04/2024.
//

import Foundation

protocol APIManagerProtocol {
    func fetchCharacters() async throws -> [CharacterModel]?
}

enum NetworkError: Error {
    case invalidURL
    case invalidRequest
    case badStatus
    case badResponse
    case failedToDecodeResponse
}

class APIManager: APIManagerProtocol {
    
    func fetchCharacters() async throws -> [CharacterModel]? {
        guard let url = URL(string: "https://hp-api.onrender.com/api/characters") else {
            throw NetworkError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.badResponse
        }
        guard response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkError.badStatus
        }
        guard let decodedResponse = try? JSONDecoder().decode([CharacterModel].self, from: data) else {
            throw NetworkError.failedToDecodeResponse
        }
        return decodedResponse
    }
}
