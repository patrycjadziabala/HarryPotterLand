//
//  ActorInMovies.swift
//  HarryPotterLand
//
//  Created by Patka on 13/05/2024.
//

import Foundation

struct ActorInMovies: Codable {
    let cast: [Cast]
    let id: Int
}

struct Cast: Codable, Identifiable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: OriginalLanguage
    let originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate, title: String
    let voteAverage: Double
    let voteCount: Int
    let character: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case character
        case order
    }
}

extension Cast: DetailCollectionCellProtocol {
    var collectionImageUrl: String {
        posterPath ?? ""
    }
    
    var collectionViewId: String {
        String(id)
    }
    
    var collectionViewTitle: String {
        originalTitle
    }
    
    var collectionViewDetails: String {
        releaseDate
    }
    
    var collectionViewCellType: CellContentType {
        .title
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
}
