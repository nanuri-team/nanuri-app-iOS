//
//  HomeViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "홈"
        
        setUpView()
    }
    

    func setUpView() {
        self.view.backgroundColor = .white
        
        let testTag = DeliveryTagView(type: .direct)
        self.view.addSubview(testTag)
        testTag.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.leading.equalToSuperview().inset(50)
        }
    }

}
