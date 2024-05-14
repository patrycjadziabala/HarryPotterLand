//
//  HomeView.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI
import CachedAsyncImage

struct HomeView: View {
    
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack (spacing: 5) {
                imageSection
                charactersSection
                Spacer()
                moviesSection
            }
            .onAppear {
                Task {
                    fetchData()
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
        }
    }
}

extension HomeView {
    
    private var imageSection: some View {
        VStack {
            if let image = homeViewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom)
            }
        }
    }
    
    private var charactersSection: some View {
        VStack {
            Text(Constants.Titles.titleCharacters)
                .withCustomTitleTextFormatting()
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(homeViewModel.characters, id: \.id) { character in
                        NavigationLink {
                            CharacterDetailsView(
                                viewModel: CharacterDetailsViewModel(
                                    model: character
                                ),
                                character: character,
                                movies: homeViewModel.movies
                            )
                        } label: {
                    
                            DetailCollectionView(
                                imageUrl: character.image,
                                title: character.name,
                                details: character.house,
                                frameWidth: 150
                            )
                        }
                    }
                }
            }
        }
    }
    
    private var moviesSection: some View {
        VStack {
            Text(Constants.Titles.titleMoviesCollection)
                .withCustomTitleTextFormatting()
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(homeViewModel.movies, id: \.id) { movie in
                        NavigationLink {
                            MovieDetailsView(viewModel: MovieDetailsViewModel(model: movie), image: homeViewModel.getImageUrlFromTMBD(model: movie, imageSize: 200) ?? "", movie: movie)
                        } label: {
                            DetailCollectionView(
                                imageUrl:
                                    homeViewModel.getImageUrlFromTMBD(model: movie, imageSize: 200) ?? ""
                                ,
                                title: movie.originalTitle ?? Constants.Titles.notAvailable,
                                details: movie.releaseDate ?? Constants.Titles.unknown,
                                frameWidth: 150
                            )
                        }
                    }
                }
            }
        }
    }
    
    private func fetchData() {
        Task {
            do {
                try await homeViewModel.fetchCharacters()
                await homeViewModel.fetchHogwartsCastleImage()
                try await homeViewModel.fetchMovieDetails()
            } catch {
                
            }
        }
    }
}
