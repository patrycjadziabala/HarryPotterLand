//
//  MovieDetailsView.swift
//  HarryPotterLand
//
//  Created by Patka on 02/05/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    
    @StateObject var viewModel: MovieDetailsViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.model.originalTitle ?? "1")
//            DescriptionViewGeneric(
//                viewType: .movieDetails,
//                name: viewModel.model.originalTitle ?? "" ,
//                image: viewModel.model.posterPath ?? "") {
//                    
//                }
        }   
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {   
        MovieDetailsView(viewModel: MovieDetailsViewModel(model: dev.movie))
    }
}
