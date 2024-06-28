//
//  String + imageUrlString.swift
//  HarryPotterLand
//
//  Created by Patka on 28/06/2024.
//

import Foundation

extension String {
    static func buildImageUrlString(from model: DetailCollectionViewProtocol, imageSize: Int) -> Self {
        "https://image.tmdb.org/t/p/w\(imageSize)/\(model.collectionImageUrl)"
    }
}
