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
//        let settingButton = UIBarButtonItem(image: UIImage(named:"setting-ic"), style: .plain, target: self, action: #selector(selectSettingButton))
//        self.navigationItem.setRightBarButton(settingButton, animated: true)
        setUpView()
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
    
    func setUpView() {
        let profileView = UIView()
        self.view.addSubview(profileView)
        profileView.backgroundColor = .nanuriBlue.withAlphaComponent(0.2)
        
        profileView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.width.equalTo(375)
            $0.height.equalTo(92)
        }
        
        let profileImage = UIImageView()
        profileImage.backgroundColor = .nanuriYellow
        profileView.addSubview(profileImage)
        profileImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.left.equalTo(16)
            $0.width.height.equalTo(56)
        }
    }
    
    // objc - Actions
    @objc func selectSettingButton() {
        print("setting")
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
