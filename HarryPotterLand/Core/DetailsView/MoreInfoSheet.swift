//
//  MoreInfoSheet.swift
//  HarryPotterLand
//
//  Created by Patka on 25/04/2024.
//

import SwiftUI

struct MoreInfoSheet: View {
    
    let model: MoreInfo
    
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

extension MoreInfoSheet {
    
    private var topSection: some View {
        HStack  {
            Image(model.houseLogo)
                .withCustomImageModifier(frameWidth: 55)
                .padding()
            
            Text(model.character.hogwartsStudent ? Constants.Titles.student : Constants.Titles.staff)
                .frame(maxWidth: .infinity)
                .withCustomTitleTextFormatting(fontSize: 30, fontType: .titleFont, alignment: .center)
            
            DismissButton(alignment: .leading)
        }
        .padding(.top, 8)
        .background(Color.black.opacity(0.1))
    }
    
    private var middleSection: some View {
        InfoGridView(rows:
                        [InfoGridRow(title: Constants.Titles.actor, info: model.character.actor),
                         InfoGridRow(title: Constants.Titles.eyeColor, info: model.character.eyeColour),
                         InfoGridRow(title: Constants.Titles.hairColor, info: model.character.hairColour),
                         InfoGridRow(title: Constants.Titles.ancestry, info: model.character.ancestry),
                         InfoGridRow(title: Constants.Titles.patronus, info: model.character.patronus),
                         InfoGridRow(title: Constants.Titles.wizard, info: model.character.wizard.description),
                        ],
                     font: .title,
                     spacing: 50
        )
    }
    
    private var websiteSection: some View {
        VStack (alignment: .leading, spacing: 10) {
            Text(Constants.Titles.explore)
            Spacer(minLength: 4)
            if let websiteString = model.websiteUrlString,
               let url = URL(string: websiteString) {
                Link(Constants.Titles.fandom, destination: url)
            }
        }
        .accentColor(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
}

struct MoreInfoSheet_Previews: PreviewProvider {
    static var previews: some View {
        MoreInfoSheet(model: MoreInfo(houseLogo: dev.character.houseLogo, studentStatus: dev.character.actor, websiteUrlString: dev.character.webFandom, character: dev.character))
    }
}
