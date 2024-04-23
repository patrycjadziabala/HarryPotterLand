//
//  CharacterDetailsView.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI

struct CharacterDetailsView: View {
    
    let image: String
    let title: String
    let description: String
    
    var body: some View {
        Text("Text")
//        DetailsView(viewType: .characterDetails,
//                            title: title,
//                            description: description,
//                            image: image)
    }
}

struct CharacterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailsView(image: dev.character.image, title: dev.character.name, description: dev.character.house)
    }
}
