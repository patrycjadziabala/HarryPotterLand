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
    let description: String
    let content: Content
    
    init(viewType: ViewType, name: String, image: String, description: String, @ViewBuilder content: () -> Content) {
        self.name = name
        self.image = image
        self.description = description
        self.content = content()
        self.viewType = viewType
    }
    
    var body: some View {
        VStack {
            switch viewType {
            case .movieDetails:
                VStack {
                    Text(name)
                    HStack {
                        CachedAsyncImage(url: URL(string: image)) { image in
                            image
                                .withCustomImageModifier(frameWidth: 150)
                                .padding(.trailing)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(description)
                            .withCustomTitleTextFormatting(fontSize: 15, alignment: .center)
                    }
                }
            case .characterDetails:
                VStack {
                    Text(name)
                        .font(Font.custom(Constants.fontHP, size: 100))
                    HStack {
                        Text(description)
                            .withCustomTitleTextFormatting(fontSize: 15, alignment: .center)
                        CachedAsyncImage(url: URL(string: image)) { image in
                            image
                                .withCustomImageModifier(frameWidth: 150)
                                .padding(.trailing)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
            content
        }
    }
}
