//
//  ChattingListTableViewCell.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/23.
//

import UIKit

class ChattingListTableViewCell: UITableViewCell {
    
    static let cellId = "chattingListCell"
    
    let productName = UILabel()
    let deliveryTag = DeliveryTagView()
    let chatPeopleLabel = UILabel()
    let productLocationLabel = UILabel()
    let productImageView = UIImageView()


    
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
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(96)
        }
        
        productImageView.backgroundColor = .nanuriGray2
        productImageView.contentMode = .scaleToFill
        productImageView.layer.cornerRadius = 12
        cellView.addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        deliveryTag.setDeliveryType(type: DeliveryType.parcel)
        cellView.addSubview(deliveryTag)
        deliveryTag.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.equalTo(productImageView.snp.right).inset(-11)
        }
        
        productName.attributedText = .attributeFont(font: .PBold, size: 15, text: "레트로 노트북", lineHeight: 15)
        cellView.addSubview(productName)
        productName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.equalTo(deliveryTag.snp.right).inset(-8)
        }
        
        let chatLabel = UILabel()
        chatLabel.attributedText = .attributeFont(font: .PRegular, size: 13, text: "이거 언제 배송해주시나요?", lineHeight: 18)
        chatLabel.textColor = .nanuriGray7
        cellView.addSubview(chatLabel)
        chatLabel.snp.makeConstraints { make in
            make.top.equalTo(deliveryTag.snp.bottom).inset(-4)
            make.left.equalTo(productImageView.snp.right).inset(-11)
            make.right.equalToSuperview().inset(19)
        }
        
        let participantImageView = UIImageView()
        participantImageView.image = UIImage(named: "people_ic")
        cellView.addSubview(participantImageView)
        participantImageView.snp.makeConstraints { make in
            make.left.equalTo(productImageView.snp.right).inset(-13)
            make.bottom.equalToSuperview().inset(16)
            make.width.height.equalTo(16)
        }
        
        chatPeopleLabel.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "2", lineHeight: 14)
        chatPeopleLabel.textColor = .nanuriGray4
        cellView.addSubview(chatPeopleLabel)
        chatPeopleLabel.snp.makeConstraints { make in
            make.left.equalTo(participantImageView.snp.right).inset(-2)
            make.bottom.equalToSuperview().inset(17)
        }
        
        let locationImageView = UIImageView()
        locationImageView.image = UIImage(named: "place_ic")
        cellView.addSubview(locationImageView)
        locationImageView.snp.makeConstraints { make in
            make.left.equalTo(chatPeopleLabel.snp.right).inset(-8)
            make.bottom.equalToSuperview().inset(16)
            make.height.width.equalTo(16)
        }
        
        productLocationLabel.attributedText = .attributeFont(font: .NSRBold, size: 12, text: "서울시 강남구", lineHeight: 14)
        productLocationLabel.textColor = .nanuriGray4
        cellView.addSubview(productLocationLabel)
        productLocationLabel.snp.makeConstraints { make in
            make.left.equalTo(locationImageView.snp.right).inset(-2)
            make.bottom.equalToSuperview().inset(17)
        }
        
        let lastChatTimeLabel = UILabel()
        lastChatTimeLabel.attributedText = .attributeFont(font: .PMedium, size: 12, text: "13:48", lineHeight: 14)
        lastChatTimeLabel.textColor = .nanuriGray3
        cellView.addSubview(lastChatTimeLabel)
        lastChatTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.right.equalToSuperview()
        }
    }

}
