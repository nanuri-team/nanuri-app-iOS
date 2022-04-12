//
//  NeighbourhoodViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit

class NeighbourhoodViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let locationButton = UIButton()
        locationButton.setImage(UIImage(named: "place_black_ic"), for: .normal)
        locationButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        locationButton.setAttributedTitle(NSAttributedString(string: "현 위치"), for: .normal)
        locationButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        locationButton.addTarget(self, action: #selector(selectLocationButton), for: .touchUpInside)
        
        let location = UIBarButtonItem(customView: locationButton)
        let notificationButton = UIBarButtonItem(image: UIImage(named: "notification_ic"), style: .plain, target: self, action: #selector(selectNotificationButton))
        
        self.navigationItem.setLeftBarButton(location, animated: true)
        self.navigationItem.setRightBarButton(notificationButton, animated: true)
        
        setUpView()
    }
    
    @objc func selectLocationButton() {
        let locationPermissionViewController = LocationPermissionViewController()
        locationPermissionViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(locationPermissionViewController, animated: true)
        print("click")
    }
    
    @objc func selectNotificationButton() {
        print("noti")
    }
    
    func setUpView() {
        let noSettingLocationView = UIView()
        self.view.addSubview(noSettingLocationView)
        
        let locationImageView = UIImageView()
        locationImageView.image = UIImage(named: "location_large_ic")
        noSettingLocationView.addSubview(locationImageView)
        locationImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        let titleLabel = UILabel()
        titleLabel.attributedText = NSAttributedString(string: "현 위치를 설정해주세요")
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .nanuriGray3
        noSettingLocationView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(locationImageView.snp.bottom).inset(-17)
        }
        
        let descriptionLabel = UILabel()
        descriptionLabel.attributedText = NSAttributedString(string: "내 주변의 거래 상품을 보려면\n좌측 상단의 현 위치 버튼을 눌러 설정해야 합니다.")
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.textColor = .nanuriGray3
        noSettingLocationView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-16)
            make.centerX.equalToSuperview()
        }
        
        noSettingLocationView.snp.makeConstraints { make in
            make.top.equalTo(locationImageView.snp.top)
            make.bottom.equalTo(descriptionLabel.snp.bottom)
            make.left.right.equalToSuperview()
            make.center.equalToSuperview()
        }
    }

}
