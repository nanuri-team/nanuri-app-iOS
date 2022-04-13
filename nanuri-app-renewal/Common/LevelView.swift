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
    
    convenience init(_ level: LevelType, isLevelName: Bool = false) {
        self.init(frame: .zero)
        
        let levelNameLabel = UILabel()
        levelNameLabel.font = UIFont.systemFont(ofSize: 11)
        self.addSubview(levelNameLabel)
        
        let levelImageView = UIImageView()
        self.addSubview(levelImageView)
        
        switch level {
        case .bean:
            levelNameLabel.attributedText = NSAttributedString(string: "콩")
            levelNameLabel.textColor = .nanuriYellow
            levelImageView.image = UIImage(named: "bean_ic")
        case .leaf:
            levelNameLabel.attributedText = NSAttributedString(string: "새싹")
            levelNameLabel.textColor = .nanuriLevelGreen
            levelImageView.image = UIImage(named: "leaf_ic")
        case .flower:
            levelNameLabel.attributedText = NSAttributedString(string: "꽃")
            levelNameLabel.textColor = .nanuriLevelOrange
            levelImageView.image = UIImage(named: "flower_ic")
        case .tree:
            levelNameLabel.attributedText = NSAttributedString(string: "나무")
            levelNameLabel.textColor = .nanuriLevelMint
            levelImageView.image = UIImage(named: "tree_ic")
        }
        
        if isLevelName {
            levelNameLabel.isHidden = false
        } else {
            levelNameLabel.isHidden = true
        }
        
        levelNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        levelImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(levelNameLabel.snp.right).inset(-2)
            make.width.height.equalTo(11)
            make.right.equalToSuperview()
        }
        
        self.snp.makeConstraints { make in
            make.left.equalTo(levelNameLabel.snp.left)
            make.right.equalTo(levelImageView.snp.right)
        }
    }
}

