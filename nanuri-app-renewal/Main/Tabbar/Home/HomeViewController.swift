//
//  HomeViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit

class HomeViewController: UIViewController {
    

    let headerScrollView = UIScrollView()
    let allRegionTableView = UITableView()
    let pagerCount = UILabel()
    
    var sampleImageViewArray: [UIImageView] = []
    var collectionCellWidth = 120
    var collectionCellHeight = 163
    let ratioWidth = UIScreen.main.bounds.width
    var postsListArray: [ResultInfo] = []
    var deadlineImminentPostsArray: [ResultInfo] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        let leftNavigationBar = UIBarButtonItem(image: UIImage(named: "nanuri_header_logo")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
        self.navigationItem.setLeftBarButton(leftNavigationBar, animated: false)
        
        setUpView()
        getPostsList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPostsList()
    }
    
    
    //MARK: - Selector
    
    @objc func selectMoreButton() {
        let allRegionProductTableViewController = AllRegionProductTableViewController()
        allRegionProductTableViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(allRegionProductTableViewController, animated: true)
    }
    
    @objc func selectAddProductButton() {
        let addProductStepOneViewController = AddProductViewController()
        addProductStepOneViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(addProductStepOneViewController, animated: true)
    }
    
    func getPostsList() {
        Networking.sharedObject.getPostsList { response in
            let result = response.results
            self.postsListArray = []
            if result.count > 10 {
                for i in 0..<10 {
                    self.postsListArray.append(result[i])
                }
            } else {
                self.postsListArray = result
            }
            self.getDeadlineImminent(responsePost: response.results)
            self.allRegionTableView.reloadData()
        }
    }

    func getDeadlineImminent(responsePost: [ResultInfo]) {
        deadlineImminentPostsArray = []
        for i in 0..<responsePost.count {
            // post.waitedUntil?.dDaycalculator() ?? ""
            guard let integerWaitUnitl = Int(responsePost[i].waitedUntil?.dDaycalculator() ?? "0") else { return }
            print(integerWaitUnitl)
            if integerWaitUnitl <= 10 {
                deadlineImminentPostsArray.append(responsePost[i])
            }
        }
    }
    
    func setUpEventScrollView() {
        for _ in 0..<3 {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "promotion_banner")
            sampleImageViewArray.append(imageView)
        }
        
