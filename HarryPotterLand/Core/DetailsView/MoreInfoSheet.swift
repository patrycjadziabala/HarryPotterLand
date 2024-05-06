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
                Text(Constants.scrollUp)
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
            title1: Constants.actor,
            title2: Constants.eyeColor,
            title3: Constants.hairColor,
            title4: Constants.ancestry,
            title5: Constants.patronus,
            title6: Constants.wizard,
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
            Text(Constants.explore)
            Spacer(minLength: 4)
            if let websiteString = websiteUrlString,
               let url = URL(string: websiteString) {
                Link(Constants.fandom, destination: url)
            }
        }
        .accentColor(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
}
