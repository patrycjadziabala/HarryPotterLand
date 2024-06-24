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
                    ZStack {
//                        List {
//                            charactersSection
//                        }
                        List {
                            moviesSection
                        }
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
                Text(character.name)
            }
        } header: {
            Text(Constants.Titles.titleCharacters)
        }
    }
    
    private var moviesSection: some View {
        Section {
            ForEach(searchViewModel.filteredMovies, id: \.id) { movie in
                if let title = movie.originalTitle {
                    Text(title)
                }
            }
        } header: {
            Text(Constants.Titles.titleMovies)
        }
    }
}
