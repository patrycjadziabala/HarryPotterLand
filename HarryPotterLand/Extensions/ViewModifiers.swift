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
    let fontType: String
    let fontSize: CGFloat
    let alignment: Alignment
    let foregroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.custom(fontType, size: fontSize))
            .frame(maxWidth: .infinity, alignment: alignment)
            .foregroundStyle(foregroundColor)
    }
}

//MARK: - Extensions

extension View {
    func withCustomTitleTextFormatting(
        fontType: FontType,
        fontSize: CGFloat = 28,
        alignment: Alignment = .center,
        foregroundColor: Color = .white
    ) -> some View {
        let font = getFont(fontType: fontType)
        return modifier(CustomTitleTextModifier(fontType: font, fontSize: fontSize, alignment: alignment, foregroundColor: foregroundColor))
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

