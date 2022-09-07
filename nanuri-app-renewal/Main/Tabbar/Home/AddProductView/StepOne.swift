//
//  StepOne.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/08/18.
//

import UIKit

extension AddProductViewController {
    
    /// 상품 등록 1페이지 유효성 검사
    func stepOneValidation() -> Bool {
        guard let productNameText = productNameTextField.text,
              let productLinkText = productLinkTextField.text,
              let productPriceText = productPriceTextField.text
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
            
            postImageData = addImageView.image
            
            return true
        }
    }
    
    /// 상품 등록 스텝 1
    func setUpStepOneView() {
        
        stepOneView.backgroundColor = .white
        stepOneView.alpha = 1.0
        self.view.addSubview(stepOneView)
        stepOneView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        let contentsScrollView = UIScrollView()
        let excludeScrollViewHeight = 260
        let scrollViewHeight = self.view.frame.height - CGFloat(excludeScrollViewHeight) - CGFloat(edgeHeight)
        contentsScrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: scrollViewHeight)
        contentsScrollView.contentSize = CGSize(width: contentsScrollView.frame.width, height: contentsScrollView.frame.height)
        stepOneView.addSubview(contentsScrollView)
        
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
}
