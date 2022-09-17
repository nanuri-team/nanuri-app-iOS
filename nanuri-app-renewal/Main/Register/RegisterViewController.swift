//
//  RegisterViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit
import SafariServices

class RegisterViewController: UIViewController {
    
    let registerView: RegisterView = RegisterView()
    var termsCheck: Bool = false
    var privacyCheck: Bool = false
    var nickNameCheck: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        registerView.nickNameTextField.delegate = self
    }
    
    func registerButtonSwitch(isOn: Bool) {
        switch isOn {
        case true:
            if termsCheck == true && privacyCheck == true && nickNameCheck == true {
                registerView.registerButton.isUserInteractionEnabled = true
                registerView.registerButton.backgroundColor = .nanuriGreen
            }
        case false:
            registerView.registerButton.isUserInteractionEnabled = false
            registerView.registerButton.backgroundColor = .nanuriGray3
        }
    }
    
    @objc func selectTermsCheckButton(sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            termsCheck = false
            registerButtonSwitch(isOn: termsCheck)
        } else {
            sender.isSelected = true
            termsCheck = true
            registerButtonSwitch(isOn: termsCheck)
        }
    }
    
    @objc func selectPrivacyCheckButton(sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            privacyCheck = false
            registerButtonSwitch(isOn: privacyCheck)
        } else {
            sender.isSelected = true
            privacyCheck = true
            registerButtonSwitch(isOn: privacyCheck)
        }
    }
    
    @objc func tappedPrivacyButton(sender: UIButton) {
        guard let url = URL(string: "https://www.google.com") else { return }
        let safari = SFSafariViewController(url: url)
        present(safari, animated: true)
    }
    
    @objc func tappedDismissButton() {
        self.dismiss(animated: true, completion: nil)
        
        // dismiss 하면서 저장된 UserDefaults 삭제
        // DB에서도 삭제해야하는지?
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
    
    @objc func tappedSignUpButton(_ sender: UIButton) {
        self.saveUserInfo()
    }

    private func saveUserInfo() {
        guard let registerNickName = registerView.nickNameTextField.text else { return }
        let params: [String: String] = ["nickname": registerNickName]
        NetworkService.shared.patchUserInfoRequest(parameters: params) { userInfo in
            DispatchQueue.main.async {
                print("데이터 저장 -> \(userInfo)")
                let viewController = TabBarController()
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(viewController)
            }
        }
    }
    
    func setUpView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(registerView)
        registerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        registerView.closeButton.addTarget(self, action: #selector(tappedDismissButton), for: .touchUpInside)

        registerView.registerButton.addTarget(self, action: #selector(tappedSignUpButton), for: .touchUpInside)

        registerView.termsCheckButton.addTarget(self, action: #selector(selectTermsCheckButton), for: .touchUpInside)

        registerView.termsLinkButton.addTarget(self, action: #selector(tappedPrivacyButton), for: .touchUpInside)

        registerView.privacyCheckButton.addTarget(self, action: #selector(selectPrivacyCheckButton), for: .touchUpInside)

        registerView.privacyLinkButton.addTarget(self, action: #selector(tappedPrivacyButton), for: .touchUpInside)
        
        // 화면 아무 곳이나 클릭시 키보드 사라지게 하는 코드
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    // 키보드의 Return 버튼을 클릭했을시 키보드가 사라지게
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        registerView.nickNameTextField.resignFirstResponder()
        return true
    }
    
    // 텍스트필드에 편집이 시작될때
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.isEditing && ((textField.text?.isEmpty) != nil) {
            textField.layer.borderColor = UIColor.nanuriGreen.cgColor
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // 닉네임 중복 체크
        let params: [String: String] = ["nickname": textField.text!]
        NetworkService.shared.getUserNicNameResquest(parameters: params) { userResult in
            DispatchQueue.main.async {
                if (textField.text?.count)! > 0 {
                    if userResult.count == 0 {
                        self.registerView.checkButton.backgroundColor = .white
                        self.registerView.checkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
                        self.registerView.checkButton.tintColor = .nanuriGreen
                        self.registerView.checkLabel.attributedText = .attributeFont(font: .PMedium, size: 13, text: "사용 가능한 닉네임입니다.", lineHeight: 15)
                        self.registerView.checkLabel.textColor = .nanuriGreen
                        textField.layer.borderColor = UIColor.nanuriGreen.cgColor
                        self.nickNameCheck = true
                        if self.termsCheck == true && self.privacyCheck == true {
                            self.registerView.registerButton.isUserInteractionEnabled = true
                            self.registerView.registerButton.backgroundColor = .nanuriGreen
                        }
                    } else {
                        self.nickNameCheck = false
                        self.registerView.checkButton.backgroundColor = .white
                        self.registerView.checkButton.setImage(UIImage(systemName: "exclamationmark"), for: .normal)
                        self.registerView.checkButton.tintColor = .nanuriRed
                        self.registerView.checkLabel.attributedText = .attributeFont(font: .PMedium, size: 13, text: "이미 등록된 닉네임입니다.", lineHeight: 15)
                        self.registerView.checkLabel.textColor = .nanuriRed
                        textField.layer.borderColor = UIColor.nanuriRed.cgColor
                        self.registerView.registerButton.isUserInteractionEnabled = false
                        self.registerView.registerButton.backgroundColor = .nanuriGray3
                    }
                } else {
                    self.nickNameCheck = false
                    textField.layer.borderColor = UIColor.nanuriGreen.cgColor
                    self.registerView.checkButton.setImage(nil, for: .normal)
                    self.registerView.checkLabel.textColor = .clear
                    self.registerView.registerButton.isUserInteractionEnabled = false
                    self.registerView.registerButton.backgroundColor = .nanuriGray3
                }
            }
        }
    }
    
    // 텍스트필드에 편집이 중지될떄
    func textFieldDidEndEditing(_ textField: UITextField) {
        if nickNameCheck == true {
            textField.layer.borderColor = UIColor.nanuriGreen.cgColor
        } else {
            textField.layer.borderColor = UIColor.nanuriRed.cgColor
        }
    }
}
