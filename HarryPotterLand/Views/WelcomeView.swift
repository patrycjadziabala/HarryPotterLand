//
//  WelcomeView.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        Text(Constants.titleHarryPotterLand)
            .font(Font.custom(Constants.fontHPWelcomeScreen, size: 100))
            .kerning(2)
            .multilineTextAlignment(.center)
        Button {
            ""
        } label: {
            Text("Enter")
        }

    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
