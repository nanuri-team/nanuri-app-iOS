//
//  TestAddProductViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/11/26.
//

import UIKit

class TestAddProductViewController: UIViewController {
    
    let addProductScrollView = UIScrollView()

    var viewHeight: CGFloat = UIScreen.main.bounds.height - 172
    var bottomViewHeight = 64
    var stepCount: CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.title = "상품 등록하기"
        
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "close_ic"), style: .plain, target: self, action: #selector(selectLeftBarButtonItem))
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        
        setUpView()
    }
    
    @objc func selectLeftBarButtonItem() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectNextButton() {
        addProductScrollView.setContentOffset(.init(x: UIScreen.main.bounds.width * stepCount, y: 0), animated: true)
        if stepCount > 4 {
            stepCount = 0
        } else {
            stepCount += 1
        }
    }
    
    private func setUpView() {
        let addProductHeaderView = AddProductHeaderView()
        self.view.addSubview(addProductHeaderView)
        addProductHeaderView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        let divideView = UIView()
        divideView.backgroundColor = .nanuriGray1
        self.view.addSubview(divideView)
        divideView.snp.makeConstraints { make in
            make.top.equalTo(addProductHeaderView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(16)
        }
        
        addProductScrollView.isPagingEnabled = true
//        addProductScrollView.isScrollEnabled = false
        self.view.addSubview(addProductScrollView)
        addProductScrollView.snp.makeConstraints { make in
            make.top.equalTo(divideView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        let stepOneView = StepOneView()
        addProductScrollView.addSubview(stepOneView)
        stepOneView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalTo(self.view)
            make.height.equalTo(viewHeight)
        }
        
        let stepTwoView = StepTwoView()
        addProductScrollView.addSubview(stepTwoView)
        stepTwoView.snp.makeConstraints { make in
            make.left.equalTo(stepOneView.snp.right)
            make.top.bottom.right.equalToSuperview()
            make.width.equalTo(self.view)
            make.height.equalTo(viewHeight)
        }
        
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
        
        
        var nextButton = MainButton()
        nextButton = MainButton(style: .main)
        nextButton.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: "다음", lineHeight: 18), for: .normal)
        bottomView.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(8)
        }
        nextButton.addTarget(self, action: #selector(selectNextButton), for: .touchUpInside)
    }
}
