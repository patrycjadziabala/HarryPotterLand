//
//  User.swift
//  HarryPotterLand
//
//  Created by Patka on 17/07/2024.
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID = UUID()
    var login: String
    var password: String
    var age: Double
    var gender: String
    var userSignedIn: Bool
}
