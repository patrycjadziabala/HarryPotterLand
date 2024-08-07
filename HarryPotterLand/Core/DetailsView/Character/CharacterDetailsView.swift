//
//  CharacterDetailsView.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI

struct CharacterDetailsView: View {
    
    @StateObject var viewModel: CharacterDetailsViewModel
    @State private var showSheet: Bool = false
    let character: Character
    let movies: [Movie]
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (spacing: 25) {
                topSection
                moreInformationButton
                Text(Constants.Titles.titleMoviesCollection)
                //                    .withCustomTitleTextFormatting(, fontType: <#FontType#>)
                
                // TODO: - try to snap to grid (center a card)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.actorInMovies, id: \.id) { movie in
                            NavigationLink(destination: MovieDetailsView(
                                viewModel: MovieDetailsViewModel(
                                    model: movie
                                ),
                                image: movie.posterPath ?? "",
                                movie: movie
                            )) {
                                DetailCollectionCell(
                                    frameWidth: 150,
                                    imageUrl: String.buildImageUrlString(from: movie, imageSize: 200),
                                    model: movie
                                )
                            }
                        }
                    }
                }
                
                // TODO: -  remove if not needed
                //press and hold to see a bigger picture
                //                    DetailCollectionView()
                seeMoreButton
            }
        }
        .onAppear {
            fetchData()
        }
        .background(
            Color.blue
                .opacity(0.6)
                .ignoresSafeArea()
        )
        .sheet(isPresented: $showSheet) {
            moreInfoSheet
        }
    }
}

extension CharacterDetailsView {
    
    private var topSection: some View {
        DescriptionViewGeneric(
            viewType: .characterDetails,
            name: character.name,
            image: character.image)
        {
            infoGridView
        }
    }
    
    private var infoGridView: some View {
        InfoGridView(rows:
                        [InfoGridRow(title: Constants.Titles.house, info: character.house),
                         InfoGridRow(title: Constants.Titles.species, info: character.species),
                         InfoGridRow(title: Constants.Titles.alive, info: character.alive.description),
                         InfoGridRow(title: Constants.Titles.dateOfBirth, info: character.dateOfBirth?
                            .replacingOccurrences(of: "-", with: "/")
                            .replacingOccurrences(of: "19", with: "") ?? Constants.Titles.na)
                        ],
                     font: .callout,
                     spacing: 5
        )
    }
    
    private var moreInfoSheet: some View {
        MoreInfoSheet(model: MoreInfo(houseLogo: character.houseLogo, studentStatus: character.actor, websiteUrlString: character.webFandom, character: character))
            .presentationDetents([.medium, .large])
    }
    
    //MARK: Buttons
    
    private var moreInformationButton: some View {
        Button {
            showSheet.toggle()
        } label: {
            Text("More information")
                .buttonBorderShape(.roundedRectangle)
        }
    }
    
    private var seeMoreButton: some View {
        Text("See more button")
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
    }
    
    //MARK: - Functions
    
    private func fetchData() {
        Task {
            do {
                try await viewModel.getHarryPotterMoviesForActor()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct ReusableDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailsView(viewModel: CharacterDetailsViewModel(model: dev.character, apiManager: APIManager()), character: dev.character, movies: [dev.movie])
    }
}
