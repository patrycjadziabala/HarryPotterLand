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
                if viewType == .movie {
                    if let image = image,
                       let description = description {
                        MovieDesctriptionViewGeneric(image: image,
                                                     description: description) {
                            Text("Additional information")
                                .padding()
                        }
                    }
                } else if viewType == .character {
                    if let image = image,
                       let description = description {
                        CharacterDesctriptionViewGeneric(image: image, description: description) {
                            Text("Additional information")
                                .padding()
                        }
                    }
                }
                Text(Constants.titleMoviesCollection)
                    .withCustomTitleTextFormatting()
                CustomHorizontalGridView()
            }
        }
    }
}

struct MovieDesctriptionViewGeneric<Content: View>: View {
    
    let image: UIImage?
    let description: String?
    let content: Content
    
    init(image: UIImage, description: String, @ViewBuilder content: () -> Content) {
        self.image = image
        self.description = description
        self.content = content()
    }
    
    var body: some View {
        VStack {
            HStack {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding(.leading)
                        .frame(maxWidth: 250)
                }
                if let description = description {
                    Text(description)
                        .withCustomTitleTextFormatting(fontSize: 15, alignment: .center)
                }
            }
            content
        }
    }
}

struct CharacterDesctriptionViewGeneric<Content: View>: View {
    
    let image: UIImage?
    let description: String?
    let content: Content
    
    init(image: UIImage, description: String, @ViewBuilder content: () -> Content) {
        self.image = image
        self.description = description
        self.content = content()
    }
    
    var body: some View {
        VStack {
            HStack {
                if let description = description {
                    Text(description)
                        .withCustomTitleTextFormatting(fontSize: 15, alignment: .center)
                }
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .padding(.trailing)
                        .frame(maxWidth: 250)
                }
            }
            content
        }
    }
}

struct ReusableDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ReusableDetailsView(viewType: .character, title: "Harry Potter", description: "Main character", image: UIImage(systemName: "heart.fill")!)
    }
}
