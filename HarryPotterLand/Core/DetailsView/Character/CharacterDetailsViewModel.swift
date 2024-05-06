//
//  ReusableDetailsViewModel.swift
//  HarryPotterLand
//
//  Created by Patka on 13/03/2024.
//

import Foundation

class CharacterDetailsViewModel: ObservableObject {
    
    let model: CharacterModel
    var fandomUrl: String = ""
    
    init(model: CharacterModel) {
        self.model = model
    }
    
    func buildUrlForCharacterFandom(character: CharacterModel) -> String? {
        let baseUrlString = "https://harrypotter.fandom.com/wiki/\(character.name.replacingOccurrences(of: " ", with: "_"))"
        let urlString = baseUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let urlString = urlString else {
            return nil
        }
        return urlString
        fandomUrl = urlString
    }
}
