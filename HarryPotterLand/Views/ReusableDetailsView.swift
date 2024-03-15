//
//  ReusableDetailsView.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI

struct ReusableDetailsView: View {
    let viewType: ViewType
    let title: String
    let description: String?
    let image: UIImage?
    
    @StateObject private var viewModel = ReusableDetailsViewModel()
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            LazyVStack (spacing: 25) {
                Text(title)
                    .withCustomTitleTextFormatting(fontSize: 40,
                                                   alignment: .top)
                VStack {
                    if let image = image,
                       let description = description {
                        DesctriptionViewGeneric(viewType: viewType, image: image, description: description) {
                            Text("Additional information")
                                .padding()
                        }
                    }
                    Text(viewModel.subTitle ?? "")
                        .withCustomTitleTextFormatting()
                    CustomHorizontalGridView()
                    Text("See more button")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing)
                }
            }
        }
        .background(
            Color.blue
                .opacity(0.6)
                .ignoresSafeArea()
        )
    }
}

struct DesctriptionViewGeneric<Content: View>: View {
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
                case .movieDetails:
                    Image(uiImage: image)
                        .withCustomImageModifier(frameWidth: 220)
                        .padding(.trailing)
                    Text(description)
                        .withCustomTitleTextFormatting(fontSize: 15, alignment: .center)
                case .characterDetails:
                    Text(description)
                        .withCustomTitleTextFormatting(fontSize: 15, alignment: .center)
                    Image(uiImage: image)
                        .withCustomImageModifier(frameWidth: 220)
                        .padding(.trailing)
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
            .frame(maxWidth: frameWidth, alignment: .center)
    }
}

struct ReusableDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ReusableDetailsView(viewType: .characterDetails, title: "Harry Potter", description: "Main character", image: UIImage(systemName: "heart.fill")!)
    }
}
