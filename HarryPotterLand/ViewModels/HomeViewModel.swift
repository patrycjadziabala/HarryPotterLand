//
//  HomeViewModel.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    let imageLoader = ImageLoaderManager()
    
    func fetchHogwartsCastleImage() async {
        let image = try? await imageLoader.fetchHogwartsCastleImage()
        await MainActor.run {
            self.image = image
        }
    }
}
