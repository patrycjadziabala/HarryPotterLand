//
//  ViewModifiers.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import Foundation
import SwiftUI

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

