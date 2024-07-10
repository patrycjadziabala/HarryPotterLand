//
//  SearchRowView.swift
//  HarryPotterLand
//
//  Created by Patka on 24/06/2024.
//

import SwiftUI

struct SearchRowView: View {
    
    let model: DetailCollectionViewProtocol
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(Constants.Colors.hufflepuffLightBrown).opacity(0.4))
                .shadow(radius: 6)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white, lineWidth: 2))
            
            Text(model.collectionViewTitle)
                .withCustomTitleTextFormatting(fontType: .textFont)
                .foregroundStyle(.white)
        }
        .padding()
        .frame(height: 100)
    }
}

struct SearchRowView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Background()
            
            VStack {
                SearchRowView(model: dev.movie)
                    .previewLayout(.sizeThatFits)
                
                SearchRowView(model: dev.character)
                    .previewLayout(.sizeThatFits)
            }
        }
    }
}
