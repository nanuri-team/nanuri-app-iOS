//
//  MyChatMessageViewCell.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/23.
//

import UIKit

class MyChatMessageViewCell: UITableViewCell {
    
    static let cellId = "myChatMessage"
    
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
        
        
        let myMessageView = UIView()
        myMessageView.backgroundColor = .nanuriGreen
        myMessageView.layer.cornerRadius = 6
        myMessageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        myMessageView.layer.masksToBounds = true
        cellView.addSubview(myMessageView)
        
        
        chatLabel.attributedText = .attributeFont(font: .PRegular, size: 13, text: "", lineHeight: 19)
        chatLabel.numberOfLines = 0
        chatLabel.textColor = .white
        chatLabel.lineBreakMode = .byWordWrapping
        myMessageView.addSubview(chatLabel)
        chatLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(-10)
            make.left.right.equalToSuperview().inset(14)
        }
        
        
        myMessageView.snp.makeConstraints { make in
            make.top.equalTo(chatLabel.snp.top)
            make.left.equalTo(chatLabel.snp.left)
            make.right.equalToSuperview()
        }
        
        cellView.snp.makeConstraints { make in
            make.top.equalTo(myMessageView.snp.top)
            make.bottom.equalTo(myMessageView.snp.bottom)
            make.left.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }

}
