//
//  StepItem.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/21.
//

import Foundation
import UIKit

class StepItemView: UIView {
    
    var isActive: Bool = false
    
    let iconView = UIView()
    let stepTitleLabel = UILabel()
    let iconImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setState(isActive: Bool, icon: UIImage) {
        self.isActive = isActive
        iconImageView.image = icon
        
        if isActive {
            iconView.backgroundColor = .nanuriGreen
            stepTitleLabel.textColor = .nanuriGreen
        }
    }
    
    convenience init(icon: UIImage, stepTitle: String, isActive: Bool = false) {
        self.init(frame: .zero)
        
        self.isActive = isActive
        
        iconView.backgroundColor = .nanuriGray1
        iconView.layer.cornerRadius = 48 / 2
        self.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.height.width.equalTo(48)
            make.top.left.right.equalToSuperview()
        }
        
        iconImageView.tintColor = .red
        iconView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        stepTitleLabel.attributedText = .attributeFont(font: .PRegular, size: 12, text: stepTitle, lineHeight: 14)
        stepTitleLabel.textColor = .nanuriGray3
        stepTitleLabel.numberOfLines = 2
        stepTitleLabel.textAlignment = .center
        self.addSubview(stepTitleLabel)
        stepTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).inset(-8)
            make.width.equalTo(48)
            make.left.right.bottom.equalToSuperview()
        }
        
        self.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.top)
            make.bottom.equalTo(stepTitleLabel.snp.bottom)
        }
        
        setState(isActive: isActive, icon: icon)
    }
}
