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
    let movie: MovieModel
    
    //MARK: - Main body
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (spacing: 25) {
                topSection
                genreSection
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
            name: viewModel.model.originalTitle ?? "1",
            image: image
        ) {
            Text(movie.overview ?? "")
        }
    }
    
    private var genreSection: some View {
        HStack (spacing: 25) {
            ForEach(movie.genres ?? [], content: { genre in
                OvalComponentView(text: genre.name ?? "")
            })
        }
    }
    
    private var infoGridView: some View {
        InfoGridView(
            title1: Constants.Titles.releaseDate,
            title2: Constants.Titles.originCountry,
            title3: Constants.Titles.budget,
            title4: Constants.Titles.rating,
            title5: nil,
            title6: nil,
            info1: movie.releaseDate?
                .replacingOccurrences(of: "-", with: "/") ?? "",
            info2: movie.originCountry?.description ?? "",
            info3: String(movie.budget ?? 0),
            info4: String(movie.voteAverage ?? 0),
            info5: nil,
            info6: nil,
            font: .callout,
            spacing: 150
        )
    }
}
