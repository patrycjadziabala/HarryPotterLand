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

struct CustomHorizontalGridView: View {
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(0..<10) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.gray)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geometry) * 40),
                                axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                            )
                    }
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
