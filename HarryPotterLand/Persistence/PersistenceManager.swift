//
//  PersistenceManager.swift
//  HarryPotterLand
//
//  Created by Patka on 17/07/2024.
//

import Foundation

class PersistenceManager: ObservableObject {
    
    var name: String = ""
    var password: String = ""
    var age: Int = 0
    var gender: String = ""

    var registrationSuccessful: Bool = false
    var errorMessage: String? = nil
    
    func registerUser() {
        guard let url = URL(string: "http://localhost:3000/users") else {
            self.errorMessage = "Invalid URL."
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newUser = User(name: name, password: password, age: age, gender: gender)
        
        do {
            let jsonData = try JSONEncoder().encode(newUser)
            request.httpBody = jsonData
        } catch {
            self.errorMessage = "Failed to encode user data."
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received."
                }
                return
            }
            
            do {
                let registeredUser = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    self.registrationSuccessful = true
                    print("Registered user: \(registeredUser)")
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to decode response."
                }
            }
        }
        
        task.resume()
    }
}
