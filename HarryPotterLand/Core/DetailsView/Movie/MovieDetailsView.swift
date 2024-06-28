//
//  MovieDetailsView.swift
//  HarryPotterLand
//
//  Created by Patka on 02/05/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    
    @StateObject var viewModel: MovieDetailsViewModel
    let image: String
    let movie: DetailCollectionViewProtocol
    
    //MARK: - Main body
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (spacing: 25) {
                topSection
                // TODO: - remove if not needed
//                genreSection
                infoGridView
            }
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(viewModel: MovieDetailsViewModel(model: dev.movie), image: dev.movie.backdropPath ?? "", movie: dev.movie)
    }
}

extension MovieDetailsView {
    
    private var topSection: some View {
        DescriptionViewGeneric(
            viewType: .movieDetails,
            name: viewModel.model.collectionViewTitle,
            image: viewModel.getImageUrlFromTMBD(model: movie, imageSize: 200) ?? ""
        ) {
            Text(movie.collectionViewDetails)
        }
    }
    
    // TODO: - remove if not needed
//    private var genreSection: some View {
//        HStack (spacing: 25) {
//            ForEach(movie.genres ?? [], content: { genre in
//                OvalComponentView(text: genre.name ?? "")
//            })
//        }
//    }
    
    private var infoGridView: some View {
        InfoGridView(
            title1: Constants.Titles.releaseDate,
            title2: Constants.Titles.originCountry,
            title3: Constants.Titles.budget,
            title4: Constants.Titles.rating,
            title5: nil,
            title6: nil,
            info1: movie.collectionViewTitle,
            // TODO: - remove if not needed
//                .replacingOccurrences(of: "-", with: "/") ?? "",
            info2: movie.collectionViewTitle,
            info3: String(movie.collectionViewDetails),
            info4: String(movie.collectionViewTitle),
            info5: nil,
            info6: nil,
            font: .callout,
            spacing: 150
        )
    }
}
