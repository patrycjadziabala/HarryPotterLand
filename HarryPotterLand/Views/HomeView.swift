//
//  HomeView.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
                Spacer(minLength: 25)
                Text(Constants.titleMoviesCollection)
                    .withCustomTitleTextFormatting()
                Spacer(minLength: 25)
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
            .onAppear {
                Task {
                    await viewModel.fetchHogwartsCastleImage()
                }
            }
        }
    }
}

extension View {
    
    func withCustomTitleTextFormatting(fontSize: Int = 28) -> some View {
        modifier(CustomTitleTextModifier(fontSize: fontSize))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
