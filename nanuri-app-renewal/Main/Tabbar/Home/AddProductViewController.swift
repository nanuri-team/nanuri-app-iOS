//
//  AddProductViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/08/18.
//

import UIKit
import CoreLocation


class AddProductViewController: UIViewController {
    
    enum StepState {
        case stepOne
        case stepTwo
        case stepThree
        case stepFour
    }
    
    let headerStepView = UIView()
    var stepOne: StepItemView!
    var stepTwo: StepItemView!
    var stepThree: StepItemView!
    var stepFour: StepItemView!
    let bottomView = UIView()
    let separatorView = UIView()
    
    let stepOneView = UIView()
    let stepTwoView = UIView()
    let stepThreeView = UIView()
    let stepFourView = UIView()

    /// StepOne Property
    let productNameTextField = UITextField()
    let productLinkTextField = UITextField()
    let productPriceTextField = UITextField()
    let addImageView = UIImageView()
    var postProductInfo: [String: Any] = [:]

    
    /// StepTwo Property
    let productLocationTextField = UITextField()
    let minimumRecruitmentTextField = UITextField()
    let maximumRecruitmentTextField = UITextField()
    let detailContentsTextView = TextView()
    let recruitmentPeriodTextField = UITextField()
    var selectDate = Date()
    var postImageData: UIImage!

    
    /// StepThree Property
    let categoryImageName = ["category_life_ic", "category_food_ic", "category_kitchen_ic", "category_bath_ic", "category_note_ic", "category_etc_ic"]
    let categoryName = ["생활용품", "음식", "주방", "욕실", "문구", "기타"]
    var categorySelectIndex = 0
    var categoryRadioButtonArray: [UIButton] = []
    let categoryTableView = UITableView()
    
    /// StepFour Property
    let deliveryTableView = UITableView()
    let deliveryName = ["배송", "직거래"]
    let deliveryDescription = ["공동구매 참여자들에게 택배로 배송할 예정이에요.", "공동구매 참여자와 직접 만나서 물건을 전달할 예정이에요."]
    var deleverySelectIndex = 0
    var deleveryRadioButtonArray: [UIButton] = []
    
