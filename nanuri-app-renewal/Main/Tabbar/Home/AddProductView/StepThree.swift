//
//  StepThree.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/08/23.
//

import UIKit

extension AddProductViewController {
    func setUpStepThreeView() {
        
        stepThreeView.backgroundColor = .white
        stepThreeView.alpha = 0.0
        self.view.addSubview(stepThreeView)
        stepThreeView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        categoryTableView.separatorInset = .zero
        categoryTableView.separatorColor = .nanuriGray2
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        stepThreeView.addSubview(categoryTableView)
        categoryTableView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
    }
}


