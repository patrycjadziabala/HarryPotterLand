//
//  UserManager.swift
//  HarryPotterLand
//
//  Created by Patka on 19/07/2024.
//

import Foundation

protocol UserManagerProtocol {
    var loggedInUser: User? { get set }
}

class UserManager: ObservableObject, UserManagerProtocol {
    
    @Published var loggedInUser: User?

}
