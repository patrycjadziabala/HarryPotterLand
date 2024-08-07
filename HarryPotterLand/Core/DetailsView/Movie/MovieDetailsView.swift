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
    let movie: DetailCollectionCellProtocol

    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (spacing: 25) {
                topSection
//                genreSection
                infoGridView
            }
        }
    }
}

extension MovieDetailsView {
    
    private var topSection: some View {
        DescriptionViewGeneric(
            viewType: .movieDetails,
            name: viewModel.model.collectionViewTitle,
            image: String.buildImageUrlString(from: movie, imageSize: 200)
        ) {
            Text(movie.collectionViewDetails)
        }
    }
    
//    private var genreSection: some View {
//        HStack (spacing: 25) {
//            ForEach(movie.genres ?? [], content: { genre in
//                OvalComponentView(text: genre.name ?? "")
//            })
//        }
//    }
    
    private var infoGridView: some View {
        InfoGridView(
            rows: [
                InfoGridRow(
                title: Constants.Titles.releaseDate,
                info: movie.collectionViewTitle),
                InfoGridRow(
                title: Constants.Titles.originCountry,
                info: movie.collectionViewTitle),
                InfoGridRow(
                title: Constants.Titles.budget,
                info: String(movie.collectionViewDetails)),
                InfoGridRow(
                title: Constants.Titles.rating,
                info: String(movie.collectionViewTitle)),
            ],
            font: .callout,
            spacing: 150)
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(viewModel: MovieDetailsViewModel(model: dev.movie), image: dev.movie.backdropPath ?? "", movie: dev.movie)
    }
}
