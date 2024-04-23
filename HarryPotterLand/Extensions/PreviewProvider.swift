//
//  PreviewProvider.swift
//  HarryPotterLand
//
//  Created by Patka on 23/04/2024.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init() { }
    
    let character = CharacterModel(
        id: "123",
        name: "Harry Potter",
        alternate_names: ["The Boy Who Lived",
                          "The Chosen One",
                          "Undesirable No. 1",
                          "Potty"],
        species: "Human",
        gender: "male",
        house: "Griffindor",
        dateOfBirth: "31-07-1980",
        wizard: true,
        ancestry: "half-blood",
        eyeColour: "green",
        hairColour: "black",
        wand: WandModel(wood: "holly", core: "phoenix tail feather", length: 11),
        patronus: "stag",
        hogwartsStudent: true,
        hogwartsStaff: false,
        actor: "Daniel Radcliffe",
        alive: true,
        image: "https://ik.imagekit.io/hpapi/harry.jpg"
    )
}
