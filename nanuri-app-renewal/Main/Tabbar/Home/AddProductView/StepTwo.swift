//
//  StepTwo.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/08/23.
//

import UIKit

extension AddProductViewController {
    
    /// 상품 등록 2페이지 유효성 검사
    func stepTwoValidation() -> Bool {
        guard let productLocationText = productLocationTextField.text,
              let minimumRecruitmentText = minimumRecruitmentTextField.text,
              let maximumRecruitmentText = maximumRecruitmentTextField.text,
              let detailContentsText = detailContentsTextView.text,
              let recruitmentPeriodText = recruitmentPeriodTextField.text
        else { return false }
        
        if productLocationText.isEmpty ||
            minimumRecruitmentText.isEmpty ||
            maximumRecruitmentText.isEmpty ||
            detailContentsText.isEmpty ||
            recruitmentPeriodText.isEmpty {
            return false
        } else {
            postProductInfo["writer_address"] = productLocationText
            
            if let integerToMinimumRecruitment = Int(minimumRecruitmentText) {
                postProductInfo["min_participants"] = integerToMinimumRecruitment
            } else {
                postProductInfo["min_participants"] = 1
            }
            
            if let integerToMaximumRecruitment = Int(maximumRecruitmentText) {
                postProductInfo["max_participants"] = integerToMaximumRecruitment
            } else {
                postProductInfo["max_participants"] = 0
            }
            
            postProductInfo["waited_until"] = DateFormatter().changeDateFormat(selectDate, format: .dahsed)
            postProductInfo["waited_from"] = DateFormatter().changeDateFormat(Date(), format: .dahsed)
            postProductInfo["description"] = detailContentsText
            
            
            return true
        }
    }
    
    func setUpStepTwoView() {
        
        stepTwoView.backgroundColor = .white
        stepTwoView.alpha = 0.0
        self.view.addSubview(stepTwoView)
        stepTwoView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    
        let contentsScrollView = UIScrollView()
        let excludeScrollViewHeight = 260
        let scrollViewHeight = self.view.frame.height - CGFloat(excludeScrollViewHeight) - CGFloat(edgeHeight)
        contentsScrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: scrollViewHeight)
        contentsScrollView.contentSize = CGSize(width: contentsScrollView.frame.width, height: contentsScrollView.frame.height)
        stepTwoView.addSubview(contentsScrollView)
        
