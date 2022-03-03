//
//  SettingsViewController.swift
//  Photogram
//
//  Created by Burhan Kaynak on 06/08/2021.
//

import UIKit

class SettingsViewController: UITableViewController {
    let session = Session()
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController!.navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logOutButton(_ sender: UIButton) {
        session.logOut()
        navigationController?.popToRootViewController(animated: true)
    }
}

extension SettingsViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                performSegue(withIdentifier: P.Segue.changeName, sender: self)
            } else if indexPath.row == 1 {
                performSegue(withIdentifier: P.Segue.changePassword, sender: self)
            }
        }
    }
}
