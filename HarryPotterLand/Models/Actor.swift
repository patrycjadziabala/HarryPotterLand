//
//  Actor.swift
//  HarryPotterLand
//
//  Created by Patka on 09/05/2024.
//

import Foundation

struct Results: Codable {
    let results: [Actor]?
}

struct Actor: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownForDepartment, name, originalName: String?
    let popularity: Double?
    let profilePath: String?
    let knownFor: [KnownFor]?
    
    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case knownFor = "known_for"
    }
}

struct KnownFor: Codable {
    let id: Int?
    let originalTitle: String?
    let title: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case originalTitle = "original_title"
    }
}
