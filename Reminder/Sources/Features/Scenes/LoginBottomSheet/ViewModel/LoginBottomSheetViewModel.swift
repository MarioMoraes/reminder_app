//
//  LoginBottomSheetViewModel.swift
//  Reminder
//
//  Created by Mario Moraes on 22/12/24.
//

import Foundation
import Firebase

class LoginBottomSheetViewModel {
    var successResult: ((String) -> Void)?
    var errorResult: ((String) -> Void)?
    
    func doAuth(user: String, password: String){
        print(user)
        Auth.auth().signIn(withEmail: user, password: password){ [weak self] authResult, error in
            if let error = error {
                self?.errorResult?("Error ao Logar! Verifiquei suas credenciais!")
            } else {
                self?.successResult?(user)
            }
        }
    }
}
