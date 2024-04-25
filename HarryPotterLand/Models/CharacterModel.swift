//
//  CharacterModel.swift
//  HarryPotterLand
//
//  Created by Patka on 06/04/2024.
//

import Foundation

struct CharacterModel: Identifiable, Codable {
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
    let wand: WandModel
    let patronus: String
    let hogwartsStudent: Bool
    let hogwartsStaff: Bool
    let actor: String
    let alive: Bool
    let image: String
    var houseLogo: String {
        "logo\(house.capitalized)"
    }
}
struct WandModel: Codable {
    let wood: String
    let core: String
    let length: Double?
}
