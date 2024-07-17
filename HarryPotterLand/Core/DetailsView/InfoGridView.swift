//
//  InfoGridView.swift
//  HarryPotterLand
//
//  Created by Patka on 24/04/2024.
//

import SwiftUI

struct InfoGridView: View {
    
    let rows: [InfoGridRow]
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

extension InfoGridView {
    
    private var leftColumn: some View {
        VStack (alignment: .leading, spacing: 25) {
            ForEach(rows) { row in
                Text(row.title)
            }
        }
    }
    
    private var rightColumn: some View {
        VStack (alignment: .leading, spacing: 25) {
            ForEach(rows) { row in
                Text(row.info)
            }
        }
    }
}

struct  InfoGridView_Previews: PreviewProvider {
    static var previews: some View {
        InfoGridView(
            rows: [
                InfoGridRow(
                    title: Constants.Titles.actor,
                    info: dev.character.actor
                ),
                InfoGridRow(
                    title: Constants.Titles.eyeColor,
                    info: dev.character.eyeColour
                ),
                InfoGridRow(
                    title: Constants.Titles.hairColor,
                    info: dev.character.hairColour),
                InfoGridRow(
                    title: Constants.Titles.ancestry,
                    info: dev.character.ancestry),
                InfoGridRow(
                    title: Constants.Titles.patronus,
                    info: dev.character.patronus),
                InfoGridRow(
                    title: Constants.Titles.wizard,
                    info: dev.character.wizard.description)
            ],
            font: .title,
            spacing: 50
        )
    }
}
