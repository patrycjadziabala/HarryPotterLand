//
//  CharacterDetailsView.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI

struct CharacterDetailsView: View {
    
    //MARK: Properties
    @StateObject var viewModel: CharacterDetailsViewModel
    @State var showSheet: Bool = false
    @State var expand: Bool = false
    let character: CharacterModel
    
    //MARK: Main body
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack (spacing: 25) {
                topSection
                moreInformationButton()
                Text(Constants.titleMoviesCollection)
                    .withCustomTitleTextFormatting()
                //press and hold to see a bigger picture
                //                    DetailCollectionView()
                seeMoreButton
            }
        }
        .background(
            Color.blue
                .opacity(0.6)
                .ignoresSafeArea()
        )
        .sheet(isPresented: $showSheet) {
            moreInfoSheet
        }
    }
}

struct ReusableDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailsView(viewModel: CharacterDetailsViewModel(model: dev.character), character: dev.character)
    }
}

extension CharacterDetailsView {
    
    private var topSection: some View {
        DescriptionViewGeneric(
            viewType: .characterDetails,
            name: character.name,
            image: character.image
        )
        {
            infoGridView
        }
    }
    
    private var infoGridView: some View {
        InfoGridView(
            title1: Constants.house,
            title2: Constants.species,
            title3: Constants.alive,
            title4: Constants.dateOfBirth,
            title5: nil,
            title6: nil,
            info1: character.house,
            info2: character.species,
            info3: character.alive.description,
            info4: character.dateOfBirth?
                .replacingOccurrences(of: "-", with: "/")
                .replacingOccurrences(of: "19", with: "")
            ?? Constants.na,
            info5: nil,
            info6: nil,
            font: .callout,
            spacing: 5
        )
    }
    
    private var moreInfoSheet: some View {
        MoreInfoSheet(houseLogo: character.houseLogo, studentStatus: character.hogwartsStudent ? Constants.student : Constants.staff, websiteUrlString: viewModel.buildUrlForCharacterFandom(character: character), character: character)
            .presentationDetents([.medium, .large])
    }
    
    //MARK: Buttons
    
    private func moreInformationButton() -> some View {
        Button {
            showSheet.toggle()
        } label: {
            Text("More information")
                .buttonBorderShape(.roundedRectangle)
        }
    }
    
    private var seeMoreButton: some View {
        Text("See more button")
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing)
    }
}
