//
//  FavouritesView.swift
//  HarryPotterLand
//
//  Created by Patka on 18/03/2024.
//

import SwiftUI

struct FavouritesView: View {
    
    @State var characters: [String] = [
    "Harry", "Ron", "snape"
    ]
    
    @State var movies: [String] = [
    "HP1", "HP5"
    ]
    
    var body: some View {
        List {
            Section {
                ForEach(characters, id: \.self) { character in
                    Text(character.capitalized)
                }
                .onDelete(perform: deleteCharacter)
            } header: {
                Text("Characters")
            }
            Section {
                ForEach(movies, id: \.self) { movie in
                    Text(movie)
                }
                .onDelete(perform: deleteMovie)
            } header: {
                Text("Movies")
            }
        }
        .listStyle(SidebarListStyle())
    }
    
    func deleteCharacter(indexSet: IndexSet) {
        characters.remove(atOffsets: indexSet)
    }
    
    func deleteMovie(indexSet: IndexSet) {
        movies.remove(atOffsets: indexSet)
    }
    
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
