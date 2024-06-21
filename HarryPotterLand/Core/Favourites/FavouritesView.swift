//
//  FavouritesView.swift
//  HarryPotterLand
//
//  Created by Patka on 18/03/2024.
//

import SwiftUI

struct FavouritesView: View {
    
    @EnvironmentObject private var favouritesManager: FavouritesManager
    
    var body: some View {
        ZStack {
            
            if favouritesManager.characters.isEmpty && favouritesManager.movies.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List {
                    charactersSection
                    moviesSection
                }
                .listStyle(SidebarListStyle())
            }
            Background()
                .opacity(0.5)
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
            .environmentObject(FavouritesManager(hapticsManager: HapticsManager()))
    }
}

extension FavouritesView {
    
    private var charactersSection: some View {
        Section {
            ForEach(favouritesManager.characters, id: \.self) { character in
                Text(character.capitalized)
            }
            .onDelete(perform: deleteCharacter)
        } header: {
            Text(Constants.Titles.titleCharacters)
        }
    }
    
    private var moviesSection: some View {
        Section {
            ForEach(favouritesManager.movies, id: \.self) { movie in
                Text(movie)
            }
            .onDelete(perform: deleteMovie)
        } header: {
            Text(Constants.Titles.titleMovies)
        }
    }
    
    // MARK: - Functions
    
    func deleteCharacter(indexSet: IndexSet) {
        favouritesManager.characters.remove(atOffsets: indexSet)
    }
    
    func deleteMovie(indexSet: IndexSet) {
        favouritesManager.movies.remove(atOffsets: indexSet)
    }
}
