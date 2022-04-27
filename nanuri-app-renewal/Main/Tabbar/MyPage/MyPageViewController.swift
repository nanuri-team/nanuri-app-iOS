//
//  MyPageViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit

class MyPageViewController: UIViewController {
    let scrollView = UIScrollView()
    //let profileView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "마이페이지"
        // Do any additional setup after loading the view.
        let settingButton = UIBarButtonItem(image: UIImage(named:"setting_ic"), style: .plain, target: self, action: #selector(selectSettingButton))
        self.navigationItem.setRightBarButton(settingButton, animated: true)
        mypageSetUpView()
        
        
        
        
    }
    // objc - Actions
    @objc func selectSettingButton() {
        print("setting")
    }
    
    @objc func selectMoreButton() {
        print("Continued..")
    }
    
    @objc func clickModifyButton() {
        let myProfileModifiedView = MyProfileModifiedViewController()
        myProfileModifiedView.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(myProfileModifiedView, animated:true)
    }
    
    
    // 마이페이지 탭 메뉴 ( 스크롤) 세팅
    /*
     func setScrollView() {
     //        scrollView.delegate = self
     scrollView.contentSize.width = self.view.frame.width * 2
     
     //        self.addChild(MyRegisterProductViewController)
     //        guard let myRegisterProduct = MyRegisterProductViewController.view else { return }
     }
     */
    
    func mypageSetUpView() {
        
        let profileView = UIView()
        self.view.addSubview(profileView)

        
        profileView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.width.equalTo(375)
            $0.height.equalTo(92)
        }
        // Profile
        let profileImage = UIImageView()
        profileImage.image = UIImage(named: "myprofile_photo_ic")
//        profileImage.backgroundColor = .nanuriGray1
        profileView.addSubview(profileImage)
        
        profileImage.layer.cornerRadius = 30
        //        profileImage.clipsToBounds = true
        profileImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.left.equalTo(16)
            $0.width.height.equalTo(56)
        }
        //Profile name
        let profileName = UILabel()
        profileName.attributedText = .attributeFont(font: .PBold, size: 18, text: "프로자취러", lineHeight: 20)
        profileView.addSubview(profileName)
        profileName.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.left.equalToSuperview().inset(88)
        }
        let separateView = UIView()
        separateView.backgroundColor = .nanuriGray2
        self.view.addSubview(separateView)
        separateView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(92)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        //        let userLevelView = UIView()
        //        profileView.addSubview(userLevelView)
        let level = LevelView(.flower, isLevelName: true)
        profileView.addSubview(level)
        level.snp.makeConstraints {
            $0.top.equalToSuperview().inset(38)
            $0.left.equalTo(profileName.snp.right).inset(-6)
            //            $0.right.equalToSuperview()
            //            $0.centerY.equalToSuperview()
        }
//        let moreButton = UIButton()
//        moreButton.setAttributedTitle(.attributeFont(font: .PRegular, size: 13, text: "진행 중인 상품", lineHeight: 13), for: .normal)
//        moreButton.setImage(UIImage(named: "down_arrow_ic"), for: .normal)
//        moreButton.setTitleColor(.nanuriGray4, for: .normal)
//        moreButton.semanticContentAttribute = .forceLeftToRight
        
        let profileModifyButton = UIButton()
        profileModifyButton.setAttributedTitle(.attributeFont(font: .PRegular, size: 13, text: "수정", lineHeight: 13), for: .normal)
        profileModifyButton.setTitleColor(.nanuriOrange, for: .normal)
        profileModifyButton.semanticContentAttribute = .forceLeftToRight
        profileModifyButton.addTarget(self, action: #selector(clickModifyButton), for: .touchUpInside)
        
        let locationTagView = LocationTagView(location: "서울시 강남구")
        profileView.addSubview(locationTagView)
        locationTagView.snp.makeConstraints {
            $0.top.equalTo(profileName.snp.bottom).inset(-10)
            $0.left.equalToSuperview().inset(88)
        }
        
        // 상품리스트 뷰 버튼
        let myProductsBtn = UIView()
        self.view.addSubview(myProductsBtn)
//        myProductsBtn.backgroundColor = .nanuriGray1
        
        myProductsBtn.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom)
            $0.width.equalTo(375)
            $0.height.equalTo(50)
        }
