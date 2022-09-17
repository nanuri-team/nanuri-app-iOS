//
//  MainProductTableViewCell.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit

class MainProductTableViewCell: UITableViewCell {
    
    let productImage = UIImageView()
    let productName = UILabel()
    let productLocationLabel = UILabel()
    let productPrice = UILabel()
    let deliveryTagView = DeliveryTagView()
    let totalRecruit = UILabel()
    let productParticipant = UILabel()
    let dDayTagView = DDayTagView()
    
    static let cellId = "mainProductCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpView() {
        
        let cellView = UIView()
        cellView.layer.cornerRadius = 12
        cellView.backgroundColor = .white
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = UIColor.nanuriGray2.cgColor
        cellView.clipsToBounds = true
        contentView.addSubview(cellView)
        cellView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(114)
        }
        
        let locationImageView = UIImageView()
        locationImageView.image = UIImage(named: "place_ic")
        cellView.addSubview(locationImageView)
        locationImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(14)
            make.left.equalToSuperview().inset(14)
            make.height.width.equalTo(16)
        }
        
        productLocationLabel.attributedText = .attributeFont(font: .NSRBold, size: 12, text: "서울시 강남구", lineHeight: 14)
        productLocationLabel.textColor = .nanuriGray4
        cellView.addSubview(productLocationLabel)
        productLocationLabel.snp.makeConstraints { make in
            make.left.equalTo(locationImageView.snp.right).inset(-2)
            make.top.equalToSuperview().inset(14)
        }
        
        productImage.backgroundColor = .nanuriGray2
        productImage.contentMode = .scaleToFill
        cellView.addSubview(productImage)
        productImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.height.width.equalTo(cellView.snp.height)
        }
        
        productName.attributedText = .attributeFont(font: .PRegular, size: 17, text: "로스팅 원두", lineHeight: 20)
        productName.lineBreakMode = .byTruncatingTail
        cellView.addSubview(productName)
        productName.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(14)
            make.top.equalTo(locationImageView.snp.bottom).inset(-4)
            make.right.equalTo(productImage.snp.left).inset(-10)
        }
        
        productPrice.attributedText = .attributeFont(font: .PBold, size: 16, text: "3,500원", lineHeight: 19)
        productPrice.textAlignment = .right
        cellView.addSubview(productPrice)
        productPrice.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom).inset(-5)
            make.left.equalToSuperview().inset(14)
            make.right.equalTo(productImage.snp.left).inset(-10)
        }
        
        cellView.addSubview(deliveryTagView)
        deliveryTagView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(14)
            make.bottom.equalToSuperview().inset(14)
        }
        
        cellView.addSubview(dDayTagView)
        dDayTagView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(14)
            make.left.equalTo(deliveryTagView.snp.right).inset(-4)
        }
        
        totalRecruit.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "/5", lineHeight: 14)
        totalRecruit.textColor = .nanuriGray4
        cellView.addSubview(totalRecruit)
        totalRecruit.snp.makeConstraints { make in
            make.right.equalTo(productImage.snp.left).inset(-10)
            make.bottom.equalToSuperview().inset(14)
        }
        
        productParticipant.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "2", lineHeight: 14)
        productParticipant.textColor = .nanuriOrange
        cellView.addSubview(productParticipant)
        productParticipant.snp.makeConstraints { make in
            make.right.equalTo(totalRecruit.snp.left)
            make.bottom.equalToSuperview().inset(14)
        }
        

        let participantImageView = UIImageView()
        participantImageView.image = UIImage(named: "people_ic")
        cellView.addSubview(participantImageView)
        participantImageView.snp.makeConstraints { make in
            make.right.equalTo(productParticipant.snp.left).inset(-6)
            make.bottom.equalToSuperview().inset(14)
        }
    }

}
