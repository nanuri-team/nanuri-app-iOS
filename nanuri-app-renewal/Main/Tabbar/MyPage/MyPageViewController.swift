//
//  MyPageViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit

final class MyPageViewController: UIViewController {
    
    private let productListTableView = UITableView()
    private let myPageHeaderView: MyPageHeaderView = {
        let view = MyPageHeaderView()
        return view
    }()
    private let myPageSectionHeaderView: MyPageSectionHeaderView = {
        let view = MyPageSectionHeaderView()
        return view
    }()
    private let emptyNotiView: EmptyNotiView = EmptyNotiView()
    private var isTappedProductListButton: Bool = false
    let indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .nanuriGreen
        indicator.style = .large
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
        return indicator
    }()
    var userInfo: UserInfo?
    var userPostList: [ResultInfo] = []
    var userParticipatedPostsList: [ResultInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        networkSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        networkSetup()
    }
    
    func networkSetup() {
        self.indicatorView.startAnimating()
        NetworkService.shared.getUserInfoRequest { userInfo in
            self.userInfo = userInfo
            DispatchQueue.main.async {
                if userInfo.profile != "" {
                    let profileURL = userInfo.profile
                    guard let imageURL = URL(string: profileURL),
                          let imageData = try? Data(contentsOf: imageURL)
                    else { return }
                    self.myPageHeaderView.profileImageView.image = UIImage(data: imageData)
                }
                self.myPageHeaderView.profileNameLabel.text = userInfo.nickName
                userInfo.location.currentLocation(userInfo: userInfo) { location in
                    self.myPageHeaderView.locationTagView.productLocationLabel.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: location, lineHeight: 14)
                }
                
                self.indicatorView.stopAnimating()
            }
            self.getMyProductInfo(userInfo: userInfo)
        }
    }
    
    func getMyProductInfo(userInfo: UserInfo) {
        for post in userInfo.posts {
            Networking.sharedObject.getSinglePost(postUuid: post) { response in
                self.userPostList.append(response)
                DispatchQueue.main.async {
                    if self.userPostList.count == 0 {
                        self.emptyNotiView.isHidden = false
                    } else {
                        self.emptyNotiView.isHidden = true
                    }
                    self.productListTableView.reloadData()
                }
            }
        }
    }
    
    func getParticipatedProductInfo(userInfo: UserInfo) {
        for post in userInfo.participatedPosts {
            Networking.sharedObject.getSinglePost(postUuid: post) { response in
                self.userParticipatedPostsList.append(response)
                DispatchQueue.main.async {
                    if self.userParticipatedPostsList.count == 0 {
                        self.emptyNotiView.isHidden = false
                    } else {
                        self.emptyNotiView.isHidden = true
                    }
                    self.productListTableView.reloadData()
                }
            }
        }
    }
    
    private func setUpView() {
        self.title = "마이페이지"
        let settingButton = UIBarButtonItem(image: UIImage(named: "setting_ic"), style: .plain, target: self, action: #selector(selectSettingButton))
        self.navigationItem.setRightBarButton(settingButton, animated: true)
        
        productListTableView.delegate = self
        productListTableView.dataSource = self
        productListTableView.separatorInset = .zero
        productListTableView.separatorStyle = .none
        productListTableView.sectionHeaderTopPadding = 0
        productListTableView.register(MainProductTableViewCell.self, forCellReuseIdentifier: MainProductTableViewCell.cellId)
        self.view.addSubview(productListTableView)
        productListTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 95))
        productListTableView.tableHeaderView = headerView
        
        headerView.addSubview(myPageHeaderView)
        myPageHeaderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        myPageHeaderView.profileModifyButton.addTarget(self, action: #selector(clickModifyButtonTapped), for: .touchUpInside)
        
        self.view.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.view.bringSubviewToFront(indicatorView)
        
        // 상품이 없을때
        productListTableView.addSubview(emptyNotiView)
        emptyNotiView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
        }
        emptyNotiView.emptyLabel.text = "상품이 없습니다"
        emptyNotiView.emptyDescriptionLabel.text = "공동 구매에 참여하거나 \n상품을 등록해보세요."
