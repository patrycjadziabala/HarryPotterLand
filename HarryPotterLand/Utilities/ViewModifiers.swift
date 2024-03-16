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

struct CustomTitleTextModifier: ViewModifier {
    
    let fontSize: Int
    let alignment: Alignment
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: alignment)
            .padding(.leading)
            .font(.system(size: CGFloat(fontSize), weight: .semibold, design: .serif))
    }
}

//MARK: - Extensions

extension View {
    func withCustomTitleTextFormatting(fontSize: Int = 28, alignment: Alignment = .leading) -> some View {
        modifier(CustomTitleTextModifier(fontSize: fontSize, alignment: alignment))
    }
}

