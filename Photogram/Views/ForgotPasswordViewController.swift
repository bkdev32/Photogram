//
//  ForgotPasswordViewController.swift
//  Photogram
//
//  Created by Burhan Kaynak on 30/07/2021.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    let session = Session()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func forgotPasswordButton(_ sender: UIButton) {
        if let email = emailTextField.text {
            if !email.isEmpty {
                session.resetPassword(for: email)
                makeAlert(title: "Success", message: "A password reset email has been sent to \(email)", popToVC: true)
                emailTextField.text = ""
            } else {
                makeAlert(title: "Error", message: "Please enter a valid email address")
            }
        }
    }
}
