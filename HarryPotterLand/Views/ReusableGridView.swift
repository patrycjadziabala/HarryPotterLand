//
//  ReusableGridView.swift
//  HarryPotterLand
//
//  Created by Patka on 15/03/2024.
//

import SwiftUI

struct ReusableGridView: View {
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil),

    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(0..<50) { index in
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.gray)
                        .frame(height: 150)
                }
            }
        }
    }
}

struct ReusableGridView_Previews: PreviewProvider {
    static var previews: some View {
        ReusableGridView()
    }
}
