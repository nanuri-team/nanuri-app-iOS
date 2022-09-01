//
//  File.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/08/24.
//

import UIKit

class OptionView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        let editButton = UIButton()
        editButton.imageWithText(image: UIImage(named: "pen"), text: "수정하기")
        self.addSubview(editButton)
        editButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        let deleteButton = UIButton()
        deleteButton.imageWithText(image: UIImage(named: "delete"), text: "삭제하기")
        self.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.top.equalTo(editButton.snp.bottom)
            make.height.equalTo(50)
        }
    }
}
