//
//  RegisterViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    var user: UserInfo?
    var userParams: [String : Any] = [:]
    // 사용자정보
    let nickNameTextField = UITextField()
    
    // 사용자정보
    var nickname = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        
       
    }
    
    @objc func selectTermsCheckButton(sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    @objc func selectPrivacyCheckButton(sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    @objc func actSignUp(){
        print("actSignup")
        saveUserInfo()
        
    }
    
    @objc func selectSignUpBtn(_ sender: Any) {
        
        saveUserInfo()
    }
    /*
    func saveUserInfo() {
            guard let userUUID = UserDefaults.standard.string(forKey: "uuid") else { return }
            let strURL = "https://nanuri.app/api/v1/users/\(userUUID)"
    //        let strURL = "http://localhost:8080/api/v1/users/"
            guard let userToken = UserDefaults.standard.string(forKey: "token") else { return }
            
            guard let userEmail = UserDefaults.standard.string(forKey: "email") else { return }
            
            guard let registerNickname = nickNameTextField.text else { return }
           print("nickname: \(registerNickname)")
            let header: HTTPHeaders = [
                "Content-Type" : "multipart/form-data",
                "Content-Disposition": "form-data",
                "Authorization": "Token \(userToken)"
            ]
            
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(Data(registerNickname.utf8), withName: "nickname")
            }, to: strURL, method: .patch, headers: header).responseJSON { response in
                print("[response result] \(response)")
                switch response.result {
                case .success(_):
                    print("success: \(response)")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
    //        let userParams:Parameters = ["nickname": registerNickname]
            

    //        print("@@@\(registerNickname)")
    //        AF.upload(multipartFormData: { multiFormData in
    //            for (key, value) in userParams {
    //                multiFormData.append(Data("\(value)".utf8), withName: key)
    //            }
    //        }, to: strURL, headers: header).responseString { response in
    //            switch response.result {
    //            case .success(_):
    //                print("success:\(response)")
    //                guard let value = response.value else { return }
    //                Networking.sharedObject.patchUserListRequest(url: strURL, params: userParams) { response in
    //                    print(response)
    //                    print("유저정보:\(userParams)")
    //                }
    //                let homeVC = HomeViewController()
    //
    //                homeVC.modalPresentationStyle = .fullScreen
    //                self.present(homeVC, animated: true, completion: nil)
    //
    //            case .failure(let error):
    //                print(error.localizedDescription)
    //
    //            }
    //        }
            
            
        }
    */
    //@@@@@@@@
    
    func saveUserInfo() {
        guard let userUUID = UserDefaults.standard.string(forKey: "uuid") else { return }
        let strURL = "https://nanuri.app/api/v1/users/\(userUUID)"
//        let strURL = "http://localhost:8080/api/v1/users/"
        guard let userToken = UserDefaults.standard.string(forKey: "token") else { return }
        
        guard let userEmail = UserDefaults.standard.string(forKey: "email") else { return }
        
        guard let registerNickname = nickNameTextField.text else { return }
       
        let header: HTTPHeaders = [
            "Content-Type" : "multipart/form-data",
            "Authorization": "Token \(userToken)"
        ]
        let userParams:Parameters = ["nickname": registerNickname]
        
        AF.upload( multipartFormData: { multiFormData in
            for (key, value) in userParams {
                multiFormData.append(Data("\(value)".utf8), withName: key)
            }
        }, to: strURL,method:.patch , headers: header).responseString { response in
            switch response.result {
            case .success(_):
                print("success:\(response)")
                guard let value = response.value else { return }
                print("value: \(value)")
                let tabVC = TabBarController()
                
                tabVC.modalPresentationStyle = .fullScreen
                self.present(tabVC, animated: true, completion: nil)

            case .failure(let error):
                print(error.localizedDescription)

            }
        }
        
        
    }
     
    //@@@@@@@@
    
    func setUpView() {
        self.view.backgroundColor = .white
        
        let closeButton = UIButton()
        closeButton.setImage(UIImage(named: "close_ic"), for: .normal)
        self.view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(12)
            make.left.equalToSuperview().inset(16)
        }
        
        let welcomeTitleLabel = UILabel()
        welcomeTitleLabel.attributedText = .attributeFont(font: .PBold, size: 28, text: "환영합니다!", lineHeight: 34)
        self.view.addSubview(welcomeTitleLabel)
        welcomeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).inset(-66)
            make.left.right.equalToSuperview().inset(24)
        }
        
        let requiredLabel = UILabel()
        requiredLabel.attributedText = .attributeFont(font: .PSemibold, size: 16, text: "*", lineHeight: 19)
        requiredLabel.textColor = .nanuriRed
        self.view.addSubview(requiredLabel)
        requiredLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeTitleLabel.snp.bottom).inset(-32)
            make.left.equalToSuperview().inset(24)
        }
        
        
        let nickNameLabel = UILabel()
        nickNameLabel.attributedText = .attributeFont(font: .PSemibold, size: 16, text: "닉네임을 설정해주세요.", lineHeight: 19)
        self.view.addSubview(nickNameLabel)
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeTitleLabel.snp.bottom).inset(-32)
            make.left.equalTo(requiredLabel.snp.right).inset(-4)
        }
        
        
        nickNameTextField.placeholder = "닉네임(영문, 한글 20자 이내)"
        nickNameTextField.attributedText = .attributeFont(font: .PRegular, size: 15, text: "", lineHeight: 18)
        nickNameTextField.borderStyle = .line
        nickNameTextField.clipsToBounds = true
        nickNameTextField.layer.borderWidth = 1
        nickNameTextField.layer.borderColor = UIColor.nanuriGray2.cgColor
        nickNameTextField.layer.cornerRadius = 4
        nickNameTextField.addPadding(width: 16)
        self.view.addSubview(nickNameTextField)
        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom).inset(-10)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }
        
        let registerButton = MainButton(style: .main)
        registerButton.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: "회원가입", lineHeight: 18), for: .normal)
        registerButton.addTarget(self, action: #selector(selectSignUpBtn), for: .touchUpInside)
        self.view.addSubview(registerButton)
        registerButton.addTarget(self, action: #selector(actSignUp), for: .touchUpInside)
        registerButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(32)
            make.left.right.equalToSuperview().inset(16)
        }
        
        let termsCheckButton = CheckboxButton()
        self.view.addSubview(termsCheckButton)
        termsCheckButton.snp.makeConstraints { make in
            make.bottom.equalTo(registerButton.snp.top).inset(-32)
            make.left.equalToSuperview().inset(32)
        }
        termsCheckButton.addTarget(self, action: #selector(selectTermsCheckButton), for: .touchUpInside)
        
        let termsLabel = UILabel()
        termsLabel.attributedText = .attributeFont(font: .PRegular, size: 15, text: "이용약관 에 동의합니다. (필수)", lineHeight: 18)
        self.view.addSubview(termsLabel)
        termsLabel.snp.makeConstraints { make in
            make.bottom.equalTo(registerButton.snp.top).inset(-32)
            make.left.equalTo(termsCheckButton.snp.right).inset(-10)
        }
        
        let privacyCheckButton = CheckboxButton()
        privacyCheckButton.isSelected = false
        self.view.addSubview(privacyCheckButton)
        privacyCheckButton.snp.makeConstraints { make in
            make.bottom.equalTo(termsCheckButton.snp.top).inset(-17)
            make.left.equalToSuperview().inset(32)
        }
        privacyCheckButton.addTarget(self, action: #selector(selectPrivacyCheckButton), for: .touchUpInside)
        
        let privacyLabel = UILabel()
        privacyLabel.attributedText = .attributeFont(font: .PRegular, size: 15, text: "개인정보처리방침 에 동의합니다. (필수)", lineHeight: 18)
        self.view.addSubview(privacyLabel)
        privacyLabel.snp.makeConstraints { make in
            make.bottom.equalTo(termsLabel.snp.top).inset(-22)
            make.left.equalTo(privacyCheckButton.snp.right).inset(-10)
        }
        
        
    }
    

}
