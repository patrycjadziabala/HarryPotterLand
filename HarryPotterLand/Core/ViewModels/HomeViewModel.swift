//
//  HomeViewModel.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import Foundation
import SwiftUI
import Combine

@MainActor class HomeViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let imageLoader = ImageLoaderManager()
    @Published var characters: [CharacterModel] = []
    var apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol)  {
        self.apiManager = apiManager
    }
    
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
