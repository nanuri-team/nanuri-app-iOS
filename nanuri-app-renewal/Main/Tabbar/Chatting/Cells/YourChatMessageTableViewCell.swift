//
//  YourChatMessageTableViewCell.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/23.
//

import UIKit

class YourChatMessageViewCell: UITableViewCell {
    
    static let cellId = "yourChatMessage"
    
    let userName = UILabel()
    let chatLabel = UILabel()
    
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
      
        
//        userName.attributedText = .attributeFont(font: .PBold, size: 13, text: "프로 공구러", lineHeight: 15)
//        userName.textColor = .nanuriGray7
//        cellView.addSubview(userName)
    
        
        let yourMessageView = UIView()
        yourMessageView.layer.borderWidth = 1
        yourMessageView.layer.borderColor = UIColor.nanuriGray2.cgColor
        yourMessageView.backgroundColor = .white
        yourMessageView.layer.cornerRadius = 6
        yourMessageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        yourMessageView.layer.masksToBounds = true
        cellView.addSubview(yourMessageView)
        
        chatLabel.attributedText = .attributeFont(font: .PRegular, size: 13, text: "", lineHeight: 19)
        chatLabel.numberOfLines = 0
        chatLabel.textColor = .nanuriBlack1
        chatLabel.lineBreakMode = .byWordWrapping
        yourMessageView.addSubview(chatLabel)
        chatLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(-10)
            make.left.right.equalToSuperview().inset(14)
        }
        
        yourMessageView.snp.makeConstraints { make in
            make.top.equalTo(chatLabel.snp.top)
            make.right.equalTo(chatLabel.snp.right).inset(-14)
            make.left.equalToSuperview()
        }
        
//        userName.snp.makeConstraints { make in
//            make.bottom.equalTo(yourMessageView.snp.top).inset(-10)
//            make.left.equalToSuperview()
//        }
        
        cellView.snp.makeConstraints { make in
            make.top.equalTo(yourMessageView.snp.top)
            make.bottom.equalTo(yourMessageView.snp.bottom)
            make.left.right.equalToSuperview().inset(16)
        }
    }

}
