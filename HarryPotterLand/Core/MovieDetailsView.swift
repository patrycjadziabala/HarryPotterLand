//
//  MovieDetailsView.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    
    let image: String
    let title: String
    let description: String
    
    var body: some View {
        Text("Text")
//        DetailsView(viewType: .movieDetails,
//                            title: title,
//                            description: description,
//                            image: image)
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(image: dev.character.image, title: dev.character.name, description: dev.character.house)
    }
}
