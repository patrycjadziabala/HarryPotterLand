//
//  MoreInfoSheet.swift
//  HarryPotterLand
//
//  Created by Patka on 25/04/2024.
//

import SwiftUI

struct MoreInfoSheet: View {
    
    var houseLogo: String
    var studentStatus: String
    let websiteUrlString: String?
    let character: CharacterModel
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.1)
                .ignoresSafeArea()
            VStack {
                topSection
                middleSection
                websiteSection
                    .padding()
                Spacer()
                Text(Constants.Titles.scrollUp)
            }
        }
    }
}

struct MoreInfoSheet_Previews: PreviewProvider {
    static var previews: some View {
        MoreInfoSheet(
            houseLogo: dev.character.houseLogo,
            studentStatus: dev.character.hogwartsStudent.description, websiteUrlString: "",
            character: dev.character
        )
    }
}

extension MoreInfoSheet {
    
    private var topSection: some View {
        HStack  {
            Image(houseLogo)
                .withCustomImageModifier(frameWidth: 55)
                .padding()
            
            Text(character.hogwartsStudent ? "Student" : "Staff")
                .frame(maxWidth: .infinity)
                .withCustomTitleTextFormatting(fontSize: 30, alignment: .center)
            
            DismissButton(alignment: .leading)
        }
        .padding(.top, 8)
        .background(Color.black.opacity(0.1))
    }
    
    private var middleSection: some View {
        InfoGridView(
            title1: Constants.Titles.actor,
            title2: Constants.Titles.eyeColor,
            title3: Constants.Titles.hairColor,
            title4: Constants.Titles.ancestry,
            title5: Constants.Titles.patronus,
            title6: Constants.Titles.wizard,
            info1: character.actor,
            info2: character.eyeColour,
            info3: character.hairColour,
            info4: character.ancestry,
            info5: character.patronus,
            info6: character.wizard.description,
            font: .title,
            spacing: 50
        )
    }
    
    private var websiteSection: some View {
        VStack (alignment: .leading, spacing: 10) {
            Text(Constants.Titles.explore)
            Spacer(minLength: 4)
            if let websiteString = websiteUrlString,
               let url = URL(string: websiteString) {
                Link(Constants.Titles.fandom, destination: url)
            }
        }
        .accentColor(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
}
