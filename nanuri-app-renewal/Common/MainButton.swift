//
//  MainButton.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/07.
//

import Foundation
import UIKit

enum MainButtonStyle {
    case main
    case disable
}

class MainButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(style: MainButtonStyle) {
        self.init(frame: .zero)
        
        self.layer.cornerRadius = 4
        self.setTitleColor(.white, for: .normal)
        
        switch style {
        case .main:
            self.backgroundColor = .nanuriGreen
        case .disable:
            self.titleLabel?.textColor = .nanuriGray5
            self.backgroundColor = .nanuriGray2
        }
    }
}