        let productLocation = UILabel()
        productLocation.attributedText = .attributeFont(font: .PSemibold, size: 16, text: "판매자 지역", lineHeight: 19)
        contentsScrollView.addSubview(productLocation)
        productLocation.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.left.right.equalToSuperview().inset(16)
        }
        
        productLocationTextField.attributedText = .attributeFont(font: .PRegular, size: 15, text: Singleton.shared.testLocation, lineHeight: 18)
        productLocationTextField.textColor = .nanuriGray4
        productLocationTextField.borderStyle = .line
        productLocationTextField.clipsToBounds = true
        productLocationTextField.backgroundColor = .nanuriGray1
        productLocationTextField.layer.borderWidth = 1
        productLocationTextField.layer.borderColor = UIColor.nanuriGray2.cgColor
        productLocationTextField.layer.cornerRadius = 4
        productLocationTextField.isEnabled = false
        productLocationTextField.addPadding(width: 16)
        contentsScrollView.addSubview(productLocationTextField)
        productLocationTextField.snp.makeConstraints { make in
            make.top.equalTo(productLocation.snp.bottom).inset(-10)
            make.height.equalTo(44)
            make.left.right.equalTo(self.view).inset(16)
        }
        
        let recruitmentLabel = UILabel()
        recruitmentLabel.attributedText = .attributeFont(font: .PSemibold, size: 16, text: "모집 인원", lineHeight: 19)
        contentsScrollView.addSubview(recruitmentLabel)
        recruitmentLabel.snp.makeConstraints { make in
            make.top.equalTo(productLocationTextField.snp.bottom).inset(-32)
            make.left.right.equalToSuperview().inset(16)
        }
        
        minimumRecruitmentTextField.attributedText = .attributeFont(font: .PRegular, size: 15, text: "", lineHeight: 18)
        minimumRecruitmentTextField.attributedPlaceholder = .attributeFont(font: .PRegular, size: 15, text: "최소 인원", lineHeight: 18)
        minimumRecruitmentTextField.keyboardType = .numberPad
        minimumRecruitmentTextField.borderStyle = .line
        minimumRecruitmentTextField.clipsToBounds = true
        minimumRecruitmentTextField.layer.borderWidth = 1
        minimumRecruitmentTextField.layer.borderColor = UIColor.nanuriGray2.cgColor
        minimumRecruitmentTextField.layer.cornerRadius = 4
        minimumRecruitmentTextField.addPadding(width: 16)
        contentsScrollView.addSubview(minimumRecruitmentTextField)
        minimumRecruitmentTextField.snp.makeConstraints { make in
            make.top.equalTo(recruitmentLabel.snp.bottom).inset(-10)
            make.height.equalTo(44)
            make.left.equalToSuperview().inset(16)
            make.width.equalToSuperview().multipliedBy(0.43)
        }
        
        let minUnitLabel = UILabel()
        minUnitLabel.attributedText = .attributeFont(font: .PBold, size: 15, text: "명", lineHeight: 18)
        minUnitLabel.textColor = .nanuriGray4
        minimumRecruitmentTextField.addSubview(minUnitLabel)
        minUnitLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(11.5)
            make.centerY.equalToSuperview()
        }
        
        let minInfoLabel = UILabel()
        minInfoLabel.attributedText = .attributeFont(font: .PRegular, size: 11, text: "최소 1명 이상", lineHeight: 13)
        minInfoLabel.textColor = .nanuriGray3
        contentsScrollView.addSubview(minInfoLabel)
        minInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(minimumRecruitmentTextField.snp.bottom).inset(-4)
            make.right.equalTo(minimumRecruitmentTextField.snp.right)
        }
        
        
        let fromLabel = UILabel()
        fromLabel.attributedText = .attributeFont(font: .PRegular, size: 15, text: "~", lineHeight: 18)
        fromLabel.textColor = .nanuriGray4
        contentsScrollView.addSubview(fromLabel)
        fromLabel.snp.makeConstraints { make in
            make.top.equalTo(recruitmentLabel.snp.bottom).inset(-23)
            make.left.equalTo(minimumRecruitmentTextField.snp.right).inset(-4)
        }
        
        maximumRecruitmentTextField.attributedText = .attributeFont(font: .PRegular, size: 15, text: "", lineHeight: 18)
        maximumRecruitmentTextField.attributedPlaceholder = .attributeFont(font: .PRegular, size: 15, text: "최대 인원", lineHeight: 18)
        maximumRecruitmentTextField.keyboardType = .numberPad
        maximumRecruitmentTextField.borderStyle = .line
        maximumRecruitmentTextField.clipsToBounds = true
        maximumRecruitmentTextField.layer.borderWidth = 1
        maximumRecruitmentTextField.layer.borderColor = UIColor.nanuriGray2.cgColor
        maximumRecruitmentTextField.layer.cornerRadius = 4
        maximumRecruitmentTextField.addPadding(width: 16)
        contentsScrollView.addSubview(maximumRecruitmentTextField)
        maximumRecruitmentTextField.snp.makeConstraints { make in
            make.top.equalTo(recruitmentLabel.snp.bottom).inset(-10)
            make.height.equalTo(44)
            make.left.equalTo(fromLabel.snp.right).inset(-4)
            make.width.equalToSuperview().multipliedBy(0.43)
        }
        
        let maxUnitLabel = UILabel()
        maxUnitLabel.attributedText = .attributeFont(font: .PBold, size: 15, text: "명", lineHeight: 18)
        maxUnitLabel.textColor = .nanuriGray4
        maximumRecruitmentTextField.addSubview(maxUnitLabel)
        maxUnitLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(11.5)
            make.centerY.equalToSuperview()
        }
        
        let maxInfoLabel = UILabel()
        maxInfoLabel.attributedText = .attributeFont(font: .PRegular, size: 11, text: "최대 100명 이하", lineHeight: 13)
        maxInfoLabel.textColor = .nanuriGray3
        contentsScrollView.addSubview(maxInfoLabel)
        maxInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(maximumRecruitmentTextField.snp.bottom).inset(-4)
            make.right.equalTo(maximumRecruitmentTextField.snp.right)
        }
        
        let recruitmentPeriodLabel = UILabel()
        recruitmentPeriodLabel.attributedText = .attributeFont(font: .PSemibold, size: 16, text: "모집 기간", lineHeight: 19)
        contentsScrollView.addSubview(recruitmentPeriodLabel)
        recruitmentPeriodLabel.snp.makeConstraints { make in
            make.top.equalTo(maximumRecruitmentTextField.snp.bottom).inset(-32)
            make.left.right.equalToSuperview().inset(16)
        }
        
        recruitmentPeriodTextField.attributedText = .attributeFont(font: .PRegular, size: 15, text: "", lineHeight: 18)
        recruitmentPeriodTextField.attributedPlaceholder = .attributeFont(font: .PRegular, size: 15, text: "모집 기간", lineHeight: 18)
        recruitmentPeriodTextField.borderStyle = .line
        recruitmentPeriodTextField.clipsToBounds = true
        recruitmentPeriodTextField.layer.borderWidth = 1
        recruitmentPeriodTextField.layer.borderColor = UIColor.nanuriGray2.cgColor
        recruitmentPeriodTextField.layer.cornerRadius = 4
        recruitmentPeriodTextField.addPadding(width: 16)
        contentsScrollView.addSubview(recruitmentPeriodTextField)
        recruitmentPeriodTextField.snp.makeConstraints { make in
            make.top.equalTo(recruitmentPeriodLabel.snp.bottom).inset(-10)
            make.height.equalTo(44)
            make.left.right.equalTo(self.view).inset(16)
        }
        
        let datePickerView = UIDatePicker()
        // set Up PickerView
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePickerView.minimumDate = Date()
        datePickerView.maximumDate = Calendar.current.date(byAdding: .month, value: 3, to: Date())
        datePickerView.locale = Locale(identifier: "ko")
        datePickerView.addTarget(self, action: #selector(selectDatePickerView), for: .valueChanged)
        datePickerView.datePickerMode = .date
        recruitmentPeriodTextField.inputView = datePickerView
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: #selector(selectDayDoneButton))
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        recruitmentPeriodTextField.inputAccessoryView = toolBar
        
        let periodInfoLabel = UILabel()
        periodInfoLabel.attributedText = .attributeFont(font: .PRegular, size: 11, text: "최대 기간 3개월", lineHeight: 13)
        periodInfoLabel.textColor = .nanuriGray3
        contentsScrollView.addSubview(periodInfoLabel)
        periodInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(recruitmentPeriodTextField.snp.bottom).inset(-4)
            make.right.equalTo(recruitmentPeriodTextField.snp.right)
        }
        
        let detailContentsLabel = UILabel()
        detailContentsLabel.attributedText = .attributeFont(font: .PSemibold, size: 16, text: "상세 내용", lineHeight: 19)
        contentsScrollView.addSubview(detailContentsLabel)
        detailContentsLabel.snp.makeConstraints { make in
            make.top.equalTo(recruitmentPeriodTextField.snp.bottom).inset(-32)
            make.left.right.equalToSuperview().inset(16)
        }
        
        detailContentsTextView.delegate = self
        detailContentsTextView.attributedText = .attributeFont(font: .PRegular, size: 15, text: "", lineHeight: 18)
        detailContentsTextView.placeholder(text: "상세 내용 또는 진행 방법을\n구매자가 알 수 있도록 자세히 입력해주세요.\n(예: 가격 책정 기준, 배송비, 주문 기간 등)")
        detailContentsTextView.textContainerInset = UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16)
        detailContentsTextView.layer.borderWidth = 1
        detailContentsTextView.layer.borderColor = UIColor.nanuriGray2.cgColor
        detailContentsTextView.layer.cornerRadius = 4
        contentsScrollView.addSubview(detailContentsTextView)
        detailContentsTextView.snp.makeConstraints { make in
            make.top.equalTo(detailContentsLabel.snp.bottom).inset(-10)
            make.height.equalTo(196)
            make.left.right.equalTo(self.view).inset(16)
            make.bottom.equalToSuperview().inset(100)
        }
    }
}

extension AddProductViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        detailContentsTextView.hidePlaceholder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if detailContentsTextView.text.isEmpty {
            detailContentsTextView.showPlaceholder()
        }
    }
}
