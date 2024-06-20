//
//  WelcomeScreenButton.swift
//  HarryPotterLand
//
//  Created by Patka on 20/06/2024.
//

import SwiftUI

struct WelcomeScreenButton: ButtonStyle {
    
    let offset: CGFloat = 5
    let text: String
    let performAction: (() -> Void)?
    
    func makeBody(configuration: Configuration) -> some View {
      
        ZStack {
            Circle()
                .fill(Color(Constants.Colors.ravenclawGrey))
                .offset(y: offset)
            
            Circle()
                .fill(Color(Constants.Colors.hufflepuffLightBrown))
                .offset(y: configuration.isPressed ? offset : 0)
               
                Text(text)
                    .font(.custom(Constants.Fonts.fontDumbledor, size: 20))
                    .offset(y: configuration.isPressed ? offset : 0)
                    .foregroundStyle(.white)
                    .shadow(radius: 2)
                    .multilineTextAlignment(.center)
        }
        .compositingGroup()
        .frame(width: 90, height: 90)
        .shadow(radius: 6, y: 4)
    }
}


struct WelcomeScreenButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("Enter") {
            
        }
        .frame(width: 50, height: 50)
        .foregroundColor(.white)
        .buttonStyle(WelcomeScreenButton(text: "Press and hold", performAction: {}))
    }
}
