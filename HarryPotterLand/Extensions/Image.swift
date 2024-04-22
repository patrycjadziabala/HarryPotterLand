//
//  Image.swift
//  HarryPotterLand
//
//  Created by Patka on 22/04/2024.
//

import Foundation
import SwiftUI

extension Image {
    func withCustomImageModifier(frameWidth: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFit()
            .frame(maxWidth: frameWidth, alignment: .center)
    }
}
