//
//  MyPageHeaderView.swift
//  nanuri-app-renewal
//
//  Created by heyji on 2022/11/09.
//

import UIKit

class MyPageHeaderView: UIView {
    var profileNameLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .attributeFont(font: .PBold, size: 18, text: "닉네임을 입력하세요", lineHeight: 20)
        return label
    }()
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "myprofile_photo_ic")
        imageView.layer.cornerRadius = 56 / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    var levelView: UIView = {
        let view = LevelView(.bean, isLevelName: true)
        return view
    }()
    var locationTagView: LocationTagView = {
        let view = LocationTagView(location: "서울시 강남구")
        return view
    }()
    var profileModifyButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(.attributeFont(font: .PRegular, size: 13, text: "수정", lineHeight: 13), for: .normal)
        button.setTitleColor(.nanuriGray5, for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
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
        let profileView = UIView()
        addSubview(profileView)
        profileView.addSubview(profileImageView)
        profileView.addSubview(profileNameLabel)
        profileView.addSubview(levelView)
        profileView.addSubview(locationTagView)
        profileView.addSubview(profileModifyButton)
        
        profileView.backgroundColor = .white
        profileView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints {
            $0.left.equalTo(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(56)
        }
        
        profileNameLabel.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.left.equalTo(profileImageView.snp.right).inset(-16)
        }
        
        levelView.snp.makeConstraints {
            $0.centerY.equalTo(profileNameLabel)
            $0.left.equalTo(profileNameLabel.snp.right).inset(-6)
        }
        
        locationTagView.snp.makeConstraints {
            $0.top.equalTo(profileNameLabel.snp.bottom).inset(-8)
            $0.left.equalTo(profileImageView.snp.right).inset(-16)
        }
        
        profileModifyButton.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.right.equalTo(-16)
            $0.width.equalTo(23)
        }
    }
}
