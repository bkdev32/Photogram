//
//  SceneDelegate.swift
//  Photogram
//
//  Created by Burhan Kaynak on 11/06/2021.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var handle: AuthStateDidChangeListenerHandle?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        loadRootController()
    }
    
    func loadRootController() {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        handle = Auth.auth().addStateDidChangeListener { [self] (auth, user) in
            if user != nil {
                let tabBar = storyboard.instantiateViewController(identifier: "tabBar") as! UITabBarController
                tabBar.selectedIndex = 0
                window?.rootViewController = tabBar
            } else {
                let loginVC = storyboard.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
                let navigationVC = UINavigationController(rootViewController: loginVC)
                window?.rootViewController = navigationVC
            }
        }
        window?.makeKeyAndVisible()
    }
}
