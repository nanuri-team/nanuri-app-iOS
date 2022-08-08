//
//  LoginView.swift
//  nanuri-app-renewal
//
//  Created by heyji on 2022/08/08.
//

import UIKit

class LoginView: UIView {
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "login_logo_ic")
        return imageView
    }()
    
    let kakaoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "snskakao_ic"), for: .normal)
        return button
    }()
    
    let appleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "snsapple_ic"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-139)
            $0.width.equalTo(148)
            $0.height.equalTo(48)
        }
        
        addSubview(kakaoButton)
        kakaoButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoImageView.snp.bottom).offset(164)
            $0.width.equalTo(311)
            $0.height.equalTo(46)
        }
        
        addSubview(appleButton)
        appleButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(kakaoButton.snp.bottom).offset(10)
            $0.width.equalTo(311)
            $0.height.equalTo(46)
        }
    }
}
