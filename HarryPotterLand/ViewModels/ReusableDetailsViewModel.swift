//
//  ReusableDetailsViewModel.swift
//  HarryPotterLand
//
//  Created by Patka on 13/03/2024.
//

import Foundation

class ReusableDetailsViewModel: ObservableObject {
    let subTitle: String? = nil
    let viewType: ViewType = .movieDetails
    
    func getSubTitle(viewType: ViewType) -> String? {
        switch viewType {
        case .movieDetails:
            let subTitle = Constants.titleCharacters
        case .characterDetails:
            let subTitle = Constants.titleMoviesCollection
        }
        return subTitle ?? nil
    }
}
