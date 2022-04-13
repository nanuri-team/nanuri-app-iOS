//
//  FilterButton.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/14.
//

import Foundation
import UIKit

class FilterButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(filterType: Int) {
        self.init()
        
        var filterTitle = ""
        switch filterType {
        case 0:
            filterTitle = "ALL"
        case 1:
            filterTitle = "생활용품"
        case 2:
            filterTitle = "음식"
        case 3:
            filterTitle = "주방"
        case 4:
            filterTitle = "욕실"
        case 5:
            filterTitle = "문구"
        case 6:
            filterTitle = "기타"
        default:
            filterTitle = "ALL"
        }
        
        self.setAttributedTitle(.attributeFont(font: .NSRBold, size: 14, text: "#\(filterTitle)", lineHeight: 15.89), for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.nanuriGreen.cgColor
        self.layer.cornerRadius = 13.5
        self.contentEdgeInsets = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        self.setTitleColor(.nanuriGreen, for: .normal)
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderColor = UIColor.nanuriGreen.cgColor
                self.setTitleColor(.nanuriGreen, for: .normal)
            } else {
                self.layer.borderColor = UIColor.nanuriGray4.cgColor
                self.setTitleColor(.nanuriGray4, for: .normal)
            }
        }
    }
}
