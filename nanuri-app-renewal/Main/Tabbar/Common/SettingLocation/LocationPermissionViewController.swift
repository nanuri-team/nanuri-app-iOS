//
//  LocationPermissionViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/13.
//

import UIKit

class LocationPermissionViewController: UIViewController {
    
    var bottomViewHeight = 64
    var edgeHeight = 34

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "위치 권한 허용"
        self.view.backgroundColor = .white

        let backButton = UIBarButtonItem(image: UIImage(named: "back_ic"), style: .plain, target: self, action: #selector(selectBackButton))
        self.navigationItem.setLeftBarButton(backButton, animated: true)
        
        setUpView()
    }
    
    @objc func selectBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectSettingLocationButton() {
        let checkMyLocationViewController = CheckMyLocationViewController()
        checkMyLocationViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(checkMyLocationViewController, animated: true)
    }
    
    func setUpView() {
        let permissionTitleLabel = UILabel()
        permissionTitleLabel.attributedText = NSAttributedString(string: "나누리에서\n내 주변 이웃과의 거래를 위해")
        permissionTitleLabel.numberOfLines = 2
        permissionTitleLabel.font = UIFont.systemFont(ofSize: 24)
        self.view.addSubview(permissionTitleLabel)
        permissionTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(40)
            make.left.right.equalToSuperview().inset(24)
        }
        
        let permissionColorTitleLabel = UILabel()
        permissionColorTitleLabel.attributedText = NSAttributedString(string: "내 위치 권한을 허용해주세요.")
        permissionColorTitleLabel.textColor = .nanuriGreen
        permissionColorTitleLabel.font = UIFont.systemFont(ofSize: 24)
        self.view.addSubview(permissionColorTitleLabel)
        permissionColorTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(permissionTitleLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(24)
        }
        
        let bottomView = UIView()
        bottomView.backgroundColor = .white
        self.view.addSubview(bottomView)
        self.view.bringSubviewToFront(bottomView)
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.right.left.equalToSuperview()
            make.height.equalTo(bottomViewHeight)
        }
        
        let topLineView = UIView()
        topLineView.backgroundColor = .nanuriGray2
        bottomView.addSubview(topLineView)
        topLineView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalToSuperview()
        }
        
        let settingLocationButton = MainButton(style: .main)
        settingLocationButton.setAttributedTitle(NSAttributedString(string: "현 위치 설정하기"), for: .normal)
        bottomView.addSubview(settingLocationButton)
        settingLocationButton.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(8)
        }
        settingLocationButton.addTarget(self, action: #selector(selectSettingLocationButton), for: .touchUpInside)
        
        let locationImageView = UIImageView()
        locationImageView.image = UIImage(named: "location_image")
        self.view.addSubview(locationImageView)
        locationImageView.snp.makeConstraints { make in
            make.bottom.equalTo(bottomView.snp.top).inset(-32)
            make.right.equalToSuperview().inset(24)
        }
        
    }

}
