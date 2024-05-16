//
//  MovieDetailsViewModel.swift
//  HarryPotterLand
//
//  Created by Patka on 02/05/2024.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    
    let model: DetailCollectionViewProtocol
    
    init(model: DetailCollectionViewProtocol) {
        self.model = model
    }
    
    func getImageUrlFromTMBD(model: DetailCollectionViewProtocol?, imageSize: Int) -> String? {
        let url =  "https://image.tmdb.org/t/p/w\(imageSize)/\(model?.collectionImageUrl ?? "")"
        return url
    }
}
