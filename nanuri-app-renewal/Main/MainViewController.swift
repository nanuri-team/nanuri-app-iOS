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
        let tabbarController = TabBarController()
        tabbarController.modalTransitionStyle = .crossDissolve
        tabbarController.modalPresentationStyle = .fullScreen
        self.present(tabbarController, animated: false, completion: nil)
    }

}
