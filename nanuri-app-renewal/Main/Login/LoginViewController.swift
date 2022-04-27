//
//  LoginViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit
import KakaoSDKUser
import Alamofire

class LoginViewController: UIViewController {
    let clientId = "ba607c1bb1fabf7060c476d4a65e30cd"
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
               // self.saveUserInfo()
            }
        }
    }
    
    
    @objc func selectApplelogin(_ sender: UIButton) {
        print("apple")
    }
    /*
    
    func saveUserInfo(){
        let strURL = "https://kauth.kakao.com/oauth/authorize?client_id=\(clientId)&redirect_uri=http://localhost:8080/api/auth/kakao/accounts/&response_type=code"
        guard let socialIdx = SnsUserInfoSingleton.shared.id else { return }
        let header: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
        let params:Parameters = ["social_id":socialIdx]
        
        AF.upload(multipartFormData: { multiFormData in
            for (key, value) in params {
                multiFormData.append(Data("\(value)".utf8), withName: key)
            }
        }, to: strURL, headers: header).responseDecodable(of: SnsId.self) { response in
            switch response.result {
            case .success(_):
               
                print("sucess reponse is :\(response)")
                guard let value = response.value else { return }
                Networking.sharedObject.getUserInfo(userID: value.data.userID) { result in
                    
                    UserSingleton.shared.userData = result
                    UserDefaults.standard.set(result.user.userID, forKey: "userID")

                    let addView = UIStoryboard(name: "Main" , bundle: nil)
                    guard let addVC = addView.instantiateViewController(withIdentifier: "tabBarView") as? TabBarController else { return }
                addVC.modalPresentationStyle = .fullScreen
                    self.present(addVC, animated: true, completion: nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    */
    /*
    func userInfo(){
        let strURL = "https://kauth.kakao.com/oauth/authorize?client_id=\(clientId)&redirect_uri=http://localhost:8080/api/auth/kakao/token/callback/&response_type=code"
        //shared 라는 건 singleton 객체라는 것
        UserApi.shared.me { user, error in
            if let error = error { /*error 가 !nil*/
                print(error.localizedDescription)
                return
            } else {
                //내부적으로 쓰는 구분..?
                if let kId =  user?.id {
                    
                    SnsUserInfoSingleton.shared.kakaoUserId = "\(kId)"
                    
                    // test
                    let header: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
                    let parameters = ["social_id":"\(SnsUserInfoSingleton.shared.kakaoUserId!)"]
                    
                    AF.upload(multipartFormData: { multiFormData in
                        for (key, value) in parameters {
                            multiFormData.append(Data("\(value)".utf8), withName: key)
                        }
                    }, to: strURL, headers: header).responseDecodable(of: SNSPostResponse.self) { response in
                        switch response.result {
                        case .success(_):
                            print("sucess reponse is :\(response)")
                            guard let value = response.value else { return }
                            SnsUserInfoSingleton.shared.id = value.data.id
                            if let registerVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "registerStoryboard") as? RegisterViewController {
                                registerVC.modalPresentationStyle = .fullScreen
                                self.present(registerVC,animated: true)
                                
                            }
                        case .failure(let error):
                            
                            print(error.localizedDescription)
                        }
                    }
                    
                }
                
            }
        }
    }
    */
    
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
