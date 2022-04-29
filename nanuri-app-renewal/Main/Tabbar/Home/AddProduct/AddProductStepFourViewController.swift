//
//  AddProductStepFourViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/23.
//

import UIKit

class AddProductStepFourViewController: UIViewController {

    let stepView = UIView()
    
    var bottomViewHeight = 64
    var edgeHeight = 34
    let deliveryName = ["배송", "직거래"]
    let deliveryDescription = ["공동구매 참여자들에게 택배로 배송할 예정이에요.", "공동구매 참여자와 직접 만나서 물건을 전달할 예정이에요."]
    var selectIndex = 0
    var radioButtonArray: [UIButton] = []
    var postProductInfo: [String: Any] = [:]
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
    
    @objc func selectAddProductButton() {
        guard validation() else {
            print("return")
            return
        }
        
        postPosts()
    }
    
    func validation() -> Bool {
        postProductInfo["quantity"] = 1
        postProductInfo["trade_type"] = selectIndex.toTradeTypeName()
        return true
    }
    
    func postPosts() {
        Networking.sharedObject.postPosts(image: postImageData, parameter: postProductInfo) { response in
            print(response)
        }
        
        navigationController?.popToRootViewController(animated: true)
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
        
        let stepThree = StepItemView(icon: UIImage(named: "step_three_w_ic")!, stepTitle: "카테고리 선택", isActive: true)
        stepGroupView.addSubview(stepThree)
        stepThree.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(stepTwo.snp.right).inset(-27)
        }
        
        let stepFour = StepItemView(icon: UIImage(named: "step_four_w_ic")!, stepTitle: "나눔 방법 선택", isActive: true)
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
        
        let deliveryTableView = UITableView()
        deliveryTableView.separatorInset = .zero
        deliveryTableView.separatorColor = .nanuriGray2
        deliveryTableView.delegate = self
        deliveryTableView.dataSource = self
        self.view.addSubview(deliveryTableView)
        deliveryTableView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
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
        
        let addProductButton = MainButton(style: .main)
        addProductButton.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: "상품 등록", lineHeight: 18), for: .normal)
        bottomView.addSubview(addProductButton)
        addProductButton.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(8)
        }
        addProductButton.addTarget(self, action: #selector(selectAddProductButton), for: .touchUpInside)
    }

}

extension AddProductStepFourViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deliveryName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "\(indexPath.row)"
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            return reuseCell
        } else {
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
                selectIndex = indexPath.row
            }
            
            radioButtonArray.append(radioButton)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0..<radioButtonArray.count {
            radioButtonArray[i].setImage(UIImage(named: "radio_ic"), for: .normal)
        }
        radioButtonArray[indexPath.row].setImage(UIImage(named: "radio_select_ic"), for: .normal)
        selectIndex = indexPath.row
    }
    
}
