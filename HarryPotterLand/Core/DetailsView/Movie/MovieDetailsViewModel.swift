//
//  MovieDetailsViewModel.swift
//  HarryPotterLand
//
//  Created by Patka on 02/05/2024.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    
    let model: DetailCollectionCellProtocol
    
    init(model: DetailCollectionCellProtocol) {
        self.model = model
    }
}
