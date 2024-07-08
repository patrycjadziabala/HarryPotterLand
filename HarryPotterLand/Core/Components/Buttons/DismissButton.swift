//
//  DismissButton.swift
//  HarryPotterLand
//
//  Created by Patka on 24/04/2024.
//

import SwiftUI

struct DismissButton: View {
    
    @Environment(\.dismiss) var dismiss
    let alignment: Alignment
    
    var body: some View {
        
        Button {
            dismiss()
        } label: {
            Image(systemName: Constants.Images.xMark)
                .foregroundColor(.white)
                .font(.largeTitle)
                .padding(20)
                .frame(width: 50, height: 50, alignment: alignment)
        }
    }
}

#Preview {
    ZStack {
        Color.black
        DismissButton(alignment: .center)
    }
}
