//
//  AddProductViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/08/18.
//

import UIKit

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
    
    /// StepTwo Property
    let productLocationTextField = UITextField()
    let minimumRecruitmentTextField = UITextField()
    let maximumRecruitmentTextField = UITextField()
    let detailContentsTextView = TextView()
    let recruitmentPeriodTextField = UITextField()
    
    /// StepThree Property
    let categoryImageName = ["category_life_ic", "category_food_ic", "category_kitchen_ic", "category_bath_ic", "category_note_ic", "category_etc_ic"]
    let categoryName = ["생활용품", "음식", "주방", "욕실", "문구", "기타"]
    var selectIndex = 0
    var radioButtonArray: [UIButton] = []
    var postProductInfo: [String: Any] = [:]
    var postImageData: UIImage!
    let categoryTableView = UITableView()
    
    /// StepFour Property
    let deliveryTableView = UITableView()
    let deliveryName = ["배송", "직거래"]
    let deliveryDescription = ["공동구매 참여자들에게 택배로 배송할 예정이에요.", "공동구매 참여자와 직접 만나서 물건을 전달할 예정이에요."]
//    var selectIndex = 0
//    var radioButtonArray: [UIButton] = []
//    var postProductInfo: [String: Any] = [:]
//    var postImageData: UIImage!

    
    var bottomViewHeight = 64
    var currentStepState: StepState = .stepOne
    var edgeHeight = 34

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "상품 등록하기"
        setNavigationHeaderIcon()
        setUpView()
    }
    
    @objc func selectCloseButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectNextButton() {
        switch currentStepState {
        case .stepOne:
            currentStepState = .stepTwo
            stepOne.setState(isActive: true, icon: UIImage(named: "step_one_w_ic")!)
            stepTwoView.alpha = 1.0
        case .stepTwo:
            currentStepState = .stepThree
            stepTwo.setState(isActive: true, icon: UIImage(named: "step_two_w_ic")!)
            stepThreeView.alpha = 1.0
        case .stepThree:
            currentStepState = .stepFour
            stepThree.setState(isActive: true, icon: UIImage(named: "step_three_w_ic")!)
            stepFourView.alpha = 1.0
        case .stepFour:
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
    
    func changeStepState() {
        
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
        
        let nextButton = MainButton(style: .main)
        nextButton.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: "다음", lineHeight: 18), for: .normal)
        bottomView.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(8)
        }
        nextButton.addTarget(self, action: #selector(selectNextButton), for: .touchUpInside)
    }
}
