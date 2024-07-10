//
//  DetailCollectionView.swift
//  HarryPotterLand
//
//  Created by Patka on 23/04/2024.
//

import SwiftUI
import CachedAsyncImage

protocol DetailCollectionCellProtocol {
    var collectionViewId: String { get }
    var collectionViewTitle: String { get }
    var collectionViewDetails: String { get }
    var collectionImageUrl: String { get }
    var collectionViewCellType: CellContentType { get }
}

struct DetailCollectionCell: View {
    var frameWidth: CGFloat?
    let imageUrl: String?
    let model: DetailCollectionCellProtocol
    
    var body: some View {
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

extension DetailCollectionCell {
    
    private var imageSection: some View {
        CachedAsyncImage(url: URL(string: imageUrl ?? "")) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 150, maxHeight: 175)
                .cornerRadius(15)
                .padding()
        } placeholder: {
            ProgressView()
        }
    }
    
    private var titleAndSubtitleSection: some View {
        VStack {
            Text(model.collectionViewTitle)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 4)
            Text(model.collectionViewDetails)
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

struct DetailCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCollectionCell(
            frameWidth: 150,
            imageUrl: dev.movie.posterPath,
            model: dev.movie
        )
    }
}
