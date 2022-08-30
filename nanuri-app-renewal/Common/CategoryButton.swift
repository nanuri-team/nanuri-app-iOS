//
//  CategoryButton.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/08/24.
//

import UIKit

class CategoryButton: UIButton {
    convenience init(image: UIImage?, title: String) {
        self.init()
        self.backgroundColor = .white
        self.layer.cornerRadius = 12
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.setImage(image, for: .normal)
        self.setAttributedTitle(.attributeFont(font: .PMedium, size: 10, text: title, lineHeight: 12), for: .normal)
        self.alignTextBelow()
        self.snp.makeConstraints { make in
            make.width.equalTo(106)
            make.height.equalTo(68)
        }
    }
}
