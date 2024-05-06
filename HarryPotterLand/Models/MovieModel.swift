//
//  MovieModel.swift
//  HarryPotterLand
//
//  Created by Patka on 29/04/2024.
//

import Foundation

struct MovieModel: Codable {
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
}

struct Genre: Codable {
    let id: Int?
    let name: String?
}

struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String?
}
