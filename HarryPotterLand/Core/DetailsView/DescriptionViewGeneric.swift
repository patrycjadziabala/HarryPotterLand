//
//  DescriptionViewGeneric.swift
//  HarryPotterLand
//
//  Created by Patka on 24/04/2024.
//

import SwiftUI
import CachedAsyncImage

struct DescriptionViewGeneric<Content: View>: View {
    
    let viewType: ViewType
    let name: String
    let image: String
    let content: Content
    
    init(viewType: ViewType, name: String, image: String, @ViewBuilder content: () -> Content) {
        self.name = name
        self.image = image
        self.content = content()
        self.viewType = viewType
    }
    
    var body: some View {
        VStack {
            Text(name)
                .font(Font.custom(Constants.fontHP, size: viewType == .characterDetails ? 70 : 50 ))
                .frame(maxWidth: .infinity)
                .frame(alignment: .center)
            HStack {
                switch viewType {
                case .movieDetails:
                    imageSection
                    content
                        .withCustomTitleTextFormatting(fontSize: 15, alignment: .center)
                case .characterDetails:
                    content
                        .withCustomTitleTextFormatting(fontSize: 15)
                    imageSection
                }
            }
        }
    }
}

extension DescriptionViewGeneric {
    
    private var imageSection: some View {
        CachedAsyncImage(url: URL(string: image)) { image in
            image
                .withCustomImageModifier(frameWidth: 200)
                .padding(.leading)
        } placeholder: {
            ProgressView()
        }
    }
}