    var nextButton = MainButton()

    
    var bottomViewHeight = 64
    var currentStepState: StepState = .stepOne
    var edgeHeight = 34
    var userInfo: UserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "상품 등록하기"
        setNavigationHeaderIcon()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserInfo()
    }
    
    @objc func selectCloseButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectNextButton() {
        switch currentStepState {
        case .stepOne:
            guard stepOneValidation() else {
                return
            }
            currentStepState = .stepTwo
            stepOne.setState(isActive: true, icon: UIImage(named: "step_one_w_ic")!)
            stepTwoView.alpha = 1.0
        case .stepTwo:
            guard stepTwoValidation() else {
                return
            }
            currentStepState = .stepThree
            stepTwo.setState(isActive: true, icon: UIImage(named: "step_two_w_ic")!)
            stepThreeView.alpha = 1.0
        case .stepThree:
            guard stepThreeValidation() else {
                return
            }
            currentStepState = .stepFour
            stepThree.setState(isActive: true, icon: UIImage(named: "step_three_w_ic")!)
            stepFourView.alpha = 1.0
        case .stepFour:
            guard stepFourValidation() else {
                return
            }
            postPosts()
            print("ok")
        }
        
        self.view.bringSubviewToFront(bottomView)
        setNavigationHeaderIcon()
    }
    
    @objc func selectPrevButton() {
        switch currentStepState {
        case .stepOne:
            currentStepState = .stepOne
        case .stepTwo:
            currentStepState = .stepOne
            stepTwoView.alpha = 0.0
        case .stepThree:
            currentStepState = .stepTwo
            stepThreeView.alpha = 0.0
        case .stepFour:
            currentStepState = .stepThree
            stepFourView.alpha = 0.0
        }
        setNavigationHeaderIcon()
    }
    
    @objc func selectAddImageButton() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true)
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
    
    func getUserInfo() {
        NetworkService.shared.getUserInfoRequest { userInfo in
            self.userInfo = userInfo
            DispatchQueue.main.async {
                self.checkIsUserHaveLocation()
            }
        }
    }
    
    func checkIsUserHaveLocation() {
        guard let userInfo = userInfo else {
            print("location값이 비어있습니다.")
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        let location = splitLocation(location: userInfo.location)
        let myLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        geocoder.reverseGeocodeLocation(myLocation, preferredLocale: locale) { (place, error) in
            guard let placemark = place?.last,
                  let administrativeArea = placemark.administrativeArea,
                  let subLocality = placemark.subLocality
           else { return }
            
            self.productLocationTextField.attributedText = .attributeFont(font: .PMedium, size: 15, text: "\(administrativeArea) \(subLocality)", lineHeight: 18)
        }
    }
    
    func postPosts() {
        Networking.sharedObject.postPosts(image: postImageData, parameter: postProductInfo) { response in
            print(response)
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    func setNavigationHeaderIcon() {
        var imageName: String = "close_ic"
        var backEvent: Selector = #selector(selectPrevButton)
        switch currentStepState {
        case .stepOne:
            imageName = "close_ic"
            backEvent = #selector(selectCloseButton)
        case .stepTwo:
            imageName = "back_ic"
        case .stepThree:
            imageName = "back_ic"
        case .stepFour:
            imageName = "back_ic"
        }
        
        let closeButton = UIBarButtonItem(image: UIImage(named: imageName), style: .plain, target: self, action: backEvent)
        self.navigationItem.setLeftBarButton(closeButton, animated: true)
    }
    
    func setUpView() {
        self.view.backgroundColor = .white
        
        setHeaderStepView()
        setUpStepOneView()
        setUpStepTwoView()
        setUpStepThreeView()
        setUpStepFourView()
        setUpBottomView()
    }
    
    /// 스텝 헤더 뷰
    func setHeaderStepView() {
        headerStepView.backgroundColor = .white
        self.view.addSubview(headerStepView)
        
        let stepGroupView = UIView()
        headerStepView.addSubview(stepGroupView)
        
        stepOne = StepItemView(icon: UIImage(named: "step_one_ic")!, stepTitle: "상품 정보 입력")
        stepGroupView.addSubview(stepOne)
        stepOne.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        stepTwo = StepItemView(icon: UIImage(named: "step_two_ic")!, stepTitle: "공구 내용 작성")
        stepGroupView.addSubview(stepTwo)
        stepTwo.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(stepOne.snp.right).inset(-27)
        }
        
        stepThree = StepItemView(icon: UIImage(named: "step_three_ic")!, stepTitle: "카테고리 선택")
        stepGroupView.addSubview(stepThree)
        stepThree.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(stepTwo.snp.right).inset(-27)
        }
        
        stepFour = StepItemView(icon: UIImage(named: "step_four_ic")!, stepTitle: "나눔 방법 선택")
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
        
        headerStepView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.top.equalTo(stepGroupView.snp.top).inset(-40)
            make.bottom.equalTo(stepGroupView.snp.bottom).inset(-40)
            make.left.right.equalToSuperview()
        }
        
        self.view.addSubview(separatorView)
        separatorView.backgroundColor = .nanuriGray1
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(headerStepView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(16)
        }
    }
    
    
    /// 바텀 버튼 뷰
    func setUpBottomView() {
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
        
        nextButton = MainButton(style: .main)
        nextButton.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: "다음", lineHeight: 18), for: .normal)
        bottomView.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(8)
        }
        nextButton.addTarget(self, action: #selector(selectNextButton), for: .touchUpInside)
    }
}

extension AddProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

