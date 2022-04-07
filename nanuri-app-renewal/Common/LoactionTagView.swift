//
//  LoactionTagView.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/08.
//

import Foundation
import UIKit

class LocationTagView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(location: String) {
        self.init(frame: .zero)
        
        self.backgroundColor = .nanuriGray2
        self.layer.cornerRadius = 4
        
        let locationImageView = UIImageView()
        locationImageView.image = UIImage(named: "place_fill_ic")
        self.addSubview(locationImageView)
        locationImageView.snp.makeConstraints { make in
            make.height.width.equalTo(14)
            make.centerY.equalToSuperview()
        }
        
        let productLocationLabel = UILabel()
        productLocationLabel.attributedText = NSAttributedString(string: location)
        productLocationLabel.font = UIFont.systemFont(ofSize: 12)
        productLocationLabel.textColor = .nanuriGray4
        self.addSubview(productLocationLabel)
        productLocationLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(locationImageView.snp.right).inset(-2)
        }
        
        self.snp.makeConstraints { make in
            make.top.equalTo(locationImageView.snp.top).inset(-5)
            make.bottom.equalTo(productLocationLabel.snp.bottom).inset(-5)
            make.left.equalTo(locationImageView.snp.left).inset(-4)
            make.right.equalTo(productLocationLabel.snp.right).inset(-7)
        }
    }
    
}
