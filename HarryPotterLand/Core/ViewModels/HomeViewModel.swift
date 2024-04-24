//
//  HomeViewModel.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import Foundation
import SwiftUI

@MainActor class HomeViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let imageLoader = ImageLoaderManager()
    var apiManager: APIManagerProtocol = APIManager()
    @Published var characters: [CharacterModel] = []
    
    func fetchHogwartsCastleImage() async {
        let image = try? await imageLoader.fetchHogwartsCastleImage()
        await MainActor.run {
            self.image = image
        }
    }
    
    func fetchCharacters() async throws {
        guard let downloadedData: [CharacterModel] = try await apiManager.fetchCharacters() else {
            return
        }
        characters = downloadedData
    }
}
