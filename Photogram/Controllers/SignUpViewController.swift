//
//  SignUpViewController.swift
//  Photogram
//
//  Created by Burhan Kaynak on 26/07/2021.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    let session = Session()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        guard let email = emailTextField.text,
              let displayName = usernameTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text else {
            return
        }
        
        if !password.isEmpty && !confirmPassword.isEmpty {
            if password == confirmPassword {
                session.signUp(email: email, password: password) { [self] result, error in
                    if let error = error {
                        makeAlert(title: "Error", message: error.localizedDescription)
                    } else {
                        performSegue(withIdentifier: P.Segue.signUpToFeed, sender: self)
                    }
                    session.setDisplayName(with: displayName)
                }
            } else {
                makeAlert(title: "Error", message: "The passwords are not matching.")
            }
        } else {
            makeAlert(title: "Error", message: "Please enter a valid password")
        }
    }
}
