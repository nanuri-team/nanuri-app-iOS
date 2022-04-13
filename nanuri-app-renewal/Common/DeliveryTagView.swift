//
//  DeliveryTagView.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import Foundation
import UIKit

enum DeliveryType {
    case delivery
    case direct
}

class DeliveryTagView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(type: DeliveryType) {
        self.init(frame: .zero)
        
        let typeLabel = UILabel()
        self.addSubview(typeLabel)
        
        switch type {
        case .delivery:
            typeLabel.attributedText = .attributeFont(font: .NSRExtrabold, size: 11, text: DeliveryTypeName.delivery, lineHeight: 11)
            typeLabel.textColor = .nanuriBrown
            self.backgroundColor = .nanuriBrown.withAlphaComponent(0.2)
        case .direct:
            typeLabel.attributedText = .attributeFont(font: .NSRExtrabold, size: 11, text: DeliveryTypeName.direct, lineHeight: 11)
            typeLabel.textColor = .nanuriBlue
            self.backgroundColor = .nanuriBlue.withAlphaComponent(0.2)
        }
        
        // view
       self.layer.cornerRadius = 4
       self.snp.makeConstraints { make in
//           make.height.equalTo(43)
           make.top.equalTo(typeLabel.snp.top).inset(-4)
           make.bottom.equalTo(typeLabel.snp.bottom).inset(-4)
           make.trailing.equalTo(typeLabel.snp.trailing).inset(-6)
           make.leading.equalTo(typeLabel.snp.leading).inset(-6)
       }
       
       // badge
        typeLabel.snp.makeConstraints { make in
           make.center.equalToSuperview()
       }
    }
    
}
