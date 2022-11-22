//
//  ProfileView.swift
//  nanuri-app-renewal
//
//  Created by heyji on 2022/11/10.
//

import UIKit

class ProfileView: UIView {
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 96 / 2
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "myprofile_photo_ic")
        return imageView
    }()
    var profileModifyButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(.attributeFont(font: .PRegular, size: 13, text: "변경하기", lineHeight: 13), for: .normal)
        button.setTitleColor(.nanuriGray6, for: .normal)
        return button
    }()
    var nicNameLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .attributeFont(font: .PSemibold, size: 16, text: "닉네임", lineHeight: 19)
        return label
    }()
    var profileNameTextField: UITextField = {
        let textField = UITextField()
        textField.toStyledTextField(textField)
        textField.addPadding(width: 16)
        textField.attributedText = .attributeFont(font: .PRegular, size: 15, text: "", lineHeight: 18)
        return textField
    }()
    var regionModifyLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .attributeFont(font: .PSemibold, size: 16, text: "지역 변경", lineHeight: 19)
        return label
    }()
    var regionModifyTextField: UITextField = {
        let textField = UITextField()
        textField.toStyledTextField(textField)
        textField.addPadding(width: 16)
        textField.attributedText = .attributeFont(font: .PRegular, size: 15, text: "", lineHeight: 18)
        return textField
    }()
    var regionButton: UIButton = {
        let button = UIButton()
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
        addSubview(profileImageView)
        addSubview(profileModifyButton)
        addSubview(nicNameLabel)
        addSubview(profileNameTextField)
        addSubview(regionModifyLabel)
        addSubview(regionModifyTextField)
        regionModifyTextField.addSubview(regionButton)
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(24)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(96)
        }
        
        profileModifyButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).inset(-2)
            make.centerX.equalToSuperview()
        }
        
        nicNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileModifyButton.snp.bottom).inset(-24)
            make.left.equalTo(16)
        }
        
        profileNameTextField.snp.makeConstraints { make in
            make.top.equalTo(nicNameLabel.snp.bottom).inset(-10)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(44)
        }
        
        regionModifyLabel.snp.makeConstraints { make in
            make.top.equalTo(profileNameTextField.snp.bottom).inset(-24)
            make.left.equalTo(16)
        }
        
        regionModifyTextField.snp.makeConstraints { make in
            make.top.equalTo(regionModifyLabel.snp.bottom).inset(-10)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(44)
        }
        
        regionButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 계좌
//        let accountNumberLabel = UILabel()
//        accountNumberLabel.attributedText = .attributeFont(font: .PSemibold, size: 16, text: "계좌번호", lineHeight: 19)
//        self.view.addSubview(accountNumberLabel)
//        accountNumberLabel.snp.makeConstraints {
//            $0.top.equalTo(regionModifyTextField.snp.bottom).inset(-24)
//            $0.left.equalTo(16)
//        }
//
//        let bankTextField = UITextField()
//        bankTextField.toStyledTextField(bankTextField)
//        bankTextField.addPadding(width: 16)
//        bankTextField.attributedText = .attributeFont(font: .PRegular, size: 15, text: "기업은행", lineHeight: 18)
//        self.view.addSubview(bankTextField)
//        bankTextField.snp.makeConstraints {
//            $0.top.equalTo(accountNumberLabel.snp.bottom).inset(-10)
//            $0.left.equalTo(16)
//            $0.width.equalTo(100)
//            $0.height.equalTo(44)
//        }
//
//        let accountNumberTextField = UITextField()
//        accountNumberTextField.toStyledTextField(accountNumberTextField)
//        accountNumberTextField.addPadding(width: 16)
//        accountNumberTextField.attributedText = .attributeFont(font: .PRegular, size: 15, text: "123-456-7891012", lineHeight: 18)
//        self.view.addSubview(accountNumberTextField)
//        accountNumberTextField.snp.makeConstraints {
//            $0.top.equalTo(accountNumberLabel.snp.bottom).inset(-10)
//            $0.left.equalTo(bankTextField.snp.right).inset(-6)
//            $0.right.equalTo(-16)
//            $0.height.equalTo(44)
//        }
//
//        let infoLabel = UILabel()
//        infoLabel.attributedText = .attributeFont(font: .PRegular, size: 11, text: "거래시 정보 확인을 위하여 은행과 계좌번호를 받고 있습니다.\n타인에게 노출되는 내용이 아니니 안심하셔도 됩니다.", lineHeight: 13)
//        infoLabel.textColor = .nanuriGray3
//        infoLabel.numberOfLines = 2
//        infoLabel.textAlignment = .right
//        self.view.addSubview(infoLabel)
//        infoLabel.snp.makeConstraints {
//            $0.top.equalTo(accountNumberTextField.snp.bottom).inset(-6)
//            $0.right.equalTo(-16)
//        }
    }
}
