//
//  HomeView.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI
import CachedAsyncImage

struct HomeView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack (spacing: 5) {
                if let image = homeViewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom)
                }
                Text(Constants.titleCharacters)
                    .withCustomTitleTextFormatting()
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(homeViewModel.characters, id: \.id) { character in
                            NavigationLink {
                                CharacterDetailsView(
                                    viewModel: CharacterDetailsViewModel(
                                        model: character
                                    ),
                                    character: character
                                )
                            } label: {
                                DetailCollectionView(
                                    url: character.image,
                                    title: character.name,
                                    details: character.house,
                                    frameWidth: 150
                                )
                            }
                        }
                    }
                }
                Spacer()
                Text(Constants.titleMoviesCollection)
                    .withCustomTitleTextFormatting()
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(homeViewModel.movies, id: \.id) { movie in
                            NavigationLink {
                                MovieDetailsView(viewModel: MovieDetailsViewModel(model: movie), image: homeViewModel.getImageUrlFromTMBD(model: movie, imageSize: 200) ?? "", movie: movie)
                            } label: {
                                DetailCollectionView(
                                    url:
                                        homeViewModel.getImageUrlFromTMBD(model: movie, imageSize: 200) ?? ""
                                    ,
                                    title: movie.originalTitle ?? "Not available",
                                    details: movie.releaseDate ?? "Unknown",
                                    frameWidth: 150
                                )
                            }
                        }
                    }
                }
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
                .environmentObject(HomeViewModel())
        }
    }
}

extension HomeView {
    
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
