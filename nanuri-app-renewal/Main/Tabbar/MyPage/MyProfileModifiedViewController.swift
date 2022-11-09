//
//  MyProfileModifiedViewController.swift
//  nanuri-app-renewal
//
//  Created by a0000 on 2022/04/17.
//

import UIKit

class MyProfileModifiedViewController: UIViewController {
    
    var userInfo: UserInfo?
    
    var profileImageData: Data?
    
    let profileImageView = UIImageView()
    let profileNameTextField: UITextField = {
        let textField = UITextField()
        textField.toStyledTextField(textField)
        textField.addPadding(width: 16)
        return textField
    }()
    let regionModifyTextField: UITextField = {
        let textField = UITextField()
        textField.toStyledTextField(textField)
        textField.addPadding(width: 16)
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func networksetup() {
        guard let nickName = profileNameTextField.text else { return }
        guard let region = regionModifyTextField.text else { return }
        let imageData = profileImageData
        
        let userParams: [String: String] = ["nickname": nickName, "address": region]
        
        NetworkService.shared.patchUserInfoRequest(parameters: userParams, imageData: imageData, filename: "profileImage.jpeg", mimeType: "image/jpeg") { userInfo in
            print(userInfo)
        }
    }
    
    @objc func doneButtonTapped() {
        print("aaa")
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
        
        
        guard let userInfo = userInfo else { return }

        profileImageView.layer.cornerRadius = 96 / 2
        profileImageView.clipsToBounds = true
        if userInfo.profile == "" {
            profileImageView.image = UIImage(named: "myprofile_photo_ic")
        } else {
            let profileURL = userInfo.profile
            guard let imageURL = URL(string: profileURL),
                  let imageData = try? Data(contentsOf: imageURL)
            else { return }
            profileImageView.image = UIImage(data: imageData)
        }
        self.view.addSubview(profileImageView)
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(24)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(96)
        }
        
        let profileModifyButton = UIButton()
        profileModifyButton.setAttributedTitle(.attributeFont(font: .PRegular, size: 13, text: "변경하기", lineHeight: 13), for: .normal)
        profileModifyButton.setTitleColor(.nanuriGray6, for: .normal)
        self.view.addSubview(profileModifyButton)
        profileModifyButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).inset(-2)
            $0.centerX.equalToSuperview()
        }
        profileModifyButton.addTarget(self, action: #selector(selectAddImageButton), for: .touchUpInside)
        
        let nicNameLabel = UILabel()
        nicNameLabel.attributedText = .attributeFont(font: .PSemibold, size: 16, text: "닉네임", lineHeight: 19)
        self.view.addSubview(nicNameLabel)
        nicNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileModifyButton.snp.bottom).inset(-24)
            $0.left.equalTo(16)
        }
        
        profileNameTextField.attributedText = .attributeFont(font: .PRegular, size: 15, text: userInfo.nickName, lineHeight: 18)
        self.view.addSubview(profileNameTextField)
        profileNameTextField.snp.makeConstraints {
            $0.top.equalTo(nicNameLabel.snp.bottom).inset(-10)
            $0.left.equalTo(16)
            $0.right.equalTo(-16)
            $0.height.equalTo(44)
        }
        
        let regionModifyLabel = UILabel()
        regionModifyLabel.attributedText = .attributeFont(font: .PSemibold, size: 16, text: "지역 변경", lineHeight: 19)
        self.view.addSubview(regionModifyLabel)
        regionModifyLabel.snp.makeConstraints {
            $0.top.equalTo(profileNameTextField.snp.bottom).inset(-24)
            $0.left.equalTo(16)
        }
        
        regionModifyTextField.attributedText = .attributeFont(font: .PRegular, size: 15, text: userInfo.location, lineHeight: 18)
        self.view.addSubview(regionModifyTextField)
        regionModifyTextField.snp.makeConstraints {
            $0.top.equalTo(regionModifyLabel.snp.bottom).inset(-10)
            $0.left.equalTo(16)
            $0.right.equalTo(-16)
            $0.height.equalTo(44)
        }
        
        // 없앨 예정??
        let accountNumberLabel = UILabel()
        accountNumberLabel.attributedText = .attributeFont(font: .PSemibold, size: 16, text: "계좌번호", lineHeight: 19)
        self.view.addSubview(accountNumberLabel)
        accountNumberLabel.snp.makeConstraints {
            $0.top.equalTo(regionModifyTextField.snp.bottom).inset(-24)
            $0.left.equalTo(16)
        }
        
        let bankTextField = UITextField()
        bankTextField.toStyledTextField(bankTextField)
        bankTextField.addPadding(width: 16)
        bankTextField.attributedText = .attributeFont(font: .PRegular, size: 15, text: "기업은행", lineHeight: 18)
        self.view.addSubview(bankTextField)
        bankTextField.snp.makeConstraints {
            $0.top.equalTo(accountNumberLabel.snp.bottom).inset(-10)
            $0.left.equalTo(16)
            $0.width.equalTo(100)
            $0.height.equalTo(44)
        }
        
        let accountNumberTextField = UITextField()
        accountNumberTextField.toStyledTextField(accountNumberTextField)
        accountNumberTextField.addPadding(width: 16)
        accountNumberTextField.attributedText = .attributeFont(font: .PRegular, size: 15, text: "123-456-7891012", lineHeight: 18)
        self.view.addSubview(accountNumberTextField)
        accountNumberTextField.snp.makeConstraints {
            $0.top.equalTo(accountNumberLabel.snp.bottom).inset(-10)
            $0.left.equalTo(bankTextField.snp.right).inset(-6)
            $0.right.equalTo(-16)
            $0.height.equalTo(44)
        }
        
        let infoLabel = UILabel()
        infoLabel.attributedText = .attributeFont(font: .PRegular, size: 11, text: "거래시 정보 확인을 위하여 은행과 계좌번호를 받고 있습니다.\n타인에게 노출되는 내용이 아니니 안심하셔도 됩니다.", lineHeight: 13)
        infoLabel.textColor = .nanuriGray3
        infoLabel.numberOfLines = 2
        infoLabel.textAlignment = .right
        self.view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(accountNumberTextField.snp.bottom).inset(-6)
            $0.right.equalTo(-16)
        }
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
}


extension MyProfileModifiedViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            profileImageView.image = image
            self.profileImageData = image.jpegData(compressionQuality: 0.7)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
