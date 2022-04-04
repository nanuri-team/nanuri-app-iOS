//
//  DDayTagView.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import Foundation
import UIKit

class DDayTagView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(dDay: String) {
        self.init(frame: .zero)
        
        let typeLabel = UILabel()
        typeLabel.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        self.addSubview(typeLabel)
        
        typeLabel.attributedText = NSAttributedString(string: "D-\(dDay)")
        typeLabel.textColor = .nanuriDarkGreen
        self.backgroundColor = .nanuriLightGreen.withAlphaComponent(0.2)
        
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

