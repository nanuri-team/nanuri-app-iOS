//
//  AddProductStepTwoViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/23.
//

import UIKit

class AddProductStepTwoViewController: UIViewController {

    let stepView = UIView()
    
    let productLocationTextField = UITextField()
    let minimumRecruitmentTextField = UITextField()
    let maximumRecruitmentTextField = UITextField()
    let detailContentsTextView = TextView()
    let recruitmentPeriodTextField = UITextField()

    
    var bottomViewHeight = 64
    var edgeHeight = 34
    var postProductInfo: [String: Any] = [:]
    var selectDate = Date()
    var postImageData: UIImage!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "상품 등록하기"
        
        print(postProductInfo)
        
        let backButton = UIBarButtonItem(image: UIImage(named: "back_ic"), style: .plain, target: self, action: #selector(selectBackButton))
        self.navigationItem.setLeftBarButton(backButton, animated: true)
        
        self.view.backgroundColor = .white
        setUpStepView()
        setUpView()
        setUpBottomView()
        
    }
    
    @objc func selectBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectNextButton() {
        
        guard validation() else {
            print("return")
            return
        }
        
        let addProductStepThreeViewController = AddProductStepThreeViewController()
        addProductStepThreeViewController.postProductInfo = postProductInfo
        addProductStepThreeViewController.postImageData = postImageData
        addProductStepThreeViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(addProductStepThreeViewController, animated: true)
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
    @objc func selectDatePickerView(_ sender: UIDatePicker) {
        recruitmentPeriodTextField.text = DateFormatter().changeDateFormat(sender.date, format: .dotAndDay)
        selectDate = sender.date
    }
    
    @objc func selectDayDoneButton() {
//        recruitmentPeriodTextField.text = DateFormatter().changeDateFormat(datePickerView.date, format: .attachName)
        recruitmentPeriodTextField.resignFirstResponder()
    }
    
    func validation() -> Bool {
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
        
        let stepTwo = StepItemView(icon: UIImage(named: "step_two_w_ic")!, stepTitle: "공구 내용 작성", isActive: true)
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
        
        let productLocation = UILabel()
        productLocation.attributedText = .attributeFont(font: .PSemibold, size: 16, text: "판매자 지역", lineHeight: 19)
        contentsScrollView.addSubview(productLocation)
        productLocation.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.left.right.equalToSuperview().inset(16)
        }
        
        productLocationTextField.attributedText = .attributeFont(font: .PRegular, size: 15, text: "서울시 강남구 논현동", lineHeight: 18)
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
