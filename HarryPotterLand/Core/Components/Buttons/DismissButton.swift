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
            Image(systemName: "xmark")
                .foregroundColor(.white)
                .font(.largeTitle)
                .padding(20)
                .frame(maxWidth: .infinity, alignment: alignment)
        }
    }
}

#Preview {
    DismissButton(alignment: .center)
}
