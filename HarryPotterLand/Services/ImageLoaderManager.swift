//
//  ImageLoaderManager.swift
//  HarryPotterLand
//
//  Created by Patka on 12/03/2024.
//

import Foundation
import SwiftUI

protocol ImageLoaderManagerProtocol {
    func fetchHogwartsCastleImage() async throws -> UIImage?
}

class ImageLoaderManager: ImageLoaderManagerProtocol {
    
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
        guard let hogwartsCastleImage = Constants.Images.hogwartsCastleImageUrl else {
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
