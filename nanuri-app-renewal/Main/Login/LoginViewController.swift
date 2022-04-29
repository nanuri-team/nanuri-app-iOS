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
//    var kakaoID: SnsId?
    
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
    
    
    func userInfo(){
        let strURL = "https://nanuri.app/api/auth/kakao/accounts/"
        
        
        
        //shared 라는 건 singleton 객체라는 것
        UserApi.shared.me { user, error in
            if let error = error { /*error 가 !nil*/
                print(error.localizedDescription)
                return
                
            } else {
                
                //내부적으로 쓰는 구분..?
                if let kId =  user?.id {
                    
//                    SnsUserInfoSingleton.shared.kakaoUserId = Int(kId)
                    
                    let params: Parameters = ["kakao_id":kId]
                    let alamo = AF.request(strURL, method: .post, parameters: params)
                    alamo.responseJSON { response in
//                        print("###\(response)")
                        switch response.result {
                        case .success(let value):
                            print(value)
//                           print("%%%%\(value)")
                            let registerVC = RegisterViewController()
                            registerVC.modalPresentationStyle = .fullScreen
                            self.present(registerVC,animated: true)
                            
                        case .failure(let error):
                            if let error = error.errorDescription {
                                print(error)
                            }
                        }
                    }
                    
                    // test
                    /*
                    let header: HTTPHeaders = ["Content-Type" : "multipart/form-data"]
                    let parameters = ["kakao_id":SnsUserInfoSingleton.shared.kakaoUserId!]
                  
                    AF.upload(multipartFormData: { multiFormData in
                        for (key, value) in parameters {
                            multiFormData.append(Data("\(value)".utf8), withName: key)
                            print("@@@@@@\(key),\(value)")
                        }
                    }, to: strURL, headers: header).responseDecodable(of: SNSPostResponse.self) { response in
                        print("@@@\(SNSPostResponse.self)")
                        switch response.result {
                        case .success(_):
                            print("sucess reponse is :\(response)")
                            guard let value = response.value else { return }
                            SnsUserInfoSingleton.shared.user = value.data.user
//                            if let registerVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "registerStoryboard") as? RegisterViewController {
                            let registerVC = RegisterViewController()
                                registerVC.modalPresentationStyle = .fullScreen
                                self.present(registerVC,animated: true)
                                
//                            }
                        case .failure(let error):
                            
                            print(error.localizedDescription)
                        }
                    }
                    
                    */
                }
                
            }
        }
    }
    
    
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
