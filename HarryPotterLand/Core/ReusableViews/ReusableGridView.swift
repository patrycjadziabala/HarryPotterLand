//
//  ReusableGridView.swift
//  HarryPotterLand
//
//  Created by Patka on 15/03/2024.
//

import SwiftUI

struct ReusableGridView: View {
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 3, alignment: nil),
        GridItem(.flexible(), spacing: 3, alignment: nil),
        GridItem(.flexible(), spacing: 3, alignment: nil),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 3) {
                ForEach(0..<50) { index in
                    RoundedRectangle(cornerRadius: 25)
                        .fill(Color.gray)
                        .frame(height: UIScreen.main.bounds.height * 0.2)
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
