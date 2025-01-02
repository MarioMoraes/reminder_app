//
//  UserDefaultManager.swift
//  Reminder
//
//  Created by Mario Moraes on 26/12/24.
//

import Foundation
import UIKit

class UserDefaultManager {
    private static var userKey = "userKey"
    private static var userNameKey = "userNameKey"
    private static var userImageKey = "userImageKey"
    
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
        UserDefaults.standard.removeObject(forKey: userNameKey)
        UserDefaults.standard.removeObject(forKey: userImageKey)
        UserDefaults.standard.synchronize()
    }
    
    static func saveUserName(user: String){
        UserDefaults.standard.set(user, forKey: userNameKey)
        UserDefaults.standard.synchronize()
    }
    
    static func loadUserName() -> String? {
        return UserDefaults.standard.string(forKey: userNameKey)
    }
    
    static func saveUserImage(image: UIImage){
        if let imageData = image.jpegData(compressionQuality: 1) {
            UserDefaults.standard.set(imageData, forKey: userImageKey)
        }
    }
    
    static func loadUserImage() -> UIImage? {
        if let imageData = UserDefaults.standard.data(forKey: userImageKey){
            return UIImage(data: imageData)
        }
        return UIImage(named: "user")
    }
}

