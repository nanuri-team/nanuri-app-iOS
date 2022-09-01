//
//  AddProductStepOneViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/21.
//

import UIKit

class AddProductStepOneViewController: UIViewController {

    let stepView = UIView()
    
    let productNameTextField = UITextField()
    let productLinkTextField = UITextField()
    let productPriceTextField = UITextField()
    let addImageView = UIImageView()

    
    var bottomViewHeight = 64
    var edgeHeight = 34
    var postProductInfo: [String: Any] = [:]
    var postImageData: UIImage!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "상품 등록하기"
        extendedLayoutIncludesOpaqueBars = true
        
        let closeButton = UIBarButtonItem(image: UIImage(named: "close_ic"), style: .plain, target: self, action: #selector(selectCloseButton))
        self.navigationItem.setLeftBarButton(closeButton, animated: true)
        
        self.view.backgroundColor = .white
        setUpStepView()
        setUpView()
        setUpBottomView()
        
    }
    
    @objc func selectCloseButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectNextButton() {
        
        guard validation() else {
            print("return")
            return
        }
        
        let addProductStepTwoViewController = AddProductStepTwoViewController()
        addProductStepTwoViewController.postProductInfo = postProductInfo
        addProductStepTwoViewController.postImageData = addImageView.image
        addProductStepTwoViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(addProductStepTwoViewController, animated: true)
    }
    
