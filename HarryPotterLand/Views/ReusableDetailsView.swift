//
//  ReusableDetailsView.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI

struct ReusableDetailsView: View {
    enum ViewType {
        case movie
        case character
    }
    
    let viewType: ViewType
    let title: String
    let description: String?
    let image: UIImage?
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            LazyVStack (spacing: 25) {
                Text(title)
                    .withCustomTitleTextFormatting(fontSize: 40,
                                                   alignment: .top)
                VStack {
                    switch viewType {
                    case .movie:
                        if let image = image,
                           let description = description {
                            DesctriptionViewGeneric(viewType: .movie, image: image, description: description) {
                                Text("Additional information")
                                    .padding()
                            }
                        }
                        Text(Constants.titleCharacters)
                            .withCustomTitleTextFormatting()
                    case .character:
                        if let image = image,
                           let description = description {
                            DesctriptionViewGeneric(viewType: .movie, image: image, description: description) {
                                Text("Additional information")
                                    .padding()
                            }
                        }
                        Text(Constants.titleMoviesCollection)
                            .withCustomTitleTextFormatting()
                    }
                }
                CustomHorizontalGridView()
            }
        }
    }
}

struct DesctriptionViewGeneric<Content: View>: View {
    enum ViewType {
        case movie
        case character
    }
    
    let viewType: ViewType
    let image: UIImage
    let description: String
    let content: Content
    
    init(viewType: ViewType, image: UIImage, description: String, @ViewBuilder content: () -> Content) {
        self.image = image
        self.description = description
        self.content = content()
        self.viewType = viewType
    }
    
    var body: some View {
        VStack {
            HStack {
                switch viewType {
                case .movie:
                    Image(uiImage: image)
                        .withCustomImageModifier(frameWidth: 220)
                        .padding(.leading)
                    Text(description)
                        .withCustomTitleTextFormatting(fontSize: 15, alignment: .center)
                case .character:
                    Text(description)
                        .withCustomTitleTextFormatting(fontSize: 15, alignment: .center)
                    Image(uiImage: image)
                        .withCustomImageModifier(frameWidth: 220)
                        .padding(.leading)
                }
            }
            content
        }
    }
}

extension Image {
    func withCustomImageModifier(frameWidth: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(maxWidth: frameWidth)
    }
}

struct ReusableDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ReusableDetailsView(viewType: .character, title: "Harry Potter", description: "Main character", image: UIImage(systemName: "heart.fill")!)
    }
}
