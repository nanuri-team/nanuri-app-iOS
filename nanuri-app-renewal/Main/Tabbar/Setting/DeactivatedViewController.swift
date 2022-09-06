//
//  DeactivatedViewController.swift
//  nanuri-app-renewal
//
//  Created by heyji on 2022/08/24.
//

import UIKit

class DeactivatedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func deactivatedButtonTapped() {
        self.dismiss(animated: true, completion: nil)
        
        let params: [String: Any] = ["is_active": false]
        
        NetworkService.shared.patchUserIsActiveRequest(parameters: params)
        
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
        let viewController = LoginViewController()
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(viewController)
    }
    
    private func setupView() {
        self.view.backgroundColor = .black.withAlphaComponent(0.4)
        
        let mainView = UIView()
        mainView.backgroundColor = .white
        mainView.layer.cornerRadius = 10
        self.view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(244)
        }
        
        let titleLabel = UILabel()
        titleLabel.attributedText = .attributeFont(font: .PSemibold, size: 20, text: "나누리 회원을", lineHeight: 24)
        titleLabel.textAlignment = .center
        mainView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(44)
            make.centerX.equalToSuperview()
        }
        
        let signOutLabel = UILabel()
        signOutLabel.attributedText = .attributeFont(font: .PSemibold, size: 20, text: "탈퇴", lineHeight: 24)
        signOutLabel.textColor = .nanuriRed
        
        let subTitleLabel = UILabel()
        subTitleLabel.attributedText = .attributeFont(font: .PSemibold, size: 20, text: "하시겠습니까?", lineHeight: 24)

        var stackView = UIStackView()
        stackView = UIStackView(arrangedSubviews: [signOutLabel, subTitleLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        mainView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.height.equalTo(25)
        }
        
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 2
        descriptionLabel.attributedText = .attributeFont(font: .PRegular, size: 15, text: "탈퇴 후 계정 복구가 불가능합니다.\n신중하게 선택해주세요.", lineHeight: 22)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .nanuriGray4
        mainView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        let cancelButton = UIButton()
        cancelButton.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: "취소", lineHeight: 18), for: .normal)
        cancelButton.setTitleColor(.nanuriGray5, for: .normal)
        cancelButton.backgroundColor = .nanuriGray2
        cancelButton.layer.cornerRadius = 4
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        let signOutButton = UIButton()
        signOutButton.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: "탈퇴하기", lineHeight: 18), for: .normal)
        signOutButton.setTitleColor(.white, for: .normal)
        signOutButton.backgroundColor = .nanuriGreen
        signOutButton.layer.cornerRadius = 4
        signOutButton.addTarget(self, action: #selector(deactivatedButtonTapped), for: .touchUpInside)
        
        var buttonStackView = UIStackView()
        buttonStackView = UIStackView(arrangedSubviews: [cancelButton, signOutButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.alignment = .fill
        buttonStackView.spacing = 5
        mainView.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
}
