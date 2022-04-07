//
//  TabBarController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.tabBar.barTintColor = .white
        self.tabBar.isTranslucent = false
        
        let homeNavigationController = UINavigationController(rootViewController: SearchViewController())
        let neighbourhoodNavigationController = UINavigationController(rootViewController: NeighbourhoodViewController())
        let chattingNavigationController = UINavigationController(rootViewController: ChattingViewController())
        let bookmarkNavigationController = UINavigationController(rootViewController: BookmarkViewController())
        let myPageNavigationController = UINavigationController(rootViewController: MyPageViewController())
        
        setViewControllers([homeNavigationController, neighbourhoodNavigationController, chattingNavigationController, bookmarkNavigationController, myPageNavigationController], animated: false)
    }

}


