//
//  ImageLoaderManager.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import Foundation
import SwiftUI

class ImageLoaderManager {
//    let url = URL(string: "")!
    let hogwartsCastleImageUrl = URL(string: "https://upload.wikimedia.org/wikipedia/commons/b/b2/Hogwarts_-_Wizarding_World_of_Harry_Potter_-_Hollywood.jpg")
    
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard
            let data = data,
            let image = UIImage(data: data),
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        return image
    }
    
    func fetchHogwartsCastleImage() async throws -> UIImage? {
        guard let hogwartsCastleImage = hogwartsCastleImageUrl else {
            return nil
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: hogwartsCastleImage, delegate: nil)
            return handleResponse(data: data, response: response)
        } catch {
            throw error
        }
    }
    
}
