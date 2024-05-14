//
//  DetailCollectionView.swift
//  HarryPotterLand
//
//  Created by Patka on 23/04/2024.
//

import SwiftUI
import CachedAsyncImage

struct DetailCollectionView: View {
    
    let imageUrl: String
    let title: String
    let details: String
    let frameWidth: CGFloat?
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                GeometryReader { geometry in
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.gray)
                        VStack {
                            imageSection
                            titleAndSubtitleSection
                        }
                    }
                    .rotation3DEffect(
                        Angle(degrees: getPercentage(geo: geometry) * 20),
                        axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                    )
                }
                .frame(width: frameWidth, height: 250)
                .shadow(radius: 10)
                .padding()
            }
        }
    }
}

struct DetailCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCollectionView(
            imageUrl: dev.character.image,
            title: dev.character.name,
            details: dev.character.house,
            frameWidth: 150
        )
    }
}

extension DetailCollectionView {
    
    private var imageSection: some View {
        CachedAsyncImage(url: URL(string: imageUrl)) { image in
            if #available(iOS 16.4, *) {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 150, maxHeight: 175)
                    .cornerRadius(15)
                    .padding()

            } else {
                // Fallback on earlier versions
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(15)
                    .padding()
            }
        } placeholder: {
            ProgressView()
        }
//        .clipShape(RoundedRectangle(cornerRadius: 55, style: .continuous))
    }
    
    private var titleAndSubtitleSection: some View {
        VStack {
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 4)
            Text(details)
                .font(.subheadline)
                .padding(.bottom, 4)
        }
    }
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
}
