//
//  CharacterDetailsView.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI

struct CharacterDetailsView: View {
    
    let image: UIImage
    let title: String
    let description: String
    
    var body: some View {
        ReusableDetailsView(viewType: .movie,
                            title: title,
                            description: description,
                            image: image)
    }
}

struct CharacterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailsView(image: UIImage(systemName: "heart.fill")!, title: "Harry Potter", description: "Character description")
    }
}