//        emptyNotiView.emptyImageView.image = UIImage(systemName: "")
    }
    
    // MARK: objc - Actions
    @objc func selectSettingButton(_ sender: UIButton) {
        let settingView = SettingViewController()
        settingView.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(settingView, animated: true)
    }
    
    @objc func selectMoreButton(_ sender: UIButton) {
        print("Continued..")
    }
    
    @objc func clickModifyButtonTapped(_ sender: UIButton) {
        guard let userInfo = userInfo else { return }
        let myProfileModifiedView = MyProfileModifiedViewController(userInfo: userInfo)
        myProfileModifiedView.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(myProfileModifiedView, animated:true)
    }
    
    @objc func registeredProductsListButtonTapped(_ sender: UIButton) {
        if isTappedProductListButton { // true
            isTappedProductListButton.toggle()
            myPageSectionHeaderView.registeredProductsListButton.setTitleColor(.nanuriGreen, for: .normal)
            myPageSectionHeaderView.registeredProductsListButton.setAttributedTitle(.attributeFont(font: .PBold, size: 13, text: "내가 등록한 상품", lineHeight: 15), for: .normal)
            myPageSectionHeaderView.clickedView.backgroundColor = .nanuriGreen
            myPageSectionHeaderView.participatedProductsListButton.setTitleColor(.nanuriGray5, for: .normal)
            myPageSectionHeaderView.participatedProductsListButton.setAttributedTitle(.attributeFont(font: .PMedium, size: 13, text: "내가 참여한 상품", lineHeight: 15), for: .normal)
            myPageSectionHeaderView.clickedView2.backgroundColor = .nanuriGray2
            DispatchQueue.main.async {
                self.productListTableView.reloadData()
            }
            myPageSectionHeaderView.numberOfListLabel.text = "전체 \(self.userPostList.count)개"
        }
    }
    
    @objc func participatedProductsListButtonTapped(_ sender: UIButton) {
        if isTappedProductListButton == false { // false
            isTappedProductListButton.toggle()
            myPageSectionHeaderView.registeredProductsListButton.setTitleColor(.nanuriGray5, for: .normal)
            myPageSectionHeaderView.registeredProductsListButton.setAttributedTitle(.attributeFont(font: .PMedium, size: 13, text: "내가 등록한 상품", lineHeight: 15), for: .normal)
            myPageSectionHeaderView.clickedView.backgroundColor = .nanuriGray2
            myPageSectionHeaderView.participatedProductsListButton.setTitleColor(.nanuriGreen, for: .normal)
            myPageSectionHeaderView.participatedProductsListButton.setAttributedTitle(.attributeFont(font: .PBold, size: 13, text: "내가 참여한 상품", lineHeight: 15), for: .normal)
            myPageSectionHeaderView.clickedView2.backgroundColor = .nanuriGreen
            DispatchQueue.main.async {
                self.productListTableView.reloadData()
            }
            myPageSectionHeaderView.numberOfListLabel.text = "전체 0개"
        }
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isTappedProductListButton {
            return self.userParticipatedPostsList.count
        } else {
            return self.userPostList.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .white
        
        header.addSubview(myPageSectionHeaderView)
        myPageSectionHeaderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        myPageSectionHeaderView.registeredProductsListButton.addTarget(self, action: #selector(registeredProductsListButtonTapped), for: .touchUpInside)
        myPageSectionHeaderView.participatedProductsListButton.addTarget(self, action: #selector(participatedProductsListButtonTapped), for: .touchUpInside)
        myPageSectionHeaderView.moreButton.addTarget(self, action: #selector(selectMoreButton), for: .touchUpInside)

        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isTappedProductListButton {
            let post = userParticipatedPostsList[indexPath.row]
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
        } else {
            
            let post = userPostList[indexPath.row]
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
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let productDetailViewController = ProductDetailViewController()
            productDetailViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(productDetailViewController, animated: true)
        }
    }
}
