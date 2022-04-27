//
//  ChattingListTableViewCell.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/23.
//

import UIKit

class ChattingListTableViewCell: UITableViewCell {
    
    static let cellId = "chattingListCell"
    
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
            make.height.equalTo(84)
        }
        
        let productImageView = UIImageView()
        productImageView.backgroundColor = .nanuriGray2
        productImageView.contentMode = .scaleToFill
        productImageView.layer.cornerRadius = 12
        cellView.addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.width.height.equalTo(64)
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        let productName = UILabel()
        productName.attributedText = .attributeFont(font: .PBold, size: 13, text: "레트로 노트북", lineHeight: 15)
        cellView.addSubview(productName)
        productName.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalTo(productImageView.snp.right).inset(-11)
            make.right.equalToSuperview().inset(11)
        }
        
        let chatLabel = UILabel()
        chatLabel.attributedText = .attributeFont(font: .PRegular, size: 12, text: "이거 언제 배송해주시나요?", lineHeight: 18)
        chatLabel.textColor = .nanuriGray6
        cellView.addSubview(chatLabel)
        chatLabel.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom).inset(-4)
            make.left.equalTo(productImageView.snp.right).inset(-11)
            make.right.equalToSuperview().inset(19)
        }
        
        let deliveryTag = DeliveryTagView(type: .delivery)
        cellView.addSubview(deliveryTag)
        deliveryTag.snp.makeConstraints { make in
            make.left.equalTo(productImageView.snp.right).inset(-11)
            make.bottom.equalToSuperview().inset(10)
        }
        
        let chatPeopleLabel = UILabel()
        chatPeopleLabel.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "2", lineHeight: 14)
        chatPeopleLabel.textColor = .nanuriGray4
        cellView.addSubview(chatPeopleLabel)
        chatPeopleLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(11)
        }
        
        let participantImageView = UIImageView()
        participantImageView.image = UIImage(named: "people_ic")
        cellView.addSubview(participantImageView)
        participantImageView.snp.makeConstraints { make in
            make.right.equalTo(chatPeopleLabel.snp.left).inset(-6)
            make.bottom.equalToSuperview().inset(10)
            make.width.height.equalTo(16)
        }
        
        let locationImageView = UIImageView()
        locationImageView.image = UIImage(named: "place_ic")
        cellView.addSubview(locationImageView)
        locationImageView.snp.makeConstraints { make in
            make.top.equalTo(chatLabel.snp.bottom).inset(-10)
            make.height.width.equalTo(16)
            make.bottom.equalToSuperview().inset(10)
        }
        
        let productLocationLabel = UILabel()
        productLocationLabel.attributedText = .attributeFont(font: .NSRBold, size: 12, text: "서울시 강남구", lineHeight: 14)
        productLocationLabel.textColor = .nanuriGray4
        cellView.addSubview(productLocationLabel)
        productLocationLabel.snp.makeConstraints { make in
            make.left.equalTo(locationImageView.snp.right).inset(-2)
            make.right.equalTo(participantImageView.snp.left).inset(-10)
            make.bottom.equalToSuperview().inset(11)
        }
        
    }

}
