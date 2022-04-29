//
//  LoginViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import Alamofire

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        
        snsloginSetUpView()
    }
    
    @objc func selectKakaologin(_ sender: UIButton) {
        UserApi.shared.loginWithKakaoAccount(prompts: [.Login]) { (oauthToken, error) in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoAccount() success")
                
                // do something
                _ = oauthToken
                self.userInfo()
            }
        }
    }
    
    
    @objc func selectApplelogin(_ sender: UIButton) {
        print("apple")
    }
    
    //####
    func userInfo(){
//        let strURL = "http://localhost:8080/api/auth/kakao/accounts/"
        
        let strURL = "https://nanuri.app/api/auth/kakao/accounts/"
        
        //shared 라는 건 singleton 객체라는 것
        UserApi.shared.me { user, error in
            if let error = error { /*error 가 !nil*/
                print(error.localizedDescription)
                return
                
            } else {
                
                //내부적으로 쓰는 구분..?
                if let kId =  user?.id {
                    

                    
                    let params: Parameters = ["kakao_id":kId]
                    let alamo = AF.request(strURL, method: .post, parameters: params)
                    alamo.responseJSON { response in

                        switch response.result {
                        case .success(let value):
                            print("Success with key: \(value)")
                            
                            if let token = value as? [String: String] {
                                if let backToken = token["token"] {

                                    UserDefaults.standard.set(backToken, forKey: "token")
                                    if let tokenNum = UserDefaults.standard.string(forKey: "token") as? String {
                                        print(tokenNum)
                                    }

                                }
                            }
                            
                            if let uuid = value as? [String: String] {
                                if let userUUID = uuid["uuid"] {
                                    UserDefaults.standard.set(userUUID, forKey: "uuid")
                                    if let userUuid = UserDefaults.standard.string(forKey: "uuid") as? String {
                                        print(userUuid)
                                    }
                                }
                            }
                            
                            

                            let registerVC = RegisterViewController()
                            registerVC.modalPresentationStyle = .fullScreen
                            self.present(registerVC,animated: true)
                            
                        case .failure(let error):
                            if let error = error.errorDescription {
                                print(error)
                            }
                        }
                    }
                 
                }
                
            }
        }
    } // ####
    
    
    func snsloginSetUpView(){
        let logoImageView = UIImageView()
        self.view.addSubview(logoImageView)
        logoImageView.image = UIImage(named: "login_logo_ic")
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(172)
            $0.width.equalTo(148)
            $0.height.equalTo(48)
        }
        // Button
        let kakaoButton = UIButton()
        kakaoButton.setImage(UIImage(named: "snskakao_ic"), for: .normal)
        self.view.addSubview(kakaoButton)
        kakaoButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(logoImageView.snp.bottom).offset(164)
            $0.width.equalTo(311)
            $0.height.equalTo(46)
        }
        kakaoButton.addTarget(self, action: #selector(self.selectKakaologin), for: .touchUpInside)
        
        let appleButton = UIButton()
        appleButton.setImage(UIImage(named: "snsapple_ic"), for: .normal)
        self.view.addSubview(appleButton)
        appleButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(kakaoButton.snp.bottom).offset(10)
            $0.width.equalTo(311)
            $0.height.equalTo(46)
        }
        appleButton.addTarget(self, action: #selector(selectApplelogin), for: .touchUpInside)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
