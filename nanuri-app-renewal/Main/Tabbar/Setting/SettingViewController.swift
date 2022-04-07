//
//  SettingViewController.swift
//  nanuri-app-renewal
//
//  Created by a0000 on 2022/04/05.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tabbarController = TabBarController()
        tabbarController.modalTransitionStyle = .crossDissolve
        tabbarController.modalPresentationStyle = .fullScreen
        self.present(tabbarController, animated: false, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
