//
//  ViewModifiers.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import Foundation
import SwiftUI

enum ViewType {
    case movieDetails
    case characterDetails
}

enum FontType: String {
    case welcomeScreenFont
    case titleFont
    case textFont
}

struct CustomTitleTextModifier: ViewModifier {
    
    let fontSize: CGFloat
    let fontType: String
    let alignment: Alignment
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: alignment)
            .padding(.leading)
            .font(.custom(fontType, size: fontSize))
        //            .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .serif))
    }
}

//MARK: - Extensions

extension View {
    func withCustomTitleTextFormatting(
        fontSize: CGFloat = 28,
        fontType: FontType,
        alignment: Alignment = .leading
    ) -> some View {
        let font = getFont(fontType: fontType)
        return modifier(CustomTitleTextModifier(fontSize: fontSize, fontType: font, alignment: alignment))
    }
    
    func getFont(fontType: FontType) -> String {
        switch fontType {
        case .welcomeScreenFont:
            return Constants.Fonts.fontWelcomeScreen
        case .titleFont:
            return Constants.Fonts.fontDumbledor
        case .textFont:
            return Constants.Fonts.fontText
        }
    }
}

