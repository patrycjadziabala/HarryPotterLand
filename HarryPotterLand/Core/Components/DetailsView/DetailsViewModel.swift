//
//  ReusableDetailsViewModel.swift
//  HarryPotterLand
//
//  Created by Patka on 13/03/2024.
//

import Foundation

class DetailsViewModel: ObservableObject {
    
    var subTitle: String = ""
    let viewType: ViewType = .movieDetails
    let model: CharacterModel
    
    init(subTitle: String, model: CharacterModel) {
        self.subTitle = subTitle
        self.model = model
    }
    
    func getSubTitle(viewType: ViewType) -> String {
        switch viewType {
        case .movieDetails:
            subTitle = Constants.titleCharacters
        case .characterDetails:
            subTitle = Constants.titleMoviesCollection
        }
        return subTitle
    }
}
