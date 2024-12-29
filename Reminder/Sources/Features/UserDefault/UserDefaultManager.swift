//
//  UserDefaultManager.swift
//  Reminder
//
//  Created by Mario Moraes on 26/12/24.
//

import Foundation

class UserDefaultManager {
    private static var userKey = "userKey"
    
    static func saveUser(user: User){
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(user) {
            UserDefaults.standard.set(encoded, forKey: userKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    static func loadUser() -> User? {
        if let userData = UserDefaults.standard.data(forKey: "userKey"){
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: userData){
                return user
            }
        }
        return nil
    }
    
    static func removeUser(){
        UserDefaults.standard.removeObject(forKey: userKey)
        UserDefaults.standard.synchronize()
    }
}
