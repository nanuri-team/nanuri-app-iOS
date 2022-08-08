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

import AuthenticationServices

class LoginViewController: UIViewController {
    
    let loginView: LoginView = {
        let view = LoginView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginSetUpView()
    }
    
    @objc func selectKakaologin(_ sender: UIButton) {
        // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            self.loginWithKakaoApp()
        } else {
            self.loginWithKakaoWeb()
        }
    }
    
    @objc func selectApplelogin(_ sender: UIButton) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.email, .fullName]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func loginSetUpView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(loginView)
        loginView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        loginView.kakaoButton.addTarget(self, action: #selector(selectKakaologin), for: .touchUpInside)
        loginView.appleButton.addTarget(self, action: #selector(selectApplelogin), for: .touchUpInside)
    }
    
    private func presentView(_ viewController: UIViewController) {
        let registerViewController = viewController
        registerViewController.modalTransitionStyle = .crossDissolve
        registerViewController.modalPresentationStyle = .overFullScreen
        self.present(registerViewController, animated: true, completion: nil)
    }
}

// MARK: Kakao Login
extension LoginViewController {
    func loginWithKakaoApp() {
        UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoTalk() success.")
                
                //do something
                _ = oauthToken
                self.userInfo()
            }
        }
    }
    
    func loginWithKakaoWeb() {
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
    
    private func userInfo() {
        
        let strURL = "https://nanuri.app/api/auth/kakao/accounts/"

        UserApi.shared.me { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let kakaoId = user?.id {
                    guard let user = user,
                          let kakaoAccount = user.kakaoAccount,
                          let email = kakaoAccount.email
                    else { return }
                    
//                    UserDefaults.standard.set(email, forKey: "userEmail")
                    
                    let params: Parameters = ["kakao_id": kakaoId]
                    let alamo = AF.request(strURL, method: .post, parameters: params)
                    alamo.responseJSON { response in
                        switch response.result {
                        case .success(let value):
                            print("Success with key: \(value)")
                            
//                            if let token = value as? [String: String] {
//                                if let backToken = token["token"] {
//
//                                    UserDefaults.standard.set(backToken, forKey: "token")
//                                    if let tokenNum = UserDefaults.standard.string(forKey: "token") as? String {
//                                        print(tokenNum)
//                                    }
//                                }
//                            }
//
//                            if let uuid = value as? [String: String] {
//                                if let userUUID = uuid["uuid"] {
//                                    UserDefaults.standard.set(userUUID, forKey: "uuid")
//                                    if let userUuid = UserDefaults.standard.string(forKey: "uuid") as? String {
//                                        print(userUuid)
//                                    }
//                                }
//                            }
                            
                            self.presentView(RegisterViewController())
                            
                        case .failure(let error):
                            if let error = error.errorDescription {
                                print(error)
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: Apple Login
extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    // 로그인을 진행하는 화면
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
        
    // 로그인 성공
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            let idToken = appleIDCredential.identityToken!
            let tokeStr = String(data: idToken, encoding: .utf8)
            
            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
            print("token : \(String(describing: tokeStr))")
            
            let registerViewController = RegisterViewController()
            registerViewController.modalTransitionStyle = .crossDissolve
            registerViewController.modalPresentationStyle = .overFullScreen
            self.present(registerViewController, animated: true, completion: nil)
            
        default:
            break
        }
    }
    
    // 로그인 실패
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
}
