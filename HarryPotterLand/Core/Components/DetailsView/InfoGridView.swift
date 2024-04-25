//
//  InfoGridView.swift
//  HarryPotterLand
//
//  Created by Patka on 24/04/2024.
//

import SwiftUI

struct InfoGridView: View {
    
    let title1: String
    let title2: String
    let title3: String
    let title4: String
    let title5: String?
    let title6: String?
    let info1: String
    let info2: String
    let info3: String
    let info4: String
    let info5: String?
    let info6: String?
    
    let font: Font
    let spacing: CGFloat?
    
    var body: some View {
        HStack (spacing: spacing) {
            leftColumn
            rightColumn
        }
        .font(font)
    }
}

struct  InfoGridView_Previews: PreviewProvider {
    static var previews: some View {
        InfoGridView(
            title1: Constants.actor,
            title2: Constants.eyeColor,
            title3: Constants.hairColor,
            title4: Constants.ancestry,
            title5: Constants.patronus,
            title6: Constants.wizard,
            info1: dev.character.actor,
            info2: dev.character.eyeColour,
            info3: dev.character.hairColour,
            info4: dev.character.ancestry,
            info5: dev.character.patronus,
            info6: dev.character.wizard.description,
            font: .title,
            spacing: 50
        )
    }
}

extension InfoGridView {
    
    private var leftColumn: some View {
        VStack (alignment: .leading, spacing: 25) {
            Text(title1)
            Text(title2)
            Text(title3)
            Text(title4)
            if let title5 = title5,
               let title6 = title6 {
                Text(title5)
                Text(title6)
            }
        }
    }
    
    private var rightColumn: some View {
        VStack (alignment: .leading, spacing: 25) {
            Text(info1)
            Text(info2)
            Text(info3)
            Text(info4)
            if let info5 = info5,
               let info6 = info6 {
                Text(info5)
                Text(info6)
            }
        }
    }
}
