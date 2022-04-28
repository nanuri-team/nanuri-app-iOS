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
        self.tabBar.tintColor = .nanuriGreen
        
        let homeNavigationController = UINavigationController(rootViewController: HomeViewController())
        let neighbourhoodNavigationController = UINavigationController(rootViewController: NeighbourhoodViewController())
        let chattingNavigationController = UINavigationController(rootViewController: ChattingListTableViewController())
        let bookmarkNavigationController = UINavigationController(rootViewController: BookmarkTableViewController())
        let myPageNavigationController = UINavigationController(rootViewController: MyPageViewController())
        
        setViewControllers([homeNavigationController, neighbourhoodNavigationController, chattingNavigationController, bookmarkNavigationController, myPageNavigationController], animated: false)
        
        
        // tabbar
        let homeTabbarItem = UITabBarItem(title: "홈", image: UIImage(named: "home_ic"), selectedImage:  UIImage(named: "home_select_ic"))
        homeNavigationController.tabBarItem = homeTabbarItem
        
        let neighbourhoodTabbarItem = UITabBarItem(title: "내 주변", image: UIImage(named: "neighbourhood_ic"), selectedImage:  UIImage(named: "neighbourhood_select_ic"))
        neighbourhoodNavigationController.tabBarItem = neighbourhoodTabbarItem
        
        let chattingTabbarItem = UITabBarItem(title: "채팅", image: UIImage(named: "chatting_ic"), selectedImage:  UIImage(named: "chatting_select_ic"))
        chattingNavigationController.tabBarItem = chattingTabbarItem
        
        let bookmarkTabbarItem = UITabBarItem(title: "즐겨찾기", image: UIImage(named: "favorite_tabbar_ic"), selectedImage:  UIImage(named: "favorite_select_ic"))
        bookmarkNavigationController.tabBarItem = bookmarkTabbarItem
        
        let myPageTabbarItem = UITabBarItem(title: "마이페이지", image: UIImage(named: "mypage_ic"), selectedImage:  UIImage(named: "mypage_select_ic"))
        myPageNavigationController.tabBarItem = myPageTabbarItem
    }

}


