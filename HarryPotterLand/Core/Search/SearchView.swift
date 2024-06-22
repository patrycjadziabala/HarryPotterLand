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
                }
                                
                List {
                    charactersSection
                }
            }
        }
    }
}

#Preview {
    SearchView(characters: [])
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
}