extension AddProductViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == deliveryTableView {
            return deliveryName.count
        } else if tableView == categoryTableView {
            return categoryImageName.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == deliveryTableView {
            let identifier = "\(indexPath.row)"
            
            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) { return reuseCell }
            
            let cell = UITableViewCell.init(style: .default, reuseIdentifier: identifier)
            cell.selectionStyle = .none
            
            let deliveryNameLabel = UILabel()
            deliveryNameLabel.attributedText = .attributeFont(font: .PBold, size: 16, text: deliveryName[indexPath.row], lineHeight: 19)
            cell.contentView.addSubview(deliveryNameLabel)
            deliveryNameLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(22)
                make.left.equalToSuperview().inset(24)
            }
            
            let deliveryDescriptionLabel = UILabel()
            deliveryDescriptionLabel.attributedText = .attributeFont(font: .PRegular, size: 12, text: deliveryDescription[indexPath.row], lineHeight: 14)
            deliveryDescriptionLabel.textColor = .nanuriGray4
            cell.contentView.addSubview(deliveryDescriptionLabel)
            deliveryDescriptionLabel.snp.makeConstraints { make in
                make.top.equalTo(deliveryNameLabel.snp.bottom).inset(-8)
                make.left.equalToSuperview().inset(24)
            }
            
            let radioButton = UIButton()
            radioButton.setImage(UIImage(named: "radio_ic"), for: .normal)
            radioButton.tag = indexPath.row
            cell.contentView.addSubview(radioButton)
            radioButton.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().inset(16)
            }
            
            if indexPath.row == 0 {
                radioButton.setImage(UIImage(named: "radio_select_ic"), for: .normal)
                deleverySelectIndex = indexPath.row
            }
            
            deleveryRadioButtonArray.append(radioButton)
            
            return cell
            
        } else if tableView == categoryTableView {
            let identifier = "\(indexPath.row)"
            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
                return reuseCell
            }
            let cell = UITableViewCell.init(style: .default, reuseIdentifier: identifier)
            cell.selectionStyle = .none
            
            let categoryImageView = UIImageView()
            categoryImageView.image = UIImage(named: categoryImageName[indexPath.row])
            cell.contentView.addSubview(categoryImageView)
            categoryImageView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
//                make.top.equalToSuperview().inset(16)
                make.width.height.equalTo(32)
                make.left.equalToSuperview().inset(16)
            }
            
            let categoryLabel = UILabel()
            categoryLabel.attributedText = .attributeFont(font: .PRegular, size: 15, text: categoryName[indexPath.row], lineHeight: 18)
            cell.contentView.addSubview(categoryLabel)
            categoryLabel.snp.makeConstraints { make in
                make.left.equalTo(categoryImageView.snp.right).inset(-16)
                make.centerY.equalToSuperview()
            }
            
            let radioButton = UIButton()
            radioButton.setImage(UIImage(named: "radio_ic"), for: .normal)
            radioButton.tag = indexPath.row
            cell.contentView.addSubview(radioButton)
            radioButton.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().inset(16)
            }
            
            if indexPath.row == 0 {
                radioButton.setImage(UIImage(named: "radio_select_ic"), for: .normal)
                categorySelectIndex = indexPath.row
            }
            
            categoryRadioButtonArray.append(radioButton)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == deliveryTableView {
            return 84
        } else if tableView == categoryTableView {
            return 64
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == categoryTableView {
            for i in 0..<categoryRadioButtonArray.count {
                categoryRadioButtonArray[i].setImage(UIImage(named: "radio_ic"), for: .normal)
            }
            categoryRadioButtonArray[indexPath.row].setImage(UIImage(named: "radio_select_ic"), for: .normal)
            categorySelectIndex = indexPath.row
        } else if tableView == deliveryTableView {
            for i in 0..<deleveryRadioButtonArray.count {
                deleveryRadioButtonArray[i].setImage(UIImage(named: "radio_ic"), for: .normal)
            }
            deleveryRadioButtonArray[indexPath.row].setImage(UIImage(named: "radio_select_ic"), for: .normal)
            deleverySelectIndex = indexPath.row
        }
    }
}
