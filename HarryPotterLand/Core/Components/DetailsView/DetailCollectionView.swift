//
//  DetailCollectionView.swift
//  HarryPotterLand
//
//  Created by Patka on 23/04/2024.
//

import SwiftUI
import CachedAsyncImage

struct DetailCollectionView: View {
    
    let character: CharacterModel
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                GeometryReader { geometry in
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.gray)
                        
                        VStack {
                            CachedAsyncImage(url: URL(string: character.image)) { image in
                                if #available(iOS 16.4, *) {
                                    image
                                        .resizable()
                                        .scaledToFit()
                                    
                                        .frame(maxWidth: 150, maxHeight: 175)
                                } else {
                                    // Fallback on earlier versions
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(35)
                                }
                            } placeholder: {
                                ProgressView()
                            }
                            Text(character.name)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 4)
                            Text(character.house)
                                .font(.subheadline)
                                .padding(.bottom, 4)
                        }
                    }
                    .rotation3DEffect(
                        Angle(degrees: getPercentage(geo: geometry) * 20),
                        axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                    )
                }
                .frame(width: 150, height: 250)
                .shadow(radius: 10)
                .padding()
            }
        }
    }
}

struct DetailCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCollectionView(character: dev.character)
    }
}

extension DetailCollectionView {
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
}