        for i in 0..<sampleImageViewArray.count {
            headerScrollView.addSubview(sampleImageViewArray[i])
            
            if i == 0 {
                sampleImageViewArray[i].snp.makeConstraints { make in
                    make.top.equalToSuperview()
                    make.bottom.equalToSuperview()
                    make.left.equalToSuperview()
                }
            } else {
                if i == sampleImageViewArray.count - 1 {
                    sampleImageViewArray[i].snp.makeConstraints { make in
                        make.top.equalToSuperview()
                        make.bottom.equalToSuperview()
                        make.left.equalTo(sampleImageViewArray[i - 1].snp.right)
                        make.right.equalToSuperview()
                    }
                } else {
                    sampleImageViewArray[i].snp.makeConstraints { make in
                        make.top.equalToSuperview()
                        make.bottom.equalToSuperview()
                        make.left.equalTo(sampleImageViewArray[i - 1].snp.right)
                    }
                }
            }
        }
    }

    func setUpView() {
        self.view.backgroundColor = .white
    
        let headerView = UIView()
        let headerViewHeight = collectionCellHeight + 30 + 40 + 187 + 32
        headerView.frame = CGRect(x: 0, y: 0, width: Int(ratioWidth), height: headerViewHeight)
        
        headerScrollView.delegate = self
        headerScrollView.contentSize = CGSize(width: headerScrollView.frame.width, height: headerScrollView.frame.height)
        headerScrollView.isPagingEnabled = true
        headerScrollView.showsHorizontalScrollIndicator = false
        headerView.addSubview(headerScrollView)
        headerScrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(187)
        }
        setUpEventScrollView()
        
        let pagerView = UIView()
        pagerView.backgroundColor = .black.withAlphaComponent(0.4)
        pagerView.layer.cornerRadius = 18 / 2
        headerView.addSubview(pagerView)
        pagerView.snp.makeConstraints { make in
            make.bottom.equalTo(headerScrollView.snp.bottom).inset(10)
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(42)
            make.height.equalTo(18)
        }
        
        pagerCount.attributedText = .attributeFont(font: .PMedium, size: 10, text: "1  /  \(sampleImageViewArray.count)", lineHeight: 10)
        pagerCount.textColor = .white
        pagerView.addSubview(pagerCount)
        pagerCount.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        let categoryTitleLabel = UILabel()
        categoryTitleLabel.attributedText = .attributeFont(font: .PBold, size: 17, text: "카테고리", lineHeight: 20)
        headerView.addSubview(categoryTitleLabel)
        categoryTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(headerScrollView.snp.bottom).inset(-32)
            make.right.left.equalToSuperview().inset(16)
        }
        
        let categoryView = UIView()
        headerView.addSubview(categoryView)
        categoryView.snp.makeConstraints { make in
            make.top.equalTo(categoryTitleLabel.snp.bottom).inset(-12)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        let lifeCategoryButton = CategoryButton(image: UIImage(named: "category_life_ic"), title: "생활용품")
        categoryView.addSubview(lifeCategoryButton)
        lifeCategoryButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
        }
        
        let foodCategoryButton = CategoryButton(image: UIImage(named: "category_bath_ic"), title: "음식")
        categoryView.addSubview(foodCategoryButton)
        foodCategoryButton.snp.makeConstraints { make in
            make.left.equalTo(lifeCategoryButton.snp.right).inset(-12)
        }
        
        let kitchenCategoryButton = CategoryButton(image: UIImage(named: "category_kitchen_ic"), title: "주방")
        categoryView.addSubview(kitchenCategoryButton)
        kitchenCategoryButton.snp.makeConstraints { make in
            make.left.equalTo(foodCategoryButton.snp.right).inset(-12)
        }
        
        let bathCategoryButton = CategoryButton(image: UIImage(named: "category_bath_ic"), title: "욕실")
        categoryView.addSubview(bathCategoryButton)
        bathCategoryButton.snp.makeConstraints { make in
            make.top.equalTo(lifeCategoryButton.snp.bottom).inset(-10)
            make.left.equalToSuperview().inset(16)
        }
        
        let noteCategoryButton = CategoryButton(image: UIImage(named: "category_note_ic"), title: "문구")
        categoryView.addSubview(noteCategoryButton)
        noteCategoryButton.snp.makeConstraints { make in
            make.top.equalTo(foodCategoryButton.snp.bottom).inset(-10)
            make.left.equalTo(bathCategoryButton.snp.right).inset(-12)
        }
        
        let etcCategoryButton = CategoryButton(image: UIImage(named: "category_etc_ic"), title: "기타")
        categoryView.addSubview(etcCategoryButton)
        etcCategoryButton.snp.makeConstraints { make in
            make.top.equalTo(kitchenCategoryButton.snp.bottom).inset(-10)
            make.left.equalTo(noteCategoryButton.snp.right).inset(-12)
        }
        
        allRegionTableView.delegate = self
        allRegionTableView.dataSource = self
        allRegionTableView.separatorInset = .zero
        allRegionTableView.separatorStyle = .none
        allRegionTableView.register(MainProductTableViewCell.self, forCellReuseIdentifier: MainProductTableViewCell.cellId)
        allRegionTableView.tableHeaderView = headerView
        self.view.addSubview(allRegionTableView)
        allRegionTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        let addProductButton = UIButton()
        addProductButton.setImage(UIImage(named: "plus_ic"), for: .normal)
        addProductButton.backgroundColor = .nanuriGreen
        addProductButton.layer.cornerRadius = 52 / 2
        self.view.addSubview(addProductButton)
        self.view.bringSubviewToFront(addProductButton)
        addProductButton.snp.makeConstraints { make in
            make.width.height.equalTo(52)
            make.bottom.equalToSuperview().inset(32)
            make.right.equalToSuperview().inset(24)
        }
        addProductButton.addTarget(self, action: #selector(selectAddProductButton), for: .touchUpInside)
    }

}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return postsListArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "cell") {
                return reuseCell
            } else {
                let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
                cell.selectionStyle = .none
                
                let allRegionTitleLabel = UILabel()
                allRegionTitleLabel.attributedText = .attributeFont(font: .PBold, size: 17, text: "전체 지역의 상품", lineHeight: 20)
                cell.contentView.addSubview(allRegionTitleLabel)
                allRegionTitleLabel.snp.makeConstraints { make in
                    make.left.equalToSuperview().inset(16)
                    make.top.equalToSuperview()
                }
                
                let moreButton = UIButton()
                moreButton.setAttributedTitle(.attributeFont(font: .PRegular, size: 13, text: "더보기", lineHeight: 13), for: .normal)
                moreButton.setImage(UIImage(named: "back_gray_ic"), for: .normal)
                moreButton.setTitleColor(.nanuriGray4, for: .normal)
                moreButton.semanticContentAttribute = .forceRightToLeft
                cell.contentView.addSubview(moreButton)
                moreButton.snp.makeConstraints { make in
                    make.right.equalToSuperview().inset(16)
                    make.top.equalToSuperview()
                    make.height.equalTo(30)
                }
                moreButton.addTarget(self, action: #selector(selectMoreButton), for: .touchUpInside)
                
                cell.contentView.snp.makeConstraints { make in
                    make.left.right.equalToSuperview()
                }
                return cell
            }
        } else {
            let post = postsListArray[indexPath.row]
            let identifier = "\(indexPath.row) \(post.uuid)"
            
            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
                return reuseCell
            } else {
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
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let productDetailViewController = ProductDetailViewController()
            productDetailViewController.postInfo = postsListArray[indexPath.row]
            productDetailViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(productDetailViewController, animated: true)
            
        }
    }
}


//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deadlineImminentPostsArray.count
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
        
        let post = deadlineImminentPostsArray[indexPath.row]
        
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
        productDetailViewController.hidesBottomBarWhenPushed = true
        productDetailViewController.postInfo = postsListArray[indexPath.row]
        self.navigationController?.pushViewController(productDetailViewController, animated: true)
    }
}


//MARK: - UIScrollViewDelegate

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x / scrollView.frame.size.width
        pagerCount.attributedText = .attributeFont(font: .PMedium, size: 10, text: "\(Int(round(value + 1)))  /  \(sampleImageViewArray.count)", lineHeight: 10)
        pagerCount.textColor = .white
    }
}
