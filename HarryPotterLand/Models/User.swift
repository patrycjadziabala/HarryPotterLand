//
//  User.swift
//  HarryPotterLand
//
//  Created by Patka on 17/07/2024.
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID = UUID()
    let login: String
    let password: String
    let age: Int
    let gender: String
}
