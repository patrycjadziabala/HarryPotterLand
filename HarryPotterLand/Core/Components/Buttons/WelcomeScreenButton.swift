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
    let height: CGFloat?
    let width: CGFloat?
    let performAction: (() -> Void)?
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .foregroundColor(Color(Constants.Colors.ravenclawGrey))
                .offset(y: offset)
            
            Circle()
                .foregroundColor(Color(Constants.Colors.hufflepuffLightBrown).opacity(0.7))
                .offset(y: configuration.isPressed ? offset : 0)
            
            Text(text)
                .font(.custom(Constants.Fonts.fontDumbledor, size: 20))
                .offset(y: configuration.isPressed ? offset : 0)
                .foregroundStyle(.white)
                .shadow(radius: 2)
                .multilineTextAlignment(.center)
        }
        .compositingGroup()
        .frame(width: width ?? 90, height: height ?? 90)
        .shadow(radius: 6, y: 4)
    }
}

struct WelcomeScreenButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("Enter") {
            
        }
        .frame(width: 50, height: 50)
        .foregroundColor(.white)
        .buttonStyle(WelcomeScreenButton(text: "Go", height: 90, width: nil, performAction: {}))
    }
}
