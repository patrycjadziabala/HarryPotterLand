//
//  WelcomeView.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack (spacing: 80) {
            Text(Constants.titleHarryPotterLand)
                .font(Font.custom(Constants.fontHPWelcomeScreen, size: 100))
                .kerning(2)
                .multilineTextAlignment(.center)
            Button {
                //                HomeView()
            } label: {
                VStack {
                    Image(Constants.hogwartsCastleCartoon)
                        .withCustomImageModifier(frameWidth: 155)
                        .cornerRadius(90)
                    Capsule()
                        .fill(Color.white)
                        .frame(width: 75, height: 75)
                        .shadow(radius: 10)
                        .overlay(
                            Text("Enter")
                                )
                }
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
