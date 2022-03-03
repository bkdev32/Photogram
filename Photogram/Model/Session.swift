//
//  Session.swift
//  MessageMe
//
//  Created by Burhan Kaynak on 23/05/2021.
//

import UIKit
import FirebaseAuth
import Firebase

class Session {
    let firebaseAuth = Auth.auth()
    let user = Auth.auth().currentUser
    let db = Firestore.firestore()
    let userDefaults = UserDefaults.standard
    var handle: AuthStateDidChangeListenerHandle?
    
    func signIn(_ email: String, _ password: String, handler: @escaping AuthDataResultCallback) {
        if userDefaults.string(forKey: "email") != nil {
            userDefaults.setValue(email, forKey: "email")
        }
        firebaseAuth.signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signUp(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        firebaseAuth.createUser(withEmail: email, password: password, completion: handler)
        userDefaults.setValue(email, forKey: "email")
    }
    
    func logOut() {
        do {
            try firebaseAuth.signOut()
        } catch let err as NSError {
            print("Error signing out:", err)
        }
    }
    
    func reauthenticate(with credential: AuthCredential, handler: @escaping AuthDataResultCallback) {
        user?.reauthenticate(with: credential, completion: handler)
    }
    
    func resetPassword(for email: String) {
        firebaseAuth.sendPasswordReset(withEmail: email) { error in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                print("Password reset email has been sent")
            }
        }
    }
    
    func updatePassword(with password: String) {
        user?.updatePassword(to: password) { error in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                print("Password has been updated")
            }
        }
    }
    
    func setDisplayName(with newDisplayName: String) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = newDisplayName
        changeRequest?.commitChanges { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
