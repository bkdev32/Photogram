//
//  SignInViewController.swift
//  Photogram
//
//  Created by Burhan Kaynak on 26/07/2021.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let session = Session()
    var dismissVC = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func SignInButton(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            session.signIn(email, password) { [self] result, error in
                if let error = error {
                    makeAlert(title: "Error", message: error.localizedDescription)
                } else {
                    if dismissVC {
                        dismiss(animated: true, completion: nil)
                    } else {
                        performSegue(withIdentifier: P.Segue.signInToFeed, sender: self)
                    }
                }
            }
        } else {
            makeAlert(title: "Error", message: "Please enter a valid email address and password")
        }
    }
    
    @IBAction func forgotPasswordButton(_ sender: UIButton) {
        performSegue(withIdentifier: P.Segue.signInToForgotPass, sender: self)
    }
}
