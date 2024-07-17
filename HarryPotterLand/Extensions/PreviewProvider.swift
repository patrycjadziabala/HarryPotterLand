//
//  PreviewProvider.swift
//  HarryPotterLand
//
//  Created by Patka on 23/04/2024.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init() { }
        
    let character = Character(
        id: "123",
        name: "Harry Potter",
        alternate_names: ["The Boy Who Lived",
                          "The Chosen One",
                          "Undesirable No. 1",
                          "Potty"],
        species: "Human",
        gender: "male",
        house: "Griffindor",
        dateOfBirth: "31-07-1980",
        wizard: true,
        ancestry: "half-blood",
        eyeColour: "green",
        hairColour: "black",
        wand: Wand(wood: "holly", core: "phoenix tail feather", length: 11),
        patronus: "stag",
        hogwartsStudent: true,
        hogwartsStaff: false,
        actor: "Daniel Radcliffe",
        alive: true,
        image: "https://ik.imagekit.io/hpapi/harry.jpg"
    )
    
    let movie = Movie(
        backdropPath: "/xJHokMbljvjADYdit5fK5VQsXEG.jpg",
        budget: 165000000,
        genres: [],
        homepage: "http://www.interstellarmovie.net/",
        id: 123,
        imdbID: "4567",
        originCountry: [],
        originalLanguage: "en",
        originalTitle: "Interstellar",
        overview: "The adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel and conquer the vast distances involved in an interstellar voyage.",
        popularity: 388.876,
        posterPath: "/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg",
        releaseDate: "2014-11-05",
        revenue: 701729206,
        runtime: 169,
        spokenLanguages: [],
        status: "Released",
        tagline: "Mankind was born on Earth. It was never meant to die here.",
        title: "Interstellar",
        video: false,
        voteAverage: 8.433,
        voteCount: 34189
    )
}
