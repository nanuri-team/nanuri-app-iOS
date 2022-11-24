//
//  HomeViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit

class HomeViewController: UIViewController {

    let headerScrollView = UIScrollView()
    let categoryScrollView = UIScrollView()
    let allRegionTableView = UITableView()
    let pagerCount = UILabel()
    let indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .nanuriGreen
        indicator.style = .large
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
        return indicator
    }()
    
    var sampleImageViewArray: [UIImageView] = []
    var collectionCellWidth = 120
    var collectionCellHeight = 163
    let ratioWidth = UIScreen.main.bounds.width
    var postsListArray: [ResultInfo] = []
    var deadlineImminentPostsArray: [ResultInfo] = []
    var categoryButtonArray: [UIButton] = []
    let categoryIconArray: [String] = ["category_life_ic", "category_kitchen_ic", "category_food_ic", "category_bath_ic", "category_note_ic", "category_etc_ic"]
    let cateogryTitleArray: [String] = ["생활용품", "음식", "주방", "욕실", "문구", "기타"]


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        getEnterUserInfo()
        
        print(Singleton.shared.userToken)
        
        let leftNavigationBar = UIBarButtonItem(image: UIImage(named: "nanuri_header_logo")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
        self.navigationItem.setLeftBarButton(leftNavigationBar, animated: false)
        
        setUpView()
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
        addProductStepOneViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(addProductStepOneViewController, animated: true)
    }
    
    func getEnterUserInfo() {
        if let tokenNum = UserDefaults.standard.object(forKey: "loginInfo") as? Data {
            let decoder = JSONDecoder()
            if let loadedToken = try? decoder.decode(SocialLogin.self, from: tokenNum) {
                Singleton.shared.userToken = loadedToken.token
            }
        }
    }
    
    func getPostsList() {
        self.indicatorView.startAnimating()
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
            self.allRegionTableView.reloadData()
            self.indicatorView.stopAnimating()
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
    
    func setUpCategoryScrollView() {
        for i in 0..<cateogryTitleArray.count {
            let categoryButton = UIButton()
            
            let categoryIconImageView = UIImageView()
            categoryIconImageView.image = UIImage(named: categoryIconArray[i])
            categoryButton.addSubview(categoryIconImageView)
            categoryIconImageView.snp.makeConstraints { make in
                make.width.height.equalTo(50)
                make.centerX.equalToSuperview()
            }
            
            let categoryTitleLabel = UILabel()
            categoryTitleLabel.attributedText = .attributeFont(font: .PMedium, size: 12, text: cateogryTitleArray[i], lineHeight: 14)
            categoryButton.addSubview(categoryTitleLabel)
            categoryTitleLabel.snp.makeConstraints { make in
                make.top.equalTo(categoryIconImageView.snp.bottom).inset(-6)
                make.centerX.equalToSuperview()
            }
            
            categoryButtonArray.append(categoryButton)
        }
        
        for i in 0..<categoryButtonArray.count {
            categoryScrollView.addSubview(categoryButtonArray[i])
            
            if i == 0 {
                categoryButtonArray[i].snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.left.equalToSuperview().inset(16)
                    make.width.height.equalTo(70)
                }
            } else if i == categoryButtonArray.count - 1 {
                categoryButtonArray[i].snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.left.equalTo(categoryButtonArray[i-1].snp.right).inset(-16)
                    make.right.equalToSuperview().inset(16)
                    make.width.height.equalTo(70)
                }
            } else {
                categoryButtonArray[i].snp.makeConstraints { make in
                    make.top.bottom.equalToSuperview()
                    make.left.equalTo(categoryButtonArray[i-1].snp.right).inset(-16)
                    make.width.height.equalTo(70)
                }
            }
        }
    }

    func setUpView() {
        self.view.backgroundColor = .white
    
        let headerView = UIView()
        let headerViewHeight = collectionCellHeight + 40 + 187
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
        
        categoryScrollView.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        categoryScrollView.contentSize = .init(width: categoryScrollView.frame.width, height: categoryScrollView.frame.height)
        categoryScrollView.showsHorizontalScrollIndicator = false
        headerView.addSubview(categoryScrollView)
        categoryScrollView.snp.makeConstraints { make in
            make.top.equalTo(categoryTitleLabel.snp.bottom).inset(-24)
            make.left.right.equalToSuperview()
            make.height.equalTo(70)
        }
        
        setUpCategoryScrollView()
        
        allRegionTableView.delegate = self
        allRegionTableView.dataSource = self
        allRegionTableView.separatorInset = .zero
        allRegionTableView.separatorStyle = .none
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
//
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


//MARK: - UIScrollViewDelegate

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x / scrollView.frame.size.width
        pagerCount.attributedText = .attributeFont(font: .PMedium, size: 10, text: "\(Int(round(value + 1)))  /  \(sampleImageViewArray.count)", lineHeight: 10)
        pagerCount.textColor = .white
    }
}
