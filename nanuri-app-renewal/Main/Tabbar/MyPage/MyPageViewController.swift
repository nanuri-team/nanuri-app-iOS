//
//  MyPageViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit

class MyPageViewController: UIViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
//        mypageSetUpView()
    }
    
    private func setUpView() {
        self.title = "마이페이지"
        let settingButton = UIBarButtonItem(image: UIImage(named: "setting_ic"), style: .plain, target: self, action: #selector(selectSettingButton))
        self.navigationItem.setRightBarButton(settingButton, animated: true)
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.backgroundColor = .purple
        self.scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(1000)
        }
        
        let profileView = UIView()
        contentView.addSubview(profileView)
        profileView.backgroundColor = .white
        profileView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(95)
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
    
    
    // 마이페이지 탭 메뉴 ( 스크롤) 세팅
    /*
     func setScrollView() {
     //        scrollView.delegate = self
     scrollView.contentSize.width = self.view.frame.width * 2
     
     //        self.addChild(MyRegisterProductViewController)
     //        guard let myRegisterProduct = MyRegisterProductViewController.view else { return }
     }
     */
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller
     }
     */
    
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


