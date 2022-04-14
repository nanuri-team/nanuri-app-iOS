//
//  TextView.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/15.
//

import Foundation
import UIKit

class TextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: .zero, textContainer: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let placeholderLabel = UILabel()
    
    func placeholder(text: String) {
        placeholderLabel.attributedText = .attributeFont(font: .PRegular, size: 13, text: text, lineHeight: 19)
        placeholderLabel.textColor = .nanuriGray3
        placeholderLabel.numberOfLines = 3
        self.addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.left.equalToSuperview().inset(17)
        }
    }
    
    func hidePlaceholder() {
        placeholderLabel.isHidden = true
    }
    
    func showPlaceholder() {
        placeholderLabel.isHidden = false
    }
}
