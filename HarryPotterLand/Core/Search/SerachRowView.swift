//
//  SerachRowView.swift
//  HarryPotterLand
//
//  Created by Patka on 24/06/2024.
//

import SwiftUI
import CachedAsyncImage

struct SerachRowView: View {
    
    let model: DetailCollectionViewProtocol
    let imageUrl: String?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(Constants.Colors.hufflepuffLightBrown).opacity(0.4))
                .shadow(radius: 6)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 2))
            
            Text(model.collectionViewTitle)
                .withCustomTitleTextFormatting(fontType: .textFont)
                .foregroundStyle(.white)
        }
        .padding()
        .frame(height: 100)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Background()
            
            VStack {
                SerachRowView(model: dev.movie, imageUrl: "")
                    .previewLayout(.sizeThatFits)
                
                SerachRowView(model: dev.character, imageUrl: "")
                    .previewLayout(.sizeThatFits)
            }
        }
    }
}
