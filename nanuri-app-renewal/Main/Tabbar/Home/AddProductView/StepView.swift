//
//  StepView.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/11/26.
//

import UIKit

class StepView: UIView {
    init(icon: UIImage?, title: String) {
        super.init(frame: .zero)
        
        let circleView = UIView()
        circleView.frame = .init(x: 0, y: 0, width: 48, height: 48)
        circleView.backgroundColor = .nanuriGray1
        circleView.layer.cornerRadius = circleView.frame.height / 2
        self.addSubview(circleView)
        circleView.snp.makeConstraints { make in
            make.width.height.equalTo(48)
            make.top.left.right.equalToSuperview()
        }
        
        let stepImageView = UIImageView()
        stepImageView.image = icon
        circleView.addSubview(stepImageView)
        stepImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        let stepLabel = UILabel()
        stepLabel.attributedText = .attributeFont(font: .PMedium, size: 12, text: title, lineHeight: 14)
        stepLabel.textColor = .nanuriGray3
        stepLabel.textAlignment = .center
        stepLabel.numberOfLines = 2
        self.addSubview(stepLabel)
        stepLabel.snp.makeConstraints { make in
            make.top.equalTo(circleView.snp.bottom).inset(-8)
            make.centerX.equalToSuperview()
        }
        
        self.snp.makeConstraints { make in
            make.top.equalTo(circleView.snp.top)
            make.bottom.equalTo(stepLabel.snp.bottom)
            make.left.equalTo(circleView.snp.left)
            make.right.equalTo(circleView.snp.right)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
