//
//  AddProductHeaderView.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/11/26.
//

import UIKit

class AddProductHeaderView: UIView {
    init() {
        super.init(frame: .zero)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        let stepView = UIView()
        self.addSubview(stepView)
        
        let stepOneView = StepView(icon: UIImage(named: "step_one_ic"), title: "상품 정보\n입력")
        stepView.addSubview(stepOneView)
        stepOneView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
        }
        
        let stepTwoLineView = UIView()
        stepTwoLineView.backgroundColor = .nanuriGray1
        stepView.addSubview(stepTwoLineView)
        stepTwoLineView.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(27)
            make.left.equalTo(stepOneView.snp.right)
            make.top.equalTo(stepOneView.snp.top).inset(25)
        }
        
        let stepTwoView = StepView(icon: UIImage(named: "step_two_ic"), title: "공구 내용\n작성")
        stepView.addSubview(stepTwoView)
        stepTwoView.snp.makeConstraints { make in
            make.left.equalTo(stepTwoLineView.snp.right)
            make.top.bottom.equalToSuperview()
        }
        
        let stepThreeLineView = UIView()
        stepThreeLineView.backgroundColor = .nanuriGray1
        stepView.addSubview(stepThreeLineView)
        stepThreeLineView.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(27)
            make.left.equalTo(stepTwoView.snp.right)
            make.top.equalTo(stepTwoView.snp.top).inset(25)
        }
        
        let stepThreeView = StepView(icon: UIImage(named: "step_three_ic"), title: "카테고리\n선택")
        stepView.addSubview(stepThreeView)
        stepThreeView.snp.makeConstraints { make in
            make.left.equalTo(stepThreeLineView.snp.right)
            make.top.bottom.equalToSuperview()
        }
        
        let stepFourLineView = UIView()
        stepFourLineView.backgroundColor = .nanuriGray1
        stepView.addSubview(stepFourLineView)
        stepFourLineView.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(27)
            make.left.equalTo(stepThreeView.snp.right)
            make.top.equalTo(stepThreeView.snp.top).inset(25)
        }
        
        let stepFourView = StepView(icon: UIImage(named: "step_four_ic"), title: "나눔 방법\n선택")
        stepView.addSubview(stepFourView)
        stepFourView.snp.makeConstraints { make in
            make.left.equalTo(stepFourLineView.snp.right)
            make.top.bottom.right.equalToSuperview()
        }
        
        stepView.snp.makeConstraints { make in
            make.top.equalTo(stepOneView.snp.top)
            make.bottom.equalTo(stepOneView.snp.bottom)
            make.left.equalTo(stepOneView.snp.left)
            make.right.equalTo(stepFourView.snp.right)
            make.center.equalToSuperview()
        }
        
        self.snp.makeConstraints { make in
            make.height.equalTo(156)
        }
    }
}
