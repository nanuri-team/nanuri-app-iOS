//
//  BookmarkViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit

class BookmarkTableViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.title = "즐겨찾기"
        
        let searchButton = UIButton()
        searchButton.setImage(UIImage(named: "search_ic"), for: .normal)
        searchButton.addTarget(self, action: #selector(tappedSearchItem), for: .touchUpInside)
        let searchItem = UIBarButtonItem(customView: searchButton)
        
        let notificationButton = UIButton()
        notificationButton.setImage(UIImage(named: "notification_ic"), for: .normal)
        notificationButton.addTarget(self, action: #selector(tappedNotificationItem), for: .touchUpInside)
        let notificationItem = UIBarButtonItem(customView: notificationButton)
        
        self.navigationItem.rightBarButtonItems = [notificationItem, searchItem]
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(MainProductTableViewCell.self, forCellReuseIdentifier: MainProductTableViewCell.cellId)
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    @objc func tappedSearchItem() {
        let searchVC = SearchViewController()
        searchVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchVC, animated: true)
        print("moved SearchBar")
    }
    
    @objc func tappedNotificationItem() {
        let NotificationVC = NotificationViewController()
        NotificationVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(NotificationVC, animated: true)
        print("moved notification")
    }
}

extension BookmarkTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "\(indexPath.row)"
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            return reuseCell
        } else {
            let cell = SingleProductTableViewCell(reuseIdentifier: identifier)
            cell.selectionStyle = .none
            
            cell.dDayTagView.setDday(dDay: "10")
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailViewController = ProductDetailViewController()
        productDetailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(productDetailViewController, animated: true)
    }
}
