//
//  LevelView.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/08.
//

import Foundation
import UIKit

enum LevelType {
    case bean
    case leaf
    case flower
    case tree
}

class LevelView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ level: LevelType) {
        self.init(frame: .zero)
        
        let levelImageView = UIImageView()
        self.addSubview(levelImageView)
        
        switch level {
        case .bean:
            levelImageView.image = UIImage(named: "bean_ic")
        case .leaf:
            levelImageView.image = UIImage(named: "leaf_ic")
        case .flower:
            levelImageView.image = UIImage(named: "flower_ic")
        case .tree:
            levelImageView.image = UIImage(named: "tree_ic")
        }
        
        levelImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        self.snp.makeConstraints { make in
            make.width.height.equalTo(11)
        }
    }
    
}

