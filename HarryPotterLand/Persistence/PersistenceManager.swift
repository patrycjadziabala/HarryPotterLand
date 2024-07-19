//
//  PersistenceManager.swift
//  HarryPotterLand
//
//  Created by Patka on 17/07/2024.
//

import Foundation

protocol PersistenceManagerProtocol {
    func registerUser(login: String, password: String, age: Double, gender: String)
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void)
}

class PersistenceManager: ObservableObject, PersistenceManagerProtocol {
    
//    var login: String = ""
//    var password: String = ""
//    var age: Int = 0
//    var gender: String = ""

    var registrationSuccessful: Bool = false
    var errorMessage: String? = nil
    
    func registerUser(login: String, password: String, age: Double, gender: String) {
        guard let url = URL(string: "http://192.168.0.205:3000/users") else {
            self.errorMessage = "Invalid URL."
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newUser = User(login: login, password: password, age: age, gender: gender, userSignedIn: false)
        
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
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
           guard let url = URL(string: "http://192.168.0.205:3000/users") else {
               completion(.failure(NSError(domain: "PersistenceManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
               return
           }
           
           var request = URLRequest(url: url)
           request.httpMethod = "GET"
           
           let task = URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   completion(.failure(error))
                   return
               }
               
               guard let data = data else {
                   completion(.failure(NSError(domain: "PersistenceManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                   return
               }
               
               do {
                   let user = try JSONDecoder().decode([User].self, from: data)
                   completion(.success(user))
               } catch {
                   completion(.failure(error))
               }
           }
           
           task.resume()
       }
}
