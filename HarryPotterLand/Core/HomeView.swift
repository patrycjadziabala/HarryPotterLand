//
//  HomeView.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI
import CachedAsyncImage

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack (spacing: 5) {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom)
                }
//                Text(Constants.titleMoviesCollection)
//                    .withCustomTitleTextFormatting()
               
//                    DetailCollectionView(image: character.image, name: character.name, description: character.house)
                
                Text(Constants.titleCharacters)
                    .withCustomTitleTextFormatting()
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.characters, id: \.id) { character in
                            NavigationLink {
                                DetailsView(viewType: .characterDetails, viewModel: DetailsViewModel(subTitle: "Subtitle", model: character))
                            } label: {
                                DetailCollectionView(character: character)
                            }
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchHogwartsCastleImage()
                    fetchCharacters()
                }
            }
        }
        .ignoresSafeArea()
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView(viewModel: HomeViewModel())
        }
    }
}

extension HomeView {
    
    private func fetchCharacters() {
         Task {
             do {
                 try await viewModel.fetchCharacters()
             } catch {
                 
             }
         }
     }
}
