//
//  DetailsView.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI

struct DetailsView: View {
    
    //MARK: Properties
    let viewType: ViewType
    
    @StateObject var viewModel: DetailsViewModel
    @State var showSheet: Bool = false
    
    //MARK: Main body
    var body: some View {
        ScrollView (showsIndicators: false) {
            LazyVStack (spacing: 25) {
                
                Text(viewModel.getSubTitle(viewType: viewType))
                    .withCustomTitleTextFormatting(fontSize: 40,
                                                   alignment: .top)
                VStack {
                    DesctriptionViewGeneric(viewType: viewType,
                                            image: viewModel.model.image,
                                            description: viewModel.model.house) {
                        Button {
                            showSheet.toggle()
                        } label: {
                            Text("More information")
                                .buttonBorderShape(.roundedRectangle)
                        }
                    }
                }
                Text(viewModel.subTitle)
                    .withCustomTitleTextFormatting()
                //press and hold to see a bigger picture
                //                    DetailCollectionView()
                Text("See more button")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing)
            }
        }
        .onAppear {
            viewModel.getSubTitle(viewType: viewType)
        }
        .background(
            Color.blue
                .opacity(0.6)
                .ignoresSafeArea()
        )
        .sheet(isPresented: $showSheet) {
            MoreInformationSheet()
                .presentationDetents([.medium, .large])
        }
    }
    
    
    //MARK: DesctriptionViewGeneric
    struct DesctriptionViewGeneric<Content: View>: View {
        
        let viewType: ViewType
        let image: String
        let description: String
        let content: Content
        
        init(viewType: ViewType, image: String, description: String, @ViewBuilder content: () -> Content) {
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
                        Image(image)
                            .withCustomImageModifier(frameWidth: 220)
                            .padding(.leading)
                        Text(description)
                            .withCustomTitleTextFormatting(fontSize: 15, alignment: .center)
                    case .characterDetails:
                        Text(description)
                            .withCustomTitleTextFormatting(fontSize: 15, alignment: .center)
                        Image(image)
                            .withCustomImageModifier(frameWidth: 220)
                            .padding(.trailing)
                    }
                }
                content
            }
        }
    }
    
    //MARK: MoreInformationSheet
    struct MoreInformationSheet: View {
        
        @Environment(\.dismiss) var dismiss
        
        var body: some View {
            ZStack {
                Color.green
                    .opacity(0.6)
                    .ignoresSafeArea()
                VStack {
                    VStack (alignment: .trailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .padding(20)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    Spacer()
                    Text("More info")
                }
            }
        }
    }
}

    struct ReusableDetailsView_Previews: PreviewProvider {
        static var previews: some View {
            DetailsView(viewType: .characterDetails, viewModel: DetailsViewModel(subTitle: "Character", model: dev.character))
        }
    }
