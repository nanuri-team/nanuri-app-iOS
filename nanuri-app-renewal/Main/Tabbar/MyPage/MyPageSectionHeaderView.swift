//
//  MyPageSectionHeaderView.swift
//  nanuri-app-renewal
//
//  Created by heyji on 2022/11/09.
//

import UIKit

class MyPageSectionHeaderView: UIView {
    var productView: UIView = {
        let view = UIView()
        view.backgroundColor = .nanuriGray2
        return view
    }()
    var registeredProductsListButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setAttributedTitle(.attributeFont(font: .PBold, size: 13, text: "내가 등록한 상품", lineHeight: 15), for: .normal)
        button.setTitleColor(.nanuriGreen, for: .normal)
        return button
    }()
    var clickedView: UIView = {
        let view = UIView()
        view.backgroundColor = .nanuriGreen
        return view
    }()
    var participatedProductsListButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setAttributedTitle(.attributeFont(font: .PMedium, size: 13, text: "내가 참여한 상품", lineHeight: 15), for: .normal)
        button.setTitleColor(.nanuriGray5, for: .normal)
        return button
    }()
    var clickedView2: UIView = {
        let view = UIView()
        view.backgroundColor = .nanuriGray2
        return view
    }()
    var numberOfListLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .attributeFont(font: .PMedium, size: 13, text: label.text ?? "전체 0개", lineHeight: 15)
        label.text = "전체 0개"
        return label
    }()
    var moreButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(.attributeFont(font: .PRegular, size: 13, text: "진행 중인 상품", lineHeight: 13), for: .normal)
        button.setImage(UIImage(named: "down_arrow_ic"), for: .normal)
        button.setTitleColor(.nanuriGray4, for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        addSubview(productView)
        productView.addSubview(registeredProductsListButton)
        productView.addSubview(clickedView)
        productView.addSubview(participatedProductsListButton)
        productView.addSubview(clickedView2)
        addSubview(numberOfListLabel)
        addSubview(moreButton)
        
        productView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(45)
        }
        
        registeredProductsListButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalTo(productView.snp.width).dividedBy(2)
            $0.height.equalTo(42)
        }
        
        clickedView.snp.makeConstraints {
            $0.top.equalTo(registeredProductsListButton.snp.bottom)
            $0.left.equalToSuperview()
            $0.width.equalTo(registeredProductsListButton.snp.width)
            $0.height.equalTo(3)
        }
        
        participatedProductsListButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.right.equalToSuperview()
            $0.width.equalTo(productView.snp.width).dividedBy(2)
            $0.height.equalTo(42)
        }
        
        clickedView2.snp.makeConstraints {
            $0.top.equalTo(participatedProductsListButton.snp.bottom)
            $0.right.equalToSuperview()
            $0.width.equalTo(participatedProductsListButton.snp.width)
            $0.height.equalTo(3)
        }
        
        numberOfListLabel.snp.makeConstraints {
            $0.top.equalTo(productView.snp.bottom).inset(-25)
            $0.left.equalTo(16)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalTo(productView.snp.bottom).inset(-25)
            $0.right.equalTo(-16)
        }
    }
}
