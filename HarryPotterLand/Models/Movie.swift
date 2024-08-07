//
//  Movie.swift
//  HarryPotterLand
//
//  Created by Patka on 29/04/2024.
//

import Foundation

struct Movie: Codable {
    let backdropPath: String?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let id: Int?
    let imdbID: String?
    let originCountry: [String]?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension Movie: DetailCollectionCellProtocol {
    var collectionImageUrl: String {
        posterPath ?? ""
    }
    
    var collectionViewId: String {
        String(id ?? 0)
    }
    
    var collectionViewTitle: String {
        originalTitle ?? ""
    }
    
    var collectionViewDetails: String {
        releaseDate ?? ""
    }
    
    var collectionViewCellType: CellContentType {
        .title
    }
}

struct Genre: Codable, Identifiable {
    let id: Int?
    let name: String?
}

struct SpokenLanguage: Codable {
    let englishName, short, name: String?
    
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case short = "iso_639_1"
        case name
    }
}
