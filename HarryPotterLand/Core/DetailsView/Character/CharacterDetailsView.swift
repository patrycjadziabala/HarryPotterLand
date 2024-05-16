//
//  CharacterDetailsView.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI

struct CharacterDetailsView: View {
    
    //MARK: Properties
    @StateObject var viewModel: CharacterDetailsViewModel
    @State var showSheet: Bool = false
    @State var expand: Bool = false
    let character: CharacterModel
    let movies: [MovieModel]
    
    //MARK: Main body
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (spacing: 25) {
                topSection
                moreInformationButton()
                Text(Constants.Titles.titleMoviesCollection)
                    .withCustomTitleTextFormatting()
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(viewModel.actorInMovies, id: \.id) { movie in
                            NavigationLink {
                                MovieDetailsView(
                                    viewModel: MovieDetailsViewModel(
                                        model: movie
                                    ),
                                    image: movie.posterPath ?? "",
                                    movie: movie
                                )
                            } label: {
                                DetailCollectionView(
                                    frameWidth: 150,
                                    imageUrl: viewModel.getImageUrlFromTMBD(model: movie, imageSize: 200),
                                    model: movie
                                )
                            }
                            
                        }
                    }
                }
                //press and hold to see a bigger picture
                //                    DetailCollectionView()
                seeMoreButton
            }
        }
        .onAppear(perform: {
            fetchData()
        })
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

struct ReusableDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailsView(viewModel: CharacterDetailsViewModel(model: dev.character), character: dev.character, movies: [dev.movie])
    }
}

extension CharacterDetailsView {
    
    private var topSection: some View {
        DescriptionViewGeneric(
            viewType: .characterDetails,
            name: character.name,
            image: character.image
        )
        {
            infoGridView
        }
    }
    
    private var infoGridView: some View {
        InfoGridView(
            title1: Constants.Titles.house,
            title2: Constants.Titles.species,
            title3: Constants.Titles.alive,
            title4: Constants.Titles.dateOfBirth,
            title5: nil,
            title6: nil,
            info1: character.house,
            info2: character.species,
            info3: character.alive.description,
            info4: character.dateOfBirth?
                .replacingOccurrences(of: "-", with: "/")
                .replacingOccurrences(of: "19", with: "")
            ?? Constants.Titles.na,
            info5: nil,
            info6: nil,
            font: .callout,
            spacing: 5
        )
    }
    
    private var moreInfoSheet: some View {
        MoreInfoSheet(houseLogo: character.houseLogo, studentStatus: character.hogwartsStudent ? Constants.Titles.student : Constants.Titles.staff, websiteUrlString: viewModel.buildUrlForCharacterFandom(character: character), character: character)
            .presentationDetents([.medium, .large])
    }
    
    //MARK: Buttons
    
    private func moreInformationButton() -> some View {
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
