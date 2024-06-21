//
//  Background.swift
//  HarryPotterLand
//
//  Created by Patka on 21/06/2024.
//

import SwiftUI

struct Background: View {
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [
                    Color(
                        Constants.Colors.hufflepuffLightBrown
                    ).opacity(0.6),
                    Color(
                        Constants.Colors.ravenclawBlue
                    )
                ],
                center: .topTrailing,
                startRadius: 5,
                endRadius: 1700
            )
            
            Image(Constants.Images.hogwartsLogo)
                .withCustomImageModifier(frameWidth: UIScreen.main.bounds.width)
                .opacity(0.25)
                .offset(y: -90)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    Background()
}
