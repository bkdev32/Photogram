//
//  ChangeUsernameViewController.swift
//  Photogram
//
//  Created by Burhan Kaynak on 06/08/2021.
//

import UIKit
import FirebaseAuth

class ChangeUsernameViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    let session = Session()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func changeUsernameButton(_ sender: UIButton) {
        if let newDisplayName = usernameTextField.text {
            session.setDisplayName(with: newDisplayName)
            makeAlert(title: "Success", message: "You have successfully changed your username", popToVC: true)
            usernameTextField.text = ""
        } else {
            makeAlert(title: "Error", message: "Please enter a valid username")
        }
    }
}
