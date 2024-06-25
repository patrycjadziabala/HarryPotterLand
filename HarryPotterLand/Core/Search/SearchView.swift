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
    @State var showCharacters: Bool = true
    
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
                    resultsHeader
                    if showCharacters {
                        charactersSection
                            .transition(.move(edge: showCharacters ? .leading : .trailing))
                    } else {
                        moviesSection
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
    
    private var resultsHeader: some View {
        HStack  {
            Spacer()
            
            Text(showCharacters ? Constants.Titles.titleCharacters : Constants.Titles.titleMovies)
                .withCustomTitleTextFormatting(fontSize: 35, fontType: .titleFont, alignment: .center)
                .foregroundColor(.white)
                .animation(.none, value: showCharacters)
            
            Image(systemName: Constants.Images.arrowRightIcon)
                .resizable()
                .foregroundColor(.white.opacity(0.4))
                .frame(width: 45, height: 45)
                .shadow(
                    color: .black.opacity(0.25),
                    radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 0)
                .rotationEffect(Angle(degrees: showCharacters ? 0 : 180))
                .offset(x: showCharacters ? 0 : -315)
                .onTapGesture {
                    withAnimation(.spring()) {
                        showCharacters.toggle()
                    }
                }
        }
        .frame(height: 100)
        .padding(.horizontal)
    }
    
    private var charactersSection: some View {
        ScrollView {
            ForEach(searchViewModel.filteredCharacters, id: \.id) { character in
                SerachRowView(model: character, imageUrl: character.image)
            }
        }
    }
    
    private var moviesSection: some View {
        ScrollView {
            ForEach(searchViewModel.filteredMovies, id: \.id) { movie in
                SerachRowView(model: movie, imageUrl: "")
            }
        }
    }
}
