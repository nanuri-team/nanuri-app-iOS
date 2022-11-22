//
//  MyProfileModifiedViewController.swift
//  nanuri-app-renewal
//
//  Created by a0000 on 2022/04/17.
//

import UIKit

class MyProfileModifiedViewController: UIViewController {
    
    var userInfo: UserInfo
    var profileImageData: Data?
    
    let profileView: ProfileView = {
        let view = ProfileView()
        return view
    }()
    
    init(userInfo: UserInfo) {
        self.userInfo = userInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
    }
    
    private func networksetup() {
        guard let nickName = self.profileView.profileNameTextField.text else { return }
        // TODO: 위치 데이터 받아오기
        guard let region = self.profileView.regionModifyTextField.text else { return }
        let imageData = profileImageData
        
        let userParams: [String: String] = ["nickname": nickName, "location": region]
        
        NetworkService.shared.patchUserInfoRequest(parameters: userParams, imageData: imageData, filename: "profileImage.jpeg", mimeType: "image/jpeg") { userInfo in
            print(userInfo)
        }
    }
    
    @objc func doneButtonTapped() {
        networksetup()
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUpView() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "프로필 수정"
        extendedLayoutIncludesOpaqueBars = true
        let backButton = UIBarButtonItem(image: UIImage(named: "back_ic"), style: .plain, target: self, action: #selector(selectBackButton))
        self.navigationItem.setLeftBarButton(backButton, animated: true)
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonTapped))
        doneButton.tintColor = .nanuriGreen
        self.navigationItem.setRightBarButton(doneButton, animated: true)

        self.view.addSubview(profileView)
        profileView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.profileView.regionButton.addTarget(self, action: #selector(tappedTextField), for: .touchUpInside)
        self.profileView.profileModifyButton.addTarget(self, action: #selector(selectAddImageButton), for: .touchUpInside)
        
        if userInfo.profile != "" {
            let profileURL = userInfo.profile
            guard let imageURL = URL(string: profileURL),
                  let imageData = try? Data(contentsOf: imageURL)
            else { return }
            self.profileView.profileImageView.image = UIImage(data: imageData)
        }
        if userInfo.location != "" {
            userInfo.location.currentLocation(userInfo: userInfo, completion: { currentLocation in
                self.profileView.regionModifyTextField.text = currentLocation
            })
        }
        self.profileView.profileNameTextField.text = userInfo.nickName
    }
    
    @objc func selectBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectAddImageButton() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true)
    }
    
    @objc func tappedTextField() {
        // TODO: 지역변경 페이지로 이동하기 -> 넘어간 페이지에서 오류 있음 수정해야함
        if userInfo.location != "" {
            let alert = CustomAlertViewController(firstTitle: "현재 위치를", frontSecondTitle: "변경하시겠습니까?", grayColorButtonTitle: "취소", greenColorButtonTitle: "변경하기", customAlertType: .doneAndCancel, alertHeight: 184)
            alert.delegate = self
            alert.modalTransitionStyle = .crossDissolve
            alert.modalPresentationStyle = .overFullScreen
            self.present(alert, animated: true)
        } else {
            let alert = CustomAlertViewController(firstTitle: "위치 권한을", frontSecondTitle: "허용하시겠습니까?", grayColorButtonTitle: "취소", greenColorButtonTitle: "허용하기", customAlertType: .doneAndCancel, alertHeight: 184)
            alert.delegate = self
            alert.modalTransitionStyle = .crossDissolve
            alert.modalPresentationStyle = .overFullScreen
            self.present(alert, animated: true)
        }
    }
}

extension MyProfileModifiedViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            self.profileView.profileImageView.image = image
            self.profileImageData = image.jpegData(compressionQuality: 0.7)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension MyProfileModifiedViewController: CustomAlertDelegate {
    func action() {
        let viewController = LocationPermissionViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func exit() {
        
    }
}
