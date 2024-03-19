//
//  HomeView.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        TabView {
            ScrollView(showsIndicators: false) {
                LazyVStack (spacing: 5) {
                    if let image = viewModel.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .padding(.bottom)
                    }
                    Text(Constants.titleMoviesCollection)
                        .withCustomTitleTextFormatting()
                    CustomHorizontalGridView()
                    Text(Constants.titleCharacters)
                        .withCustomTitleTextFormatting()
                    CustomHorizontalGridView()
                }
                .onAppear {
                    Task {
                        await viewModel.fetchHogwartsCastleImage()
                    }
                }
            }
        }
    }
}



struct CustomHorizontalGridView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(0..<10) { index in
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.gray)
                        .frame(width: 150, height: 200)
                        .shadow(radius: 10)
                        .padding()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
