//
//  Alert.swift
//  MessageMe
//
//  Created by Burhan Kaynak on 23/05/2021.
//

import UIKit

extension UIViewController {
    func makeAlert(title: String, message: String, popToVC: Bool = false) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let button = UIAlertAction(title: "OK", style: .default) { _ in
            if popToVC {
                self.navigationController?.popViewController(animated: true)
            }
        }
        alert.addAction(button)
        present(alert, animated: true, completion: nil)
    }
}
