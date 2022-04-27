//
//  CheckboxButton.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/15.
//

import Foundation
import UIKit

class CheckboxButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isSelected = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.setImage(UIImage(named: "checkbox_on_ic"), for: .normal)
            } else {
                self.setImage(UIImage(named: "checkbox_off_ic"), for: .normal)
            }
        }
    }
}
