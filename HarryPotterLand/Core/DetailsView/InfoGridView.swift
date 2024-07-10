//
//  InfoGridView.swift
//  HarryPotterLand
//
//  Created by Patka on 24/04/2024.
//

import SwiftUI

struct InfoGridView: View {
    
    let rows: [InfoGridRowModel]
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
                InfoGridRowModel(
                    title: Constants.Titles.actor,
                    info: dev.character.actor
                ),
                InfoGridRowModel(
                    title: Constants.Titles.eyeColor,
                    info: dev.character.eyeColour
                ),
                InfoGridRowModel(
                    title: Constants.Titles.hairColor,
                    info: dev.character.hairColour),
                InfoGridRowModel(
                    title: Constants.Titles.ancestry,
                    info: dev.character.ancestry),
                InfoGridRowModel(
                    title: Constants.Titles.patronus,
                    info: dev.character.patronus),
                InfoGridRowModel(
                    title: Constants.Titles.wizard,
                    info: dev.character.wizard.description)
            ],
            font: .title,
            spacing: 50
        )
    }
}
