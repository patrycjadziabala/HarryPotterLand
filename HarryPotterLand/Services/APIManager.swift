//
//  APIManager.swift
//  HarryPotterLand
//
//  Created by Patka on 06/04/2024.
//

import Foundation

protocol APIManagerProtocol {
    func fetchData<T: Codable>(endpoint: Endpoint, id: String?) async throws -> [T]?
    func fetchData<T: Codable>(url: String?, endpoint: Endpoint?, queryType: QueryType?, query: String?, actorId: String?) async throws -> T?
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
    case search
    case movie_credits
}

enum QueryType: String {
    case person
}

class APIManager: APIManagerProtocol {
    
    // TODO: - extract apikey to constants
    // URLs
    let tMDBbURLString: String = "https://api.themoviedb.org/3/<endpoint>/<id>?api_key=29d1eac12ae7da1b5df0ba13aca09837"
    let tMDBbSearchURLString: String = "https://api.themoviedb.org/3/<endpoint>/<queryType>?query=<query>&api_key=29d1eac12ae7da1b5df0ba13aca09837"
    let personMovieCreditsUrlString = "https://api.themoviedb.org/3/person/<actorId>/movie_credits?api_key=29d1eac12ae7da1b5df0ba13aca09837"
    
    private func buildUrlStringForTMDB(for endpoint: Endpoint, id: String?) -> String? {
        let urlString = tMDBbURLString
            .replacingOccurrences(of: "<endpoint>", with: endpoint.rawValue)
            .replacingOccurrences(of: "<id>", with: id ?? "")
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return urlString
    }
    
    private func buildUrlStringForTMDB(for endpoint: Endpoint) -> String? {
        let urlString = tMDBbURLString
            .replacingOccurrences(of: "<endpoint>", with: endpoint.rawValue)
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let urlString = urlString else {
            return nil
        }
        return urlString
    }
    
    private func buildUrlStringForTMDB(for endpoint: Endpoint, queryType: QueryType, query: String?) -> String? {
        let urlString = tMDBbSearchURLString
            .replacingOccurrences(of: "<endpoint>", with: endpoint.rawValue)
            .replacingOccurrences(of: "<queryType>", with: queryType.rawValue)
            .replacingOccurrences(of: "<query>", with: query ?? "")
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let urlString = urlString else {
            return nil
        }
        return urlString
    }
    
    private func buildUrlStringForTMDB(actorId: String?) -> String? {
        let urlString = personMovieCreditsUrlString
            .replacingOccurrences(of: "<actorId>", with: actorId ?? "")
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
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
    
    func fetchData<T: Codable>(url: String?, endpoint: Endpoint?, queryType: QueryType?, query: String?, actorId: String?) async throws -> T? {
        let urlString: String
        
        if let endpoint = endpoint,
           let query = query,
           let queryType = queryType {
            guard let url = buildUrlStringForTMDB(
                for: endpoint,
                queryType: queryType,
                query: query
            ) else {
                throw NetworkError.invalidURL
            }
            urlString = url
        } else if let actorId = actorId {
            guard let url = buildUrlStringForTMDB(actorId: actorId) else {
                throw NetworkError.invalidURL
            }
            urlString = url
        } else {
            if let url = url {
                urlString = url
            } else {
                throw NetworkError.invalidURL
            }
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
