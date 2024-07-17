//
//  View+TextField.swift
//  HarryPotterLand
//
//  Created by Patka on 17/07/2024.
//

import SwiftUI

extension View {
    func customTextFieldStyle(isFocused: FocusState<Bool>.Binding) -> some View {
        self
            .autocorrectionDisabled(true)
            .keyboardType(.asciiCapable)
            .font(.custom(Constants.Fonts.fontDumbledor, size: 25))
            .kerning(2)
            .frame(height: 55)
            .padding(.horizontal)
            .foregroundStyle(.brown)
            .shadow(radius: 1)
            .background(.white)
            .cornerRadius(10)
            .focused(isFocused)
            .transition(.opacity)
    }
}
