//
//  ReusableDetailsViewModel.swift
//  HarryPotterLand
//
//  Created by Patka on 13/03/2024.
//

import Foundation

class DetailsViewModel: ObservableObject {
    
    @Published var viewType: ViewType = .movieDetails
    let model: CharacterModel
    
    init(model: CharacterModel) {
        self.model = model
    }
}