    @objc func selectAddImageButton() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true)
    }
    
    func validation() -> Bool {
        guard let productNameText = productNameTextField.text,
              let productLinkText = productLinkTextField.text,
              let productPriceText = productPriceTextField.text,
              let _ = addImageView.image
        else { return false }
        
        if productNameText.isEmpty ||
            productLinkText.isEmpty ||
            productPriceText.isEmpty {
            return false
        } else {
            postProductInfo["title"] = productNameText
            postProductInfo["product_url"] = productLinkText
            
            if let integerToProductPrice = Int(productPriceText) {
                postProductInfo["unit_price"] = integerToProductPrice
            } else {
                postProductInfo["unit_price"] = 0
            }
            return true
        }
    }
    
    func setUpStepView() {
        stepView.backgroundColor = .white
        self.view.addSubview(stepView)
        
        let stepGroupView = UIView()
        stepView.addSubview(stepGroupView)
        
        
        let stepOne = StepItemView(icon: UIImage(named: "step_one_w_ic")!, stepTitle: "상품 정보 입력", isActive: true)
        stepGroupView.addSubview(stepOne)
        stepOne.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        let stepTwo = StepItemView(icon: UIImage(named: "step_two_ic")!, stepTitle: "공구 내용 작성")
        stepGroupView.addSubview(stepTwo)
        stepTwo.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(stepOne.snp.right).inset(-27)
        }
        
        let stepThree = StepItemView(icon: UIImage(named: "step_three_ic")!, stepTitle: "카테고리 선택")
        stepGroupView.addSubview(stepThree)
        stepThree.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(stepTwo.snp.right).inset(-27)
        }
        
        let stepFour = StepItemView(icon: UIImage(named: "step_four_ic")!, stepTitle: "나눔 방법 선택")
        stepGroupView.addSubview(stepFour)
        stepFour.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(stepThree.snp.right).inset(-27)
        }
        
        stepGroupView.snp.makeConstraints { make in
            make.top.equalTo(stepOne.snp.top)
            make.left.equalTo(stepOne.snp.left)
            make.right.equalTo(stepFour.snp.right)
            make.bottom.equalTo(stepOne.snp.bottom)
            make.center.equalToSuperview()
        }
        
        stepView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(156)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
       
    }

    func setUpView() {
  
        let separatorView = UIView()
        self.view.addSubview(separatorView)
        separatorView.backgroundColor = .nanuriGray1
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(stepView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(16)
        }
        
        let contentsScrollView = UIScrollView()
        let excludeScrollViewHeight = 260
        let scrollViewHeight = self.view.frame.height - CGFloat(excludeScrollViewHeight) - CGFloat(edgeHeight)
        contentsScrollView.frame = CGRect(x: 0, y: CGFloat(excludeScrollViewHeight), width: self.view.frame.width, height: scrollViewHeight)
        contentsScrollView.contentSize = CGSize(width: contentsScrollView.frame.width, height: contentsScrollView.frame.height)
        self.view.addSubview(contentsScrollView)
        
        let productNameLabel = UILabel()
        productNameLabel.attributedText = .attributeFont(font: .PSemibold, size: 16, text: "상품명", lineHeight: 19)
        contentsScrollView.addSubview(productNameLabel)
        productNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.left.right.equalToSuperview().inset(16)
        }
        
        productNameTextField.autocapitalizationType = .none
        productNameTextField.attributedText = .attributeFont(font: .PRegular, size: 15, text: "", lineHeight: 18)
        productNameTextField.attributedPlaceholder = .attributeFont(font: .PRegular, size: 15, text: "공구할 상품의 이름이 무엇인가요?", lineHeight: 18)
        productNameTextField.borderStyle = .line
        productNameTextField.clipsToBounds = true
        productNameTextField.layer.borderWidth = 1
        productNameTextField.layer.borderColor = UIColor.nanuriGray2.cgColor
        productNameTextField.layer.cornerRadius = 4
        productNameTextField.addPadding(width: 16)
        contentsScrollView.addSubview(productNameTextField)
        productNameTextField.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).inset(-10)
            make.height.equalTo(44)
            make.left.right.equalTo(self.view).inset(16)
        }
        
        let productLinkLabel = UILabel()
        productLinkLabel.attributedText = .attributeFont(font: .PSemibold, size: 16, text: "구매 링크", lineHeight: 19)
        contentsScrollView.addSubview(productLinkLabel)
        productLinkLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameTextField.snp.bottom).inset(-32)
            make.left.right.equalToSuperview().inset(16)
        }
        
        productLinkTextField.autocapitalizationType = .none
        productLinkTextField.attributedText = .attributeFont(font: .PRegular, size: 15, text: "", lineHeight: 18)
        productLinkTextField.attributedPlaceholder = .attributeFont(font: .PRegular, size: 15, text: "이 상품을 구매할 링크가 어디인가요?", lineHeight: 18)
        productLinkTextField.borderStyle = .line
        productLinkTextField.clipsToBounds = true
        productLinkTextField.layer.borderWidth = 1
        productLinkTextField.layer.borderColor = UIColor.nanuriGray2.cgColor
        productLinkTextField.layer.cornerRadius = 4
        productLinkTextField.addPadding(width: 16)
        contentsScrollView.addSubview(productLinkTextField)
        productLinkTextField.snp.makeConstraints { make in
            make.top.equalTo(productLinkLabel.snp.bottom).inset(-10)
            make.height.equalTo(44)
            make.left.right.equalTo(self.view).inset(16)
        }
        
        let productPriceLabel = UILabel()
        productPriceLabel.attributedText = .attributeFont(font: .PSemibold, size: 16, text: "상품 가격", lineHeight: 19)
        contentsScrollView.addSubview(productPriceLabel)
        productPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(productLinkTextField.snp.bottom).inset(-32)
            make.left.right.equalToSuperview().inset(16)
        }
        
        productPriceTextField.attributedText = .attributeFont(font: .PRegular, size: 15, text: "", lineHeight: 18)
        productPriceTextField.attributedPlaceholder = .attributeFont(font: .PRegular, size: 15, text: "공구할 사람들이 이 상품을 얼마에 살 수 있나요?", lineHeight: 18)
        productPriceTextField.borderStyle = .line
        productPriceTextField.clipsToBounds = true
        productPriceTextField.layer.borderWidth = 1
        productPriceTextField.layer.borderColor = UIColor.nanuriGray2.cgColor
        productPriceTextField.layer.cornerRadius = 4
        productPriceTextField.addPadding(width: 16)
        contentsScrollView.addSubview(productPriceTextField)
        productPriceTextField.snp.makeConstraints { make in
            make.top.equalTo(productPriceLabel.snp.bottom).inset(-10)
            make.height.equalTo(44)
            make.left.right.equalTo(self.view).inset(16)
        }
        
        let unitLabel = UILabel()
        unitLabel.backgroundColor = .white
        unitLabel.attributedText = .attributeFont(font: .PBold, size: 15, text: "원", lineHeight: 18)
        unitLabel.textColor = .nanuriGray4
        productPriceTextField.addSubview(unitLabel)
        unitLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(11.5)
        }
        
        let priceInfoLabel = UILabel()
        priceInfoLabel.attributedText = .attributeFont(font: .PRegular, size: 12, text: "상품 가격이 결정되지 않은 경우는 0원으로 적어주세요!", lineHeight: 13)
        priceInfoLabel.textColor = .nanuriGray3
        contentsScrollView.addSubview(priceInfoLabel)
        priceInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(productPriceTextField.snp.bottom).inset(-4)
            make.right.equalTo(self.view).inset(16)
        }
        
        let imageLabel = UILabel()
        imageLabel.attributedText = .attributeFont(font: .PSemibold, size: 16, text: "이미지 첨부", lineHeight: 19)
        contentsScrollView.addSubview(imageLabel)
        imageLabel.snp.makeConstraints { make in
            make.top.equalTo(priceInfoLabel.snp.bottom).inset(-32)
            make.left.right.equalToSuperview().inset(16)
        }
        
        let addImageButton = UIButton()
        addImageButton.setImage(UIImage(named: "camera_ic"), for: .normal)
        addImageButton.layer.borderWidth = 1
        addImageButton.layer.borderColor = UIColor.nanuriGray2.cgColor
        addImageButton.layer.cornerRadius = 4
        contentsScrollView.addSubview(addImageButton)
        addImageButton.snp.makeConstraints { make in
            make.height.width.equalTo(64)
            make.top.equalTo(imageLabel.snp.bottom).inset(-10)
            make.left.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(100)
        }
        addImageButton.addTarget(self, action: #selector(selectAddImageButton), for: .touchUpInside)
        
        addImageView.layer.backgroundColor = UIColor.nanuriGray2.cgColor
        addImageView.layer.cornerRadius = 4
        addImageView.clipsToBounds = true
        contentsScrollView.addSubview(addImageView)
        addImageView.snp.makeConstraints { make in
            make.height.width.equalTo(64)
            make.top.equalTo(imageLabel.snp.bottom).inset(-10)
            make.left.equalTo(addImageButton.snp.right).inset(-10)
            make.bottom.equalToSuperview().inset(100)
        }
        
    }
    
    func setUpBottomView() {
        let bottomView = UIView()
        bottomView.backgroundColor = .white
        self.view.addSubview(bottomView)
        self.view.bringSubviewToFront(bottomView)
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.right.left.equalToSuperview()
            make.height.equalTo(bottomViewHeight)
        }
        
        let topLineView = UIView()
        topLineView.backgroundColor = .nanuriGray2
        bottomView.addSubview(topLineView)
        topLineView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalToSuperview()
        }
        
        let nextButton = MainButton(style: .main)
        nextButton.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: "다음", lineHeight: 18), for: .normal)
        bottomView.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(8)
        }
        nextButton.addTarget(self, action: #selector(selectNextButton), for: .touchUpInside)
    }

}

extension AddProductStepOneViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            addImageView.image = image
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
