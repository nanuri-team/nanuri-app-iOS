//
//  RegisterView.swift
//  nanuri-app-renewal
//
//  Created by heyji on 2022/08/11.
//

import UIKit

final class RegisterView: UIView {
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close_ic"), for: .normal)
        return button
    }()
    
    let welcomeTitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .attributeFont(font: .PBold, size: 28, text: "환영합니다!", lineHeight: 34)
        return label
    }()
    
    let requiredLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .attributeFont(font: .PSemibold, size: 16, text: "*", lineHeight: 19)
        label.textColor = .nanuriRed
        return label
    }()
    
    let nickNameLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .attributeFont(font: .PSemibold, size: 16, text: "닉네임을 설정해주세요.", lineHeight: 19)
        return label
    }()
    
    let nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임(영문, 한글 10자 이내)"
        textField.attributedText = .attributeFont(font: .PRegular, size: 15, text: "", lineHeight: 18)
        textField.toStyledTextField(textField)
        textField.addPadding(width: 16)
        return textField
    }()
    
    var checkButton: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = false
        return button
    }()
    
    var checkLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var registerButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: "회원가입", lineHeight: 18), for: .normal)
        button.backgroundColor = .nanuriGray3
        button.layer.cornerRadius = 4
        button.setTitleColor(.white, for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    var termsCheckButton: UIButton = {
        let button = CheckboxButton()
        return button
    }()
    
    var termsLinkButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(.attributeFontStyle(font: .PRegular, size: 15, text: "이용약관", lineHeight: 18), for: .normal)
        button.setTitleColor(.nanuriGray7, for: .normal)
        return button
    }()
    
    let termsLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .attributeFont(font: .PRegular, size: 15, text: "에 동의합니다. (필수)", lineHeight: 18)
        return label
    }()
    
    let termsRequiredLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .attributeFont(font: .PSemibold, size: 16, text: "*", lineHeight: 19)
        label.textColor = .nanuriRed
        return label
    }()
    
    let privacyCheckButton: UIButton = {
        let button = CheckboxButton()
        button.isSelected = false
        return button
    }()
    
    let privacyLinkButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(.attributeFontStyle(font: .PRegular, size: 15, text: "개인정보처리방침", lineHeight: 18), for: .normal)
        button.setTitleColor(.nanuriGray7, for: .normal)
        return button
    }()
    
    let privacyLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .attributeFont(font: .PRegular, size: 15, text: "에 동의합니다. (필수)", lineHeight: 18)
        return label
    }()
    
    let privacyRequiredLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .attributeFont(font: .PSemibold, size: 16, text: "*", lineHeight: 19)
        label.textColor = .nanuriRed
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
    }
    
    private func setUpView() {
        addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(12)
            make.left.equalToSuperview().inset(16)
        }
        
        addSubview(welcomeTitleLabel)
        welcomeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).inset(-66)
            make.left.right.equalToSuperview().inset(24)
        }
        
        addSubview(requiredLabel)
        requiredLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeTitleLabel.snp.bottom).inset(-32)
            make.left.equalToSuperview().inset(24)
        }
        
        addSubview(nickNameLabel)
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(requiredLabel.snp.top)
            make.left.equalTo(requiredLabel.snp.right).inset(-4)
        }
        
        addSubview(nickNameTextField)
        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom).inset(-10)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }
        
        nickNameTextField.addSubview(checkButton)
        checkButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(16)
        }
        
        addSubview(checkLabel)
        checkLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).inset(-8)
            make.right.equalToSuperview().inset(24)
        }
        
        addSubview(registerButton)
        registerButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(32)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
        
        addSubview(termsCheckButton)
        termsCheckButton.snp.makeConstraints { make in
            make.bottom.equalTo(registerButton.snp.top).inset(-32)
            make.left.equalToSuperview().inset(32)
        }
        
        addSubview(termsLinkButton)
        termsLinkButton.snp.makeConstraints { make in
            make.centerY.equalTo(termsCheckButton.snp.centerY)
            make.left.equalTo(termsCheckButton.snp.right).inset(-10)
        }
        
        addSubview(termsLabel)
        termsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(termsCheckButton.snp.centerY)
            make.left.equalTo(termsLinkButton.snp.right).inset(-4)
        }
        
        addSubview(termsRequiredLabel)
        termsRequiredLabel.snp.makeConstraints { make in
            make.top.equalTo(termsLabel.snp.top)
            make.left.equalTo(termsLabel.snp.right).inset(-4)
        }
        
        addSubview(privacyCheckButton)
        privacyCheckButton.snp.makeConstraints { make in
            make.bottom.equalTo(termsCheckButton.snp.top).inset(-17)
            make.left.equalToSuperview().inset(32)
        }
        
        addSubview(privacyLinkButton)
        privacyLinkButton.snp.makeConstraints { make in
            make.centerY.equalTo(privacyCheckButton.snp.centerY)
            make.left.equalTo(privacyCheckButton.snp.right).inset(-10)
        }
        
        addSubview(privacyLabel)
        privacyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(privacyCheckButton.snp.centerY)
            make.left.equalTo(privacyLinkButton.snp.right).inset(-4)
        }
        
        addSubview(privacyRequiredLabel)
        privacyRequiredLabel.snp.makeConstraints { make in
            make.top.equalTo(privacyLabel.snp.top)
            make.left.equalTo(privacyLabel.snp.right).inset(-4)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
