//
//  SearchView.swift
//  HarryPotterLand
//
//  Created by Patka on 21/06/2024.
//

import SwiftUI

struct SearchView: View {
    
    // TODO: - inject (just remove the "=" and declare type instead)
    @StateObject var searchViewModel = SearchViewModel()
    // TODO: - move to SearchViewModel, declare e.g. as "allCharacters"
    @State var characters: [CharacterModel]
    @State var movies: [MovieModel]
    @State var showCharacters: Bool = true
    
    var body: some View {
        ZStack {
            Background()
            
            VStack {
                searchTitle
                searchBar
                
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
    
    private var searchTitle: some View {
        Text(Constants.Titles.searchForYourFavouriteCharactersOrMovies)
            .withCustomTitleTextFormatting(fontSize: 40 ,fontType: .textFont)
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .shadow(radius: 10)
    }
    
    private var searchBar: some View {
        SearchBarView(searchText: $searchViewModel.searchText) {
            searchViewModel.filterResults(characters: characters)
            searchViewModel.filterResults(movies: movies)
        }
    }
    
    private var resultsHeader: some View {
        ZStack(alignment: showCharacters ? .leading : .trailing) {
            HStack {
                resultsHeaderItem(text: Constants.Titles.titleCharacters, isSelected: showCharacters)
                // TODO: - consider making a struct to define some standard things like headers etc so not everything is defined as "magic numbers" - when reasonable
                    .offset(x: 20)
                
                resultsHeaderItem(text: Constants.Titles.titleMovies, isSelected: !showCharacters)
                    .offset(x: -20)
            }
            .padding(.horizontal)
            
            resultsHeaderArrow
                .rotationEffect(Angle(degrees: showCharacters ? 0 : 180))
                .padding(.horizontal, 15)
                .offset(y: 1)
        }
        .frame(height: 70)
        .cornerRadius(35)
        .onTapGesture {
            withAnimation(.spring()) {
                showCharacters.toggle()
            }
        }
    }
    
    private func resultsHeaderItem(text: String, isSelected: Bool) -> some View {
        Text(text)
            .padding(.horizontal)
            .padding(.vertical, 3)
            .background(isSelected ? Color(Constants.Colors.ravenclawGrey).opacity(0.7) : .clear)
            .cornerRadius(30)
            .foregroundStyle(isSelected ? .white : .gray)
            .shadow(radius: 10)
            .withCustomTitleTextFormatting(fontSize: isSelected ? 32 : 25, fontType: .titleFont, alignment: .center)
    }
    
    private var resultsHeaderArrow: some View {
        Image(systemName: Constants.Images.arrowRightIcon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.white.opacity(0.4))
            .frame(width: 25, height: 25)
            .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 0)
    }
    
    private var charactersSection: some View {
        ScrollView {
            ForEach(searchViewModel.filteredCharacters, id: \.id) { character in
                NavigationLink {
                    CharacterDetailsView(
                        viewModel: CharacterDetailsViewModel(
                            model: character
                        ),
                        character: character,
                        movies: movies)
                } label: {
                    SerachRowView(model: character, imageUrl: character.image)
                }
            }
        }
    }
    
    private var moviesSection: some View {
        ScrollView {
            ForEach(searchViewModel.filteredMovies, id: \.id) { movie in
                NavigationLink {
                    MovieDetailsView(viewModel: MovieDetailsViewModel(model: movie),
                                     image: searchViewModel.getImageUrlFromTMBD(model: movie, imageSize: 200) ?? "",
                                     movie: movie)
                } label: {
                    SerachRowView(model: movie, imageUrl: searchViewModel.getImageUrlFromTMBD(model: movie, imageSize: 200) ?? "")
                }
            }
        }
    }
}
