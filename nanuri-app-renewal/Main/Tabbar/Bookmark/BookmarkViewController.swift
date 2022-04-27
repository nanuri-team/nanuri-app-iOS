//
//  BookmarkViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit

class BookmarkTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = .nanuriGray3
        
        //self.navigationController?.navigationBar.barTintColor = .nanuriOrange
        self.view.backgroundColor = .white
        self.title = "즐겨찾기"
        
        let searchButton = UIButton()
        searchButton.setImage(UIImage(named: "search_ic"), for: .normal)
        searchButton.addTarget(self, action: #selector(actChangeSearchBar), for: .touchUpInside)
        let search = UIBarButtonItem(customView: searchButton)
        self.navigationItem.setRightBarButton(search, animated: true)
        
        let separateView = UIView()
        separateView.backgroundColor = .nanuriGray2
        self.view.addSubview(separateView)
        separateView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(92)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        self.tableView.separatorInset = .zero
        self.tableView.separatorStyle = .none
        
        let bookmarkTableView = UITableView()
        bookmarkTableView.delegate = self
        bookmarkTableView.dataSource = self

        bookmarkTableView.sectionHeaderTopPadding = .zero
        bookmarkTableView.register(MainProductTableViewCell.self, forCellReuseIdentifier: MainProductTableViewCell.cellId)
        self.view.addSubview(bookmarkTableView)
        bookmarkTableView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

    }

    @objc func actChangeSearchBar() {
        let searchVC = SearchViewController()
        searchVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(searchVC, animated: true)
        print("moved SearchBar")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "\(indexPath.row)"
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            return reuseCell
        } else {
            let cell = MainProductTableViewCell.init(style: .default, reuseIdentifier: identifier)
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailViewController = ProductDetailViewController()
        productDetailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(productDetailViewController, animated: true)
    }

}
/*
extension BookmarkViewController: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "\(indexPath.row)"
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            return reuseCell
        } else {
            let cell = MainProductTableViewCell.init(style: .default, reuseIdentifier: identifier)
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailViewController = ProductDetailViewController()
        productDetailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(productDetailViewController, animated: true)
    }
}

 */
