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
                SearchBarView(searchText: $searchViewModel.searchText)
                
                Text(characters.first?.name ?? "Nie ma")
            }
        }
    }
}

#Preview {
    SearchView(characters: [])
        .previewLayout(.sizeThatFits)
}
