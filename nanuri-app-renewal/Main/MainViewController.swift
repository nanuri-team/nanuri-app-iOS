//
//  MainViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        getMainViewController()
    }
    
    func getLoginViewController() {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        self.present(loginViewController, animated: false)
    }
    
    func getHomeViewController() {
        let tabbarController = TabBarController()
        tabbarController.modalPresentationStyle = .fullScreen
        self.present(tabbarController, animated: false, completion: nil)
    }
   
//    func getMainViewController() {
//        // Login view - 로그인 값 없으면 LoginViewController, 있으면 HomeViewController
//        let window = UIWindow(windowScene: windowScene)
//        if UserDefaults.standard.integer(forKey: "userID") == 0 {
//            let loginVC = UIWindow(windowScene: LoginViewController())
//            self.present(loginVC, animated: true)
//
//            window.rootViewController = LoginViewController()
//        } else {
//            window.rootViewController = HomeViewController()
//        }
//    }

//    override func viewDidAppear(_ animated: Bool) {
//        let tabbarController = MainViewController()
//        tabbarController.modalTransitionStyle = .crossDissolve
//        tabbarController.modalPresentationStyle = .fullScreen
//        self.present(tabbarController, animated: false, completion: nil)
//
//
//    }

}
