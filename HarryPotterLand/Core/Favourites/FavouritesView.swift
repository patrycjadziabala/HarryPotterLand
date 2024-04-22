//
//  FavouritesView.swift
//  HarryPotterLand
//
//  Created by Patka on 18/03/2024.
//

import SwiftUI

struct FavouritesView: View {
    
    @StateObject private var favouritesViewModel = FavouritesViewModel()
    
    var body: some View {
        ZStack {
            if favouritesViewModel.characters.isEmpty && favouritesViewModel.movies.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List {
                    Section {
                        ForEach(favouritesViewModel.characters, id: \.self) { character in
                            Text(character.capitalized)
                        }
                        .onDelete(perform: deleteCharacter)
                    } header: {
                        Text("Characters")
                    }
                    Section {
                        ForEach(favouritesViewModel.movies, id: \.self) { movie in
                            Text(movie)
                        }
                        .onDelete(perform: deleteMovie)
                    } header: {
                        Text("Movies")
                    }
                }
                .listStyle(SidebarListStyle())
            }
        }
    }
    
    func deleteCharacter(indexSet: IndexSet) {
        favouritesViewModel.characters.remove(atOffsets: indexSet)
    }
    
    func deleteMovie(indexSet: IndexSet) {
        favouritesViewModel.movies.remove(atOffsets: indexSet)
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
