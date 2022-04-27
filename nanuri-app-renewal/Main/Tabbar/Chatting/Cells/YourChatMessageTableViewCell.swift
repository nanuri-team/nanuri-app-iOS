//
//  YourChatMessageTableViewCell.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/23.
//

import UIKit

class YourChatMessageViewCell: UITableViewCell {
    
    static let cellId = "yourChatMessage"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpView() {
        
        let cellView = UIView()
        cellView.backgroundColor = .white
        cellView.clipsToBounds = true
        contentView.addSubview(cellView)
        cellView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }
        
        let userName = UILabel()
        userName.attributedText = .attributeFont(font: .PBold, size: 13, text: "프로 공구러", lineHeight: 15)
        userName.textColor = .nanuriGray7
        cellView.addSubview(userName)
        userName.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    
        
        let yourMessageView = UIView()
        yourMessageView.layer.borderWidth = 1
        yourMessageView.layer.borderColor = UIColor.nanuriGray2.cgColor
        yourMessageView.backgroundColor = .white
        yourMessageView.layer.cornerRadius = 6
        yourMessageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        yourMessageView.layer.masksToBounds = true
        cellView.addSubview(yourMessageView)
        yourMessageView.snp.makeConstraints { make in
            make.top.equalTo(userName.snp.bottom).inset(-6)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.left.equalToSuperview()
        }
    }

}
