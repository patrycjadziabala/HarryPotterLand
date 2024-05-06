//
//  APIManager.swift
//  HarryPotterLand
//
//  Created by Patka on 06/04/2024.
//

import Foundation

protocol APIManagerProtocol {
    func fetchData<T: Codable>(endpoint: Endpoint, id: String?) async throws -> [T]?
    func fetchData<T: Codable>(url: String) async throws -> T?
    func fetchCharactersFromHpAPI() async throws -> [CharacterModel]?
}

enum NetworkError: Error {
    case invalidURL
    case invalidRequest
    case badStatus
    case badResponse
    case failedToDecodeResponse
}

enum Endpoint: String {
    case movie
    case person
}

class APIManager: APIManagerProtocol {
    
    // URLs
    let tMDBbURLString: String = "https://api.themoviedb.org/3/<endpoint>/<id>?api_key=29d1eac12ae7da1b5df0ba13aca09837"
    
    /*
     https://api.themoviedb.org/3/movie/672?api_key=29d1eac12ae7da1b5df0ba13aca09837
     https://api.themoviedb.org/3/movie/157336/videos?api_key=29d1eac12ae7da1b5df0ba13aca09837
     */
    
    private func buildUrlStringForTMDB(for endpoint: Endpoint, id: String?) -> String? {
        let urlString = tMDBbURLString.replacingOccurrences(of: "<endpoint>", with: endpoint.rawValue)
            .replacingOccurrences(of: "<id>", with: id ?? "")
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let urlString = urlString else {
            return nil
        }
        return urlString
    }
    
    private func buildUrlStringForTMDB(for endpoint: Endpoint) -> String? {
        let urlString = tMDBbURLString.replacingOccurrences(of: "<endpoint>", with: endpoint.rawValue)
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let urlString = urlString else {
            return nil
        }
        return urlString
    }
    
    // TMDB-API
  
    func fetchData<T: Codable>(endpoint: Endpoint, id: String?) async throws -> [T]? {
        let urlString: String
        if let id = id {
            guard let url = buildUrlStringForTMDB(for: endpoint, id: id) else {
                throw NetworkError.invalidURL
            }
            urlString = url
        } else {
            guard let url = buildUrlStringForTMDB(for: endpoint) else {
                throw NetworkError.invalidURL
            }
            urlString = url
        }
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.badResponse
        }
        guard response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkError.badStatus
        }
        guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.failedToDecodeResponse
        }
        return [decodedResponse]
    }
    
    func fetchData<T: Codable>(url: String) async throws -> T? {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.badResponse
        }
        guard response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkError.badStatus
        }
        guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkError.failedToDecodeResponse
        }
        return decodedResponse
    }
    
    // HP-API
    func fetchCharactersFromHpAPI() async throws -> [CharacterModel]? {
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
