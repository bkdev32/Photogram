//
//  ChangePasswordViewController.swift
//  Photogram
//
//  Created by Burhan Kaynak on 06/08/2021.
//

import UIKit
import FirebaseAuth

class ChangePasswordViewController: UIViewController {
    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    let session = Session()
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == P.Segue.changePasswordToLogIn {
            let destination = segue.destination as! SignInViewController
            destination.dismissVC = true
        }
    }
    
    @IBAction func changePasswordButton(_ sender: UIButton) {
        guard let email = userDefaults.string(forKey: "email") else {
            performSegue(withIdentifier: P.Segue.changePasswordToLogIn, sender: self)
            return
        }
        
        guard let currentPassword = currentPasswordTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text else {
            return
        }
        
        if password.isEmpty && confirmPassword.isEmpty {
            makeAlert(title: "Error", message: "Please enter a valid password")
        } else if password != confirmPassword {
            makeAlert(title: "Error", message: "The passwords are not matching")
        } else {
            let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
            session.reauthenticate(with: credential) { [self] result, error in
                if let error = error {
                    makeAlert(title: "Error", message: error.localizedDescription)
                } else {
                    session.updatePassword(with: password)
                    makeAlert(title: "Success", message: "Your password has been updated", popToVC: true)
                    currentPasswordTextField.text = ""
                    passwordTextField.text = ""
                    confirmPasswordTextField.text = ""
                }
            }
        }
    }
    
    @IBAction func forgotPasswordButton(_ sender: UIButton) {
        performSegue(withIdentifier: "changeToForgot", sender: self)
    }
}
