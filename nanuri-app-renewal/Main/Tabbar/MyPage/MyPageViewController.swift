//
//  MyPageViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit

class MyPageViewController: UIViewController {
    
    private var isTappedProductListButton: Bool = false
    private let productListTableView = UITableView()
    private let registeredProductsListButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setAttributedTitle(.attributeFont(font: .PRegular, size: 13, text: "내가 등록한 상품", lineHeight: 15), for: .normal)
        button.setTitleColor(.nanuriGreen, for: .normal)
        return button
    }()
    private let clickedView: UIView = {
        let view = UIView()
        view.backgroundColor = .nanuriGreen
        return view
    }()
    private let participatedProductsListButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setAttributedTitle(.attributeFont(font: .PRegular, size: 13, text: "내가 참여한 상품", lineHeight: 15), for: .normal)
        button.setTitleColor(.nanuriGray5, for: .normal)
        return button
    }()
    private let clickedView2: UIView = {
        let view = UIView()
        view.backgroundColor = .nanuriGray2
        return view
    }()
    private let numberOfListLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .attributeFont(font: .PBold, size: 13, text: label.text ?? "전체 0개", lineHeight: 15)
        label.text = "전체 14개"
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
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
        
        let profileView = UIView()
        headerView.addSubview(profileView)
        profileView.backgroundColor = .white
        profileView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let profileImageView = UIImageView()
        profileImageView.image = UIImage(named: "myprofile_photo_ic")
        profileView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints {
            $0.left.equalTo(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(56)
        }

        let profileNameLabel = UILabel()
        profileNameLabel.attributedText = .attributeFont(font: .PBold, size: 18, text: "프로자취러", lineHeight: 20)
        profileView.addSubview(profileNameLabel)
        profileNameLabel.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.left.equalTo(profileImageView.snp.right).inset(-16)
        }
        // profileNameLabel 10글자 이상이면 나머지는 ... 로 표시되도록

        let levelView = LevelView(.flower, isLevelName: true)
        profileView.addSubview(levelView)
        levelView.snp.makeConstraints {
            $0.centerY.equalTo(profileNameLabel)
            $0.left.equalTo(profileNameLabel.snp.right).inset(-6)
        }

        let locationTagView = LocationTagView(location: "서울시 강남구")
        profileView.addSubview(locationTagView)
        locationTagView.snp.makeConstraints {
            $0.top.equalTo(profileNameLabel.snp.bottom).inset(-8)
            $0.left.equalTo(profileImageView.snp.right).inset(-16)
        }

        let profileModifyButton = UIButton()
        profileModifyButton.setAttributedTitle(.attributeFont(font: .PRegular, size: 13, text: "수정", lineHeight: 13), for: .normal)
        profileModifyButton.setTitleColor(.nanuriGray5, for: .normal)
        profileModifyButton.semanticContentAttribute = .forceLeftToRight
        profileModifyButton.addTarget(self, action: #selector(clickModifyButton), for: .touchUpInside)
        profileView.addSubview(profileModifyButton)
        profileModifyButton.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.right.equalTo(-16)
            $0.width.equalTo(23)
        }
    }
    
    // objc - Actions
    @objc func selectSettingButton() {
        print("settingButton Tapped")
    }
    
    @objc func selectMoreButton() {
        print("Continued..")
    }
    
    @objc func clickModifyButton() {
        let myProfileModifiedView = MyProfileModifiedViewController()
        myProfileModifiedView.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(myProfileModifiedView, animated:true)
    }
    
    @objc func registeredProductsListButtonTapped() {
        
        if isTappedProductListButton { // true
            isTappedProductListButton.toggle()
            registeredProductsListButton.setTitleColor(.nanuriGreen, for: .normal)
            clickedView.backgroundColor = .nanuriGreen
            participatedProductsListButton.setTitleColor(.nanuriGray5, for: .normal)
            clickedView2.backgroundColor = .nanuriGray2
            DispatchQueue.main.async {
                self.productListTableView.reloadData()
            }
            numberOfListLabel.text = "전체 14개"
        }
    }
    
    @objc func participatedProductsListButtonTapped() {
        
        if isTappedProductListButton == false { // false
            isTappedProductListButton.toggle()
            registeredProductsListButton.setTitleColor(.nanuriGray5, for: .normal)
            clickedView.backgroundColor = .nanuriGray2
            participatedProductsListButton.setTitleColor(.nanuriGreen, for: .normal)
            clickedView2.backgroundColor = .nanuriGreen
            DispatchQueue.main.async {
                self.productListTableView.reloadData()
            }
            numberOfListLabel.text = "전체 3개"
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller
     }
     */
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isTappedProductListButton {
            return 3
        } else {
            return 14
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .white

        let productView = UIView()
        productView.backgroundColor = .nanuriGray2
        header.addSubview(productView)
        productView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(45)
        }

        productView.addSubview(registeredProductsListButton)
        registeredProductsListButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalTo(productView.snp.width).dividedBy(2)
            $0.height.equalTo(42)
        }
        registeredProductsListButton.addTarget(self, action: #selector(registeredProductsListButtonTapped), for: .touchUpInside)

        productView.addSubview(clickedView)
        clickedView.snp.makeConstraints {
            $0.top.equalTo(registeredProductsListButton.snp.bottom)
            $0.left.equalToSuperview()
            $0.width.equalTo(registeredProductsListButton.snp.width)
            $0.height.equalTo(3)
        }

        productView.addSubview(participatedProductsListButton)
        participatedProductsListButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.right.equalToSuperview()
            $0.width.equalTo(productView.snp.width).dividedBy(2)
            $0.height.equalTo(42)
        }
        participatedProductsListButton.addTarget(self, action: #selector(participatedProductsListButtonTapped), for: .touchUpInside)

        productView.addSubview(clickedView2)
        clickedView2.snp.makeConstraints {
            $0.top.equalTo(participatedProductsListButton.snp.bottom)
            $0.right.equalToSuperview()
            $0.width.equalTo(participatedProductsListButton.snp.width)
            $0.height.equalTo(3)
        }

        header.addSubview(numberOfListLabel)
        numberOfListLabel.snp.makeConstraints {
            $0.top.equalTo(productView.snp.bottom).inset(-25)
            $0.left.equalTo(16)
        }

        let moreButton = UIButton()
        moreButton.setAttributedTitle(.attributeFont(font: .PRegular, size: 13, text: "진행 중인 상품", lineHeight: 13), for: .normal)
        moreButton.setImage(UIImage(named: "down_arrow_ic"), for: .normal)
        moreButton.setTitleColor(.nanuriGray4, for: .normal)
        moreButton.semanticContentAttribute = .forceLeftToRight
        header.addSubview(moreButton)
        moreButton.snp.makeConstraints {
            $0.top.equalTo(productView.snp.bottom).inset(-25)
            $0.right.equalTo(-16)
        }
        moreButton.addTarget(self, action: #selector(selectMoreButton), for: .touchUpInside)

        return header
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
        if indexPath.row == 0 {
            let productDetailViewController = ProductDetailViewController()
            productDetailViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(productDetailViewController, animated: true)
        }
    }
}

//extension UIViewController {
//
//    // An array of children view controllers. This array does not include any presented view controllers.
//    @available(iOS 13.0, *)
//    open var children: [UIViewController] { get }
//
//    /*
//      If the child controller has a different parent controller, it will first be removed from its current parent
//      by calling removeFromParentViewController. If this method is overridden then the super implementation must
//      be called.
//    */
//    @available(iOS 13.0, *)
//    open func addChild(_ childController: MyRegisterProductViewController)
//
//...
//
//}


