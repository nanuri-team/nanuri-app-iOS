//
//  BookmarkViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit

class BookmarkTableViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    let emptyNotiView: EmptyNotiView = EmptyNotiView()
    var favoritePostList: [ResultInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        getFavoritePosts()
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
        
        // 즐겨찾기한 상품이 없을때
        tableView.addSubview(emptyNotiView)
        emptyNotiView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        emptyNotiView.emptyLabel.text = "즐겨찾기한 상품이 없습니다"
        emptyNotiView.emptyDescriptionLabel.text = "공동 구매 상품들 중에서\n관심상품을 즐겨찾기 해보세요."
//        emptyNotiView.emptyImageView.image = UIImage(systemName: "")
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
    
    func getFavoritePosts() {
        NetworkService.shared.getUserInfoRequest { userInfo in
            for post in userInfo.favoritePosts {
                Networking.sharedObject.getSinglePost(postUuid: post) { response in
                    self.favoritePostList.append(response)
                    DispatchQueue.main.async {
                        if self.favoritePostList.count == 0 {
                            self.emptyNotiView.isHidden = false
                        } else {
                            self.emptyNotiView.isHidden = true
                        }
                    }
                }
            }
        }
    }
}

extension BookmarkTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoritePostList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = favoritePostList[indexPath.row]
        let identifier = "\(indexPath.row) \(post.uuid)"
        
        let cell = MainProductTableViewCell.init(style: .default, reuseIdentifier: identifier)
        cell.selectionStyle = .none
        
        cell.productImage.imageUpload(url: post.image?.replaceImageUrl() ?? "")
        cell.productName.attributedText = .attributeFont(font: .PRegular, size: 17, text: post.title, lineHeight: 20)
        cell.productLocationLabel.attributedText = .attributeFont(font: .NSRBold, size: 12, text: post.writerAddress ?? "", lineHeight: 14)
        cell.productPrice.attributedText = .attributeFont(font: .PBold, size: 16, text: "\(post.unitPrice.toPriceNumberFormmat())원", lineHeight: 19)
        cell.productPrice.textAlignment = .right
        cell.deliveryTagView.setDeliveryType(type: post.tradeType ?? "")
        
        cell.dDayTagView.setDday(dDay: post.waitedUntil?.dDaycalculator() ?? "")
        cell.totalRecruit.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "/\(post.maxParticipants)", lineHeight: 14)
        cell.productParticipant.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "\(post.numParticipants)", lineHeight: 14)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailViewController = ProductDetailViewController()
        productDetailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(productDetailViewController, animated: true)
    }
}
