//
//  CheckMyLocationViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/13.
//

import UIKit

class CheckMyLocationViewController: UIViewController {
    
    var edgeHeight = 34

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "내 위치 설정"
        self.view.backgroundColor = .white

        let backButton = UIBarButtonItem(image: UIImage(named: "back_ic"), style: .plain, target: self, action: #selector(selectBackButton))
        self.navigationItem.setLeftBarButton(backButton, animated: true)
        
        setUpView()
    }
    
    @objc func selectBackButton() {
        self.navigationController?.popViewController(animated: true)
    }

    func setUpView() {
        let locationTitleLabel = UILabel()
        locationTitleLabel.attributedText = NSAttributedString(string: "여기가 현재\n회원님의 위치가 맞나요?")
        locationTitleLabel.numberOfLines = 2
        locationTitleLabel.textAlignment = .center
        locationTitleLabel.textColor = .nanuriGray5
        self.view.addSubview(locationTitleLabel)
        locationTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(40)
            make.left.right.equalToSuperview()
        }
        
        let locationImageView = UIImageView()
        locationImageView.image = UIImage(named: "location_image")
        self.view.addSubview(locationImageView)
        locationImageView.snp.makeConstraints { make in
            make.top.equalTo(locationTitleLabel.snp.bottom).inset(-40)
            make.centerX.equalToSuperview()
        }
        
        let myLocationLabel = UILabel()
        myLocationLabel.attributedText = NSAttributedString(string: "\"서울시 강북구 미아동\"")
        myLocationLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        myLocationLabel.textColor = .nanuriGreen
        self.view.addSubview(myLocationLabel)
        myLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(locationImageView.snp.bottom).inset(-32)
            make.centerX.equalToSuperview()
        }
        
        let buttonView = UIView()
        self.view.addSubview(buttonView)
        
        let cancelButton = MainButton(style: .disable)
        cancelButton.setAttributedTitle(NSAttributedString(string: "아니오, 다릅니다"), for: .normal)
        buttonView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.45)
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(16)
        }
        
        let okButton = MainButton(style: .main)
        okButton.setAttributedTitle(NSAttributedString(string: "네, 맞습니다"), for: .normal)
        buttonView.addSubview(okButton)
        okButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.45)
            make.top.bottom.equalToSuperview()
            make.left.equalTo(cancelButton.snp.right).inset(-7)
            make.right.equalToSuperview().inset(16)
        }
        
        buttonView.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(14)
            make.height.equalTo(48)
            make.left.right.equalToSuperview()
        }
    }

}
