//
//  NeighbourhoodViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit
import CoreLocation

class NeighbourhoodViewController: UIViewController {
    
    var neighbourhoodTableView = UITableView()
    let noSettingLocationView = UIView()
    var neighbourhoodCollectionView: UICollectionView!
    let locationButton = UIButton()
    var wrapView = UIView()
    var noSettingWrapView = UIView()
    
    var collectionCellWidth = 120
    var collectionCellHeight = 163
    let ratioWidth = UIScreen.main.bounds.width
    var filterButtonArray: [FilterButton] = []
    var filterCount = 6 + 1
    var postsListArray: [ResultInfo] = []
    var userInfo: UserInfo?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        locationButton.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: "현 위치", lineHeight: 18), for: .normal)
        locationButton.setImage(UIImage(named: "place_black_ic"), for: .normal)
        locationButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        locationButton.addTarget(self, action: #selector(selectLocationButton), for: .touchUpInside)
        
        let location = UIBarButtonItem(customView: locationButton)
        let notificationButton = UIBarButtonItem(image: UIImage(named: "notification_ic"), style: .plain, target: self, action: #selector(selectNotificationButton))
        
        self.navigationItem.setLeftBarButton(location, animated: true)
        self.navigationItem.setRightBarButton(notificationButton, animated: true)
        
        // filter button
        for i in 0..<filterCount {
            let filterButton = FilterButton(filterType: i)
            filterButton.tag = i
            filterButton.isSelected = false
            filterButton.addTarget(self, action: #selector(selectFilterButton), for: .touchUpInside)
            filterButtonArray.append(filterButton)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserInfo()
    }
    
    @objc func selectLocationButton() {
        let locationPermissionViewController = LocationPermissionViewController()
        locationPermissionViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(locationPermissionViewController, animated: true)
        print("click")
    }
    
    @objc func selectNotificationButton() {
        print("noti")
    }
    
    @objc func selectFilterButton(sender: UIButton) {
        print(sender.tag)
        for i in 0..<filterButtonArray.count {
            filterButtonArray[i].isSelected = false
        }
        
        filterButtonArray[sender.tag].isSelected = true
    }
    
    
    
    func CheckMyLocation() {
        guard let userInfo = userInfo else {
            return
        }
        
        let location = splitLocation(location: userInfo.location)
        let myLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        geocoder.reverseGeocodeLocation(myLocation, preferredLocale: locale) { (place, error) in
            guard let placemark = place?.last,
                  let locality = placemark.locality,
                  let subLocality = placemark.subLocality
           else { return }
            
            self.locationButton.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: "\(subLocality)", lineHeight: 18), for: .normal)
        }
    }
    
    func getUserInfo() {
        NetworkService.shared.getUserInfoRequest { userInfo in
            self.userInfo = userInfo
            DispatchQueue.main.async {
                self.CheckMyLocation()
                self.settingView()
            }
        }
    }
    
    func settingView() {
        guard let userInfo = userInfo else { return }
        
        if userInfo.location == "" {
            self.noSettingWrapView.removeFromSuperview()
            self.locationButton.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: "현 위치", lineHeight: 18), for: .normal)
            self.setUpNoSettingView()
        } else {
            self.wrapView.removeFromSuperview()
            self.setUpView()
            self.getPostsList()
        }
    }
    
    func getPostsList() {
        Networking.sharedObject.getPostsList { response in
            self.postsListArray = response.results
            self.neighbourhoodTableView.reloadData()
            self.neighbourhoodCollectionView.reloadData()
        }
    }
    
    func setUpNoSettingView() {
        noSettingWrapView = UIView()
        self.view.addSubview(noSettingWrapView)
        noSettingWrapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        noSettingWrapView.addSubview(noSettingLocationView)
        
        let locationImageView = UIImageView()
        locationImageView.image = UIImage(named: "location_large_ic")
        noSettingLocationView.addSubview(locationImageView)
        locationImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        let titleLabel = UILabel()
        titleLabel.attributedText = .attributeFont(font: .PBold, size: 24, text: "현 위치를 설정해주세요", lineHeight: 24)
        titleLabel.textColor = .nanuriGray3
        noSettingLocationView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(locationImageView.snp.bottom).inset(-17)
        }
        
        let descriptionLabel = UILabel()
        descriptionLabel.attributedText = .attributeFont(font: .PRegular, size: 15, text: "내 주변의 거래 상품을 보려면\n좌측 상단의 현 위치 버튼을 눌러 설정해야 합니다.", lineHeight: 22)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .nanuriGray3
        noSettingLocationView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-16)
            make.centerX.equalToSuperview()
        }
        
        noSettingLocationView.snp.makeConstraints { make in
            make.top.equalTo(locationImageView.snp.top)
            make.bottom.equalTo(descriptionLabel.snp.bottom)
            make.left.right.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
    
    func setUpView() {
    
        wrapView = UIView()
        self.view.addSubview(wrapView)
        wrapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let headerView = UIView()
        let headerViewHeight = collectionCellHeight + 30 + 40 + 30
        headerView.frame = CGRect(x: 0, y: 0, width: Int(ratioWidth), height: headerViewHeight)
        
        let hotItemTitleLabel = UILabel()
        hotItemTitleLabel.attributedText = .attributeFont(font: .PBold, size: 17, text: "내 주변 최근 상품", lineHeight: 20.4)
        headerView.addSubview(hotItemTitleLabel)
        hotItemTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.right.left.equalToSuperview().inset(16)
        }
        
        let layout = UICollectionViewFlowLayout()
        neighbourhoodCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        neighbourhoodCollectionView.delegate = self
        neighbourhoodCollectionView.dataSource = self
        neighbourhoodCollectionView.register(VerticalProductCollectionViewCell.self, forCellWithReuseIdentifier: VerticalProductCollectionViewCell.cellId)
        neighbourhoodCollectionView.showsHorizontalScrollIndicator = false
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        headerView.addSubview(neighbourhoodCollectionView)
        neighbourhoodCollectionView.snp.makeConstraints { make in
            make.top.equalTo(hotItemTitleLabel.snp.bottom).inset(-10)
            make.width.equalTo(ratioWidth)
            make.height.equalTo(collectionCellHeight)
        }
        
        let separatorView = UIView()
        separatorView.backgroundColor = .nanuriGray1
        headerView.addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(neighbourhoodCollectionView.snp.bottom).inset(-24)
            make.left.right.equalToSuperview()
            make.height.equalTo(16)
        }
        
        neighbourhoodTableView = UITableView()
        neighbourhoodTableView.delegate = self
        neighbourhoodTableView.dataSource = self
        neighbourhoodTableView.separatorInset = .zero
        neighbourhoodTableView.separatorStyle = .none
        neighbourhoodTableView.tableHeaderView = headerView
        neighbourhoodTableView.register(MainProductTableViewCell.self, forCellReuseIdentifier: MainProductTableViewCell.cellId)
        wrapView.addSubview(neighbourhoodTableView)
        neighbourhoodTableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
    }

}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension NeighbourhoodViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsListArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = .white
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 35)
        
        let filterScrollView = UIScrollView()
        filterScrollView.contentSize = CGSize(width: filterScrollView.frame.width, height: filterScrollView.frame.height)
        filterScrollView.showsHorizontalScrollIndicator = false
        filterScrollView.clipsToBounds = true
        headerView.addSubview(filterScrollView)
        filterScrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(5)
            make.width.equalToSuperview()
            make.height.equalTo(35)
        }
        
        for i in 0..<filterButtonArray.count {
            filterScrollView.addSubview(filterButtonArray[i])
            if i != 0 {
                // 마지막 버튼일 때
                if i == filterButtonArray.count - 1 {
                    filterButtonArray[i].snp.makeConstraints { make in
                        make.left.equalTo(filterButtonArray[i - 1].snp.right).inset(-6)
                        make.right.equalToSuperview().inset(16)
                    }
                } else { // 나머지 버튼
                    filterButtonArray[i].snp.makeConstraints { make in
                        make.left.equalTo(filterButtonArray[i - 1].snp.right).inset(-6)
                    }
                }
            } else { // 첫번째 버튼일 때
                filterButtonArray[i].snp.makeConstraints { make in
                    make.left.equalToSuperview().inset(16)
                }
            }
        }
       
        
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = postsListArray[indexPath.row]
        let identifier = "\(indexPath.row) \(post.uuid)"
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            return reuseCell
        } else {
            let cell = SingleProductTableViewCell(reuseIdentifier: identifier)
            cell.selectionStyle = .none
            
            cell.productImageView.imageUpload(url: post.image?.replaceImageUrl() ?? "")
            cell.productNameLabel.attributedText = .attributeFont(font: .PRegular, size: 17, text: post.title, lineHeight: 20)
            cell.productLocationLabel.attributedText = .attributeFont(font: .NSRBold, size: 12, text: post.writerAddress ?? "", lineHeight: 14)
            cell.productPriceLabel.attributedText = .attributeFont(font: .PBold, size: 16, text: "\(post.unitPrice.toPriceNumberFormmat())원", lineHeight: 19)
            cell.deliveryTagView.setDeliveryType(type: post.tradeType ?? "")
            
            cell.dDayTagView.setDday(dDay: post.waitedUntil?.dDaycalculator() ?? "")
            cell.totalRecruitLabel.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "/\(post.maxParticipants)", lineHeight: 14)
            cell.productParticipantLabel.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "\(post.numParticipants)", lineHeight: 14)
            
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetailViewController = ProductDetailViewController()
        productDetailViewController.postInfo = postsListArray[indexPath.row]
        productDetailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(productDetailViewController, animated: true)
    }
}

extension NeighbourhoodViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postsListArray.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionCellWidth, height: collectionCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalProductCollectionViewCell.cellId, for: indexPath) as? VerticalProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let post = postsListArray[indexPath.row]
        
        cell.productImageView.imageUpload(url: post.image?.replaceImageUrl() ?? "")
        cell.productName.attributedText = .attributeFont(font: .PRegular, size: 14, text: post.title, lineHeight: 17)
        cell.productPrice.attributedText = .attributeFont(font: .PBold, size: 11, text: "\(post.unitPrice.toPriceNumberFormmat())원", lineHeight: 13)
        cell.productPrice.textAlignment = .right
        cell.deliveryTagView.setDeliveryType(type: post.tradeType ?? "")
        
        cell.dDayTagView.setDday(dDay: post.waitedUntil?.dDaycalculator() ?? "")
        cell.totalRecruit.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "/\(post.maxParticipants)", lineHeight: 14)
        cell.productParticipant.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "\(post.numParticipants)", lineHeight: 14)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailViewController = ProductDetailViewController()
        productDetailViewController.postInfo = postsListArray[indexPath.row]
        productDetailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(productDetailViewController, animated: true)
    }
    
}
