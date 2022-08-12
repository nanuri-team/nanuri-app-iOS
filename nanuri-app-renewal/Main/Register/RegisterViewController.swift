//
//  RegisterViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit
import Alamofire
import SafariServices

class RegisterViewController: UIViewController {
    
    let registerView: RegisterView = {
        let view = RegisterView()
        return view
    }()
    
    var termsCheck: Bool = false
    var privacyCheck: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        registerView.nickNameTextField.delegate = self
    }
    
    func test(isOn: Bool) {
        switch isOn {
        case true:
            if termsCheck == true && privacyCheck == true {
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
        } else {
            sender.isSelected = true
            termsCheck = true
        }
    }
    
    @objc func selectPrivacyCheckButton(sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            privacyCheck = false
        } else {
            sender.isSelected = true
            privacyCheck = true
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
        if registerView.nickNameTextField.text?.isEmpty != nil && (registerView.nickNameTextField.text?.count)! >= 2 {
            if termsCheck == true && privacyCheck == true {
                print("--> 데이터 넘깁니다!")
                self.saveUserInfo()
                print("--> 데이터 받았습니다!")
                let tabbarViewController = TabBarController()
                tabbarViewController.modalTransitionStyle = .crossDissolve
                tabbarViewController.modalPresentationStyle = .overFullScreen
                self.present(tabbarViewController, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "약관에 동의해주세요.", message: "약관 동의는 필수입니다.", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .default, handler: { _ in print("test")} )
                alert.addAction(action)
                present(alert, animated: true)
            }
        } else {
            let alert = UIAlertController(title: "닉네임을 입력해주세요.", message: "닉네임은 필수입니다.", preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: { _ in print("test")} )
            alert.addAction(action)
            present(alert, animated: true)
        }
    }

    private func saveUserInfo() {
        if let tokenNum = UserDefaults.standard.object(forKey: "loginInfo") as? Data {
            let decoder = JSONDecoder()
            if let loadedToken = try? decoder.decode(SocialLogin.self, from: tokenNum) {
                print(" 저장됐음! \(loadedToken.token), \(loadedToken.uuid)")
                
                let strURL = "https://nanuri.app/api/v1/users/\(loadedToken.uuid)/"
                
                guard let registerNickName = registerView.nickNameTextField.text else { return }
                
                let headers: HTTPHeaders = [
                    "Content-Type": "multipart/form-data",
                    "Authorization": "Token \(loadedToken.token)"
                ]
                let userParams: Parameters = ["nickname": registerNickName]
                
                AF.upload(multipartFormData: { multiFormData in
                    for (key, value) in userParams {
                        multiFormData.append(Data("\(value)".utf8), withName: key)
                    }
                }, to: strURL, method: .patch, headers: headers).responseString { response in
                    switch response.result {
                    case .success(let value):
                        print("value -> \(value)")
                    case .failure(let error):
                        print("error -> \(error.localizedDescription)")
                    }
                }
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
    
    // 텍스트필드에 편집이 중지될떄
    func textFieldDidEndEditing(_ textField: UITextField) {
        // 사용가능한 닉네임인지 아닌지 체크해서 알려주기
        if textField.text?.isEmpty != nil {
            // 사용가능하면 체크표시
            if (textField.text?.count)! >= 2 {
                registerView.checkButton.backgroundColor = .white
                registerView.checkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
                registerView.checkButton.tintColor = .nanuriGreen
                registerView.checkLabel.attributedText = .attributeFont(font: .PMedium, size: 13, text: "사용 가능한 닉네임입니다.", lineHeight: 15)
                registerView.checkLabel.textColor = .nanuriGreen
                textField.layer.borderColor = UIColor.nanuriGray2.cgColor
            } else if (textField.text?.count)! >= 1 && (textField.text?.count)! < 2 {
                registerView.checkButton.backgroundColor = .white
                registerView.checkButton.setImage(UIImage(systemName: "exclamationmark"), for: .normal)
                registerView.checkButton.tintColor = .nanuriRed
                registerView.checkLabel.attributedText = .attributeFont(font: .PMedium, size: 13, text: "이미 등록된 닉네임입니다.", lineHeight: 15)
                registerView.checkLabel.textColor = .nanuriRed
                textField.layer.borderColor = UIColor.nanuriRed.cgColor
            } else {
                textField.layer.borderColor = UIColor.nanuriGray2.cgColor
                registerView.checkButton.setImage(nil, for: .normal)
                registerView.checkLabel.textColor = .clear
            }
        }
    }
}