//        myProductsBtn.layer.borderColor = UIColor.nanuriLightGreen.cgColor
//        myProductsBtn.layer.borderWidth = 2
        
        let myRegisteredProductsList = UIButton()
        myProductsBtn.addSubview(myRegisteredProductsList)
        myRegisteredProductsList.backgroundColor = .white
        myRegisteredProductsList.setAttributedTitle(.attributeFont(font:.PRegular, size: 13, text: "내가 등록한 상품", lineHeight: 15), for: .normal)
        myRegisteredProductsList.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom)
            $0.width.equalTo(187)
            $0.height.equalTo(44)
            $0.left.equalToSuperview()
            
        }
        
         let myBoughtProductsList = UIButton()
         myProductsBtn.addSubview(myBoughtProductsList)
        myBoughtProductsList.setImage(UIImage(named:"mypage_boughtBtn_ic"), for: .normal)
        
//         myBoughtProductsList.setAttributedTitle(.attributeFont(font: .PRegular, size: 13, text: "내가 구매한 상품", lineHeight: 15), for: .normal)
         myBoughtProductsList.snp.makeConstraints {
         $0.top.equalTo(profileView.snp.bottom)
         $0.width.equalTo(187)
         $0.height.equalTo(44)
         $0.right.equalToSuperview()
         //            $0.left.equalTo(myRegisteredProductsList.snp.right)
         }
        let separateView2 = UIView()
        separateView2.backgroundColor = .nanuriGray2
        self.view.addSubview(separateView2)
        separateView2.snp.makeConstraints { make in
            make.top.equalTo(myProductsBtn.snp.bottom).inset(5)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        let mypageProductLists = UITableView()
//        mypageProductLists.backgroundColor = .nanuriBlue
        mypageProductLists.delegate = self
        mypageProductLists.dataSource = self
        mypageProductLists.separatorInset = .zero
        mypageProductLists.separatorStyle = .none
        mypageProductLists.register(MainProductTableViewCell.self, forCellReuseIdentifier: MainProductTableViewCell.cellId)
        self.view.addSubview(mypageProductLists)
        mypageProductLists.snp.makeConstraints {
//            $0.top.equalTo(myProductsBtn.snp.bottom).offset(20)
            $0.top.equalTo(myProductsBtn.snp.bottom).inset(-24)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
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
//

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 2
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
    
                let mypageList = UILabel()
                mypageList.attributedText = .attributeFont(font: .PBold, size: 13, text: "전체 2개", lineHeight: 15)
                cell.contentView.addSubview(mypageList)
                mypageList.snp.makeConstraints { make in
                    make.left.equalToSuperview().inset(20)
                    make.top.equalToSuperview()
                }
                
                let moreButton = UIButton()
                moreButton.setAttributedTitle(.attributeFont(font: .PRegular, size: 13, text: "진행 중인 상품", lineHeight: 13), for: .normal)
                moreButton.setImage(UIImage(named: "down_arrow_ic"), for: .normal)
                moreButton.setTitleColor(.nanuriGray4, for: .normal)
                moreButton.semanticContentAttribute = .forceLeftToRight
                cell.contentView.addSubview(moreButton)
                moreButton.snp.makeConstraints { make in
                    make.right.equalToSuperview().inset(16)
                    make.top.equalToSuperview()
                }
                moreButton.addTarget(self, action: #selector(selectMoreButton), for: .touchUpInside)
                
                cell.contentView.snp.makeConstraints { make in
                    make.left.right.equalToSuperview()
                }
                return cell
            }
        } else {
            let identifier = "\(indexPath.row)"
            
            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
                return reuseCell
            } else {
                let cell = MainProductTableViewCell.init(style: .default, reuseIdentifier: identifier)
                cell.selectionStyle = .none
                
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                let productDetailViewController = ProductDetailViewController()
                productDetailViewController.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(productDetailViewController, animated: true)
            }
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


