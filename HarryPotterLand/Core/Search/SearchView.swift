//
//  SearchView.swift
//  HarryPotterLand
//
//  Created by Patka on 21/06/2024.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var searchViewModel = SearchViewModel()
    @State var characters: [CharacterModel]
    @State var movies: [MovieModel]
    
    var body: some View {
        ZStack {
            Background()
            VStack {
                Text(Constants.Titles.searchForYourFavouriteCharactersOrMovies)
                    .withCustomTitleTextFormatting(fontSize: 40 ,fontType: .textFont)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .shadow(radius: 10)
                SearchBarView(searchText: $searchViewModel.searchText) {
                    searchViewModel.filterResults(characters: characters)
                    searchViewModel.filterResults(movies: movies)
                }
                if !searchViewModel.searchText.isEmpty {
                    ScrollView {
                        charactersSection
                    }
                }
            }
        }
    }
}

#Preview {
    SearchView(characters: [], movies: [])
}

extension SearchView {
    
    private var charactersSection: some View {
        Section {
            ForEach(searchViewModel.filteredCharacters, id: \.id) { character in
                SerachRowView(model: character, imageUrl: character.image)
            }
        } header: {
            Text(Constants.Titles.titleCharacters)
                .withCustomTitleTextFormatting(fontType: .titleFont)
        }
    }
    
    private var moviesSection: some View {
        ForEach(searchViewModel.filteredMovies, id: \.id) { movie in
            SerachRowView(model: movie, imageUrl: "")
            }
    }
}
