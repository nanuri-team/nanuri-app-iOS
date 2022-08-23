//
//  StepFour.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/08/23.
//

import UIKit

extension AddProductViewController {
    func setUpStepFourView() {
        
        stepFourView.backgroundColor = .nanuriBlue
        stepFourView.alpha = 0.0
        self.view.addSubview(stepFourView)
        stepFourView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        deliveryTableView.separatorInset = .zero
        deliveryTableView.separatorColor = .nanuriGray2
//        deliveryTableView.delegate = self
//        deliveryTableView.dataSource = self
        stepFourView.addSubview(deliveryTableView)
        deliveryTableView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
    }
}

