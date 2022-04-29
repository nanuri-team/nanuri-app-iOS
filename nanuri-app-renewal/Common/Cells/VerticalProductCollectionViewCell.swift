//
//  VerticalProductCollectionViewCell.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/05.
//

import UIKit

class VerticalProductCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "verticalProductCell"
    let dDayTagView = DDayTagView()
    let deliveryTagView = DeliveryTagView()
    let productName = UILabel()
    let productPrice = UILabel()
    let totalRecruit = UILabel()
    let productParticipant = UILabel()
    let productImageView = UIImageView()

    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        let cellView = UIView()
        cellView.backgroundColor = .white
        cellView.clipsToBounds = true
        contentView.addSubview(cellView)
        cellView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(163)
            make.width.equalTo(120)
        }
        
        productImageView.layer.cornerRadius = 12
        productImageView.clipsToBounds = true
        productImageView.contentMode = .scaleToFill
        productImageView.backgroundColor = .nanuriGray2
        cellView.addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.width.equalTo(120)
        }
        
        cellView.addSubview(dDayTagView)
        dDayTagView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.right.equalToSuperview().inset(6)
        }
        
        cellView.addSubview(deliveryTagView)
        deliveryTagView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.right.equalTo(dDayTagView.snp.left).inset(-2)
        }
        
        productName.attributedText = .attributeFont(font: .PRegular, size: 14, text: "로스팅 원두", lineHeight: 17)
        cellView.addSubview(productName)
        productName.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(productImageView.snp.bottom).inset(-6)
        }
        
        productPrice.attributedText = .attributeFont(font: .PBold, size: 11, text: "3,500원", lineHeight: 13)
        cellView.addSubview(productPrice)
        productPrice.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom).inset(-4)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        totalRecruit.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "/5", lineHeight: 14)
        totalRecruit.textColor = .nanuriGray4
        cellView.addSubview(totalRecruit)
        totalRecruit.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom).inset(-4)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        productParticipant.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "2", lineHeight: 14)
        productParticipant.textColor = .nanuriOrange
        cellView.addSubview(productParticipant)
        productParticipant.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom).inset(-4)
            make.right.equalTo(totalRecruit.snp.left)
            make.bottom.equalToSuperview()
        }
        

        let participantImageView = UIImageView()
        participantImageView.image = UIImage(named: "people_ic")
        cellView.addSubview(participantImageView)
        participantImageView.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom).inset(-4)
            make.right.equalTo(productParticipant.snp.left).inset(-6)
            make.bottom.equalToSuperview()
        }
        
    }
}
