//
//  DetailsView.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI
import CachedAsyncImage

struct DetailsView: View {
    
    //MARK: Properties
    @State var viewType: ViewType
    
    @StateObject var viewModel: DetailsViewModel
    @State var showSheet: Bool = false
    let character: CharacterModel
    
    //MARK: Main body
    var body: some View {
        ScrollView (showsIndicators: false) {
            LazyVStack (spacing: 25) {
                
                DescriptionViewGeneric(
                    viewType: viewType,
                    name: character.name,
                    image: character.image,
                    description: character.house) {
                        Button {
                            showSheet.toggle()
                        } label: {
                            Text("More information")
                                .buttonBorderShape(.roundedRectangle)
                        }
                    }
                
                Text(viewType == .characterDetails ? Constants.titleMoviesCollection : Constants.titleCharacters)
                    .withCustomTitleTextFormatting()
                //press and hold to see a bigger picture
                //                    DetailCollectionView()
                Text("See more button")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing)
            }
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
        DetailsView(viewType: .characterDetails, viewModel: DetailsViewModel(model: dev.character), character: dev.character)
    }
}
