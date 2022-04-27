//
//  NeighbourhoodViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit

class NeighbourhoodViewController: UIViewController {
    
    let neighbourhoodTableView = UITableView()
    let noSettingLocationView = UIView()
    
    var collectionCellWidth = 120
    var collectionCellHeight = 163
    let ratioWidth = UIScreen.main.bounds.width
    var filterButtonArray: [FilterButton] = []
    var filterCount = 6 + 1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let locationButton = UIButton()
        locationButton.setImage(UIImage(named: "place_black_ic"), for: .normal)
        locationButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        locationButton.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: "현 위치", lineHeight: 18), for: .normal)
        locationButton.addTarget(self, action: #selector(selectLocationButton), for: .touchUpInside)
        
        let location = UIBarButtonItem(customView: locationButton)
        let notificationButton = UIBarButtonItem(image: UIImage(named: "notification_ic"), style: .plain, target: self, action: #selector(selectNotificationButton))
        
        self.navigationItem.setLeftBarButton(location, animated: true)
        self.navigationItem.setRightBarButton(notificationButton, animated: true)
        
//        setUpNoSettingView()
        
        // filter button
        for i in 0..<filterCount {
            let filterButton = FilterButton(filterType: i)
            filterButton.tag = i
            filterButton.isSelected = false
            filterButton.addTarget(self, action: #selector(selectFilterButton), for: .touchUpInside)
            filterButtonArray.append(filterButton)
        }
        
//        setUpNoSettingView()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
    
    func setUpNoSettingView() {
        let wrapView = UIView()
        self.view.addSubview(wrapView)
        wrapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        wrapView.addSubview(noSettingLocationView)
        
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
        
        let headerView = UIView()
        let headerViewHeight = collectionCellHeight + 30 + 40 + 30
        headerView.frame = CGRect(x: 0, y: 0, width: Int(ratioWidth), height: headerViewHeight)
        
        let hotItemTitleLabel = UILabel()
        hotItemTitleLabel.attributedText = .attributeFont(font: .PBold, size: 17, text: "내 주변 인기 상품", lineHeight: 20.4)
        headerView.addSubview(hotItemTitleLabel)
        hotItemTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.right.left.equalToSuperview().inset(16)
        }
        
        let layout = UICollectionViewFlowLayout()
        let neighbourhoodCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        neighbourhoodCollectionView.delegate = self
        neighbourhoodCollectionView.dataSource = self
        neighbourhoodCollectionView.register(VerticalProductCollectionViewCell.self, forCellWithReuseIdentifier: VerticalProductCollectionViewCell.cellId)
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
        
        neighbourhoodTableView.delegate = self
        neighbourhoodTableView.dataSource = self
        neighbourhoodTableView.separatorInset = .zero
        neighbourhoodTableView.separatorStyle = .none
        neighbourhoodTableView.tableHeaderView = headerView
        neighbourhoodTableView.register(MainProductTableViewCell.self, forCellReuseIdentifier: MainProductTableViewCell.cellId)
        self.view.addSubview(neighbourhoodTableView)
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
        return 10
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
                        make.right.equalToSuperview()
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

extension NeighbourhoodViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
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
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailViewController = ProductDetailViewController()
        productDetailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(productDetailViewController, animated: true)
    }
    
}
