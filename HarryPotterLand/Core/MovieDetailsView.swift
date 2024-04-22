//
//  MovieDetailsView.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    
    let image: UIImage
    let title: String
    let description: String
    
    var body: some View {
        DetailsView(viewType: .movieDetails,
                            title: title,
                            description: description,
                            image: image)
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(image: UIImage(systemName: "heart.fill")!, title: "Harry Potter", description: "Movie description")
    }
}
