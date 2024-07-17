//
//  Character.swift
//  HarryPotterLand
//
//  Created by Patka on 06/04/2024.
//

import Foundation

struct Character: Identifiable, Codable {
    let id: String
    let name: String
    let alternate_names: [String]
    let species: String
    let gender: String
    let house: String
    let dateOfBirth: String?
    let wizard: Bool
    let ancestry: String
    let eyeColour: String
    let hairColour: String
    let wand: Wand
    let patronus: String
    let hogwartsStudent: Bool
    let hogwartsStaff: Bool
    let actor: String
    let alive: Bool
    let image: String
    var houseLogo: String {
        "logo\(house.capitalized)"
    }
    var webFandom: String {
        "https://harrypotter.fandom.com/wiki/\(String(describing: name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?.components(separatedBy: "_")))"
    }
}

extension Character: DetailCollectionCellProtocol {
    var collectionImageUrl: String {
        image
    }
    
    var collectionViewId: String {
        id
    }
    
    var collectionViewTitle: String {
        name
    }
    
    var collectionViewDetails: String {
        house
    }
    
    var collectionViewCellType: CellContentType {
        .name
    }
}

struct Wand: Codable {
    let wood: String
    let core: String
    let length: Double?
}
