//
//  HomeViewModel.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let imageLoader = ImageLoaderManager()
    @Published var characters: [CharacterModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchCharacters()
    }
    
    func fetchHogwartsCastleImage() async {
        let image = try? await imageLoader.fetchHogwartsCastleImage()
        await MainActor.run {
            self.image = image
        }
    }
    
    func fetchCharacters() {
        guard let url = URL(string: "https://hp-api.onrender.com/api/characters") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [CharacterModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] (returnedCharacters) in
                self?.characters = returnedCharacters
            })
            .store(in: &cancellables)
    }
}
