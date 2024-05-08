//
//  OvalComponentView.swift
//  HarryPotterLand
//
//  Created by Patka on 08/05/2024.
//

import SwiftUI

struct OvalComponentView: View {
    
    let text: String
    
    var body: some View {
        Text(text)
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: 100, height: 20)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 4)
            )
            .shadow(
                color: .white.opacity(1),
                radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 0)
    }
}

#Preview {
    OvalComponentView(text: "Action")
}
