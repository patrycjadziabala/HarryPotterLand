//
//  CircleButtonView.swift
//  HarryPotterLand
//
//  Created by Patka on 25/06/2024.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(.white.opacity(0.4))
            .frame(width: 75, height: 75)
            .shadow(
                color: .black.opacity(0.25),
                radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 0)
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            CircleButtonView(iconName: "arrowshape.right.circle.fill")
                .padding()
        }
    }
}
