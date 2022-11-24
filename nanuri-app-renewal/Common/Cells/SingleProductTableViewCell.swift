//
//  SingleProductTableViewCell.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/11/24.
//

import UIKit

class SingleProductTableViewCell: UITableViewCell {
    
    let productImageView = UIImageView()
    let productLocationLabel = UILabel()
    let dDayTagView = DDayTagView()
    let productNameLabel = UILabel()
    let productPriceLabel = UILabel()
    let deliveryTagView = DeliveryTagView()
    let totalRecruitLabel = UILabel()
    let productParticipantLabel = UILabel()

    
    init(reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        let cellView = UIView()
        self.contentView.addSubview(cellView)
        
        productImageView.backgroundColor = .nanuriGray1
        productImageView.clipsToBounds = true
        productImageView.layer.cornerRadius = 12
        productImageView.contentMode = .scaleAspectFill
        cellView.addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.width.height.equalTo(114)
            make.top.bottom.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(16)
        }
        
        let locationImageView = UIImageView()
        locationImageView.image = UIImage(named: "place_fill_ic")
        cellView.addSubview(locationImageView)
        locationImageView.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.top)
            make.left.equalTo(productImageView.snp.right).inset(-19)
            make.height.width.equalTo(13)
        }
        
        productLocationLabel.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "서울시 강남구", lineHeight: 14)
        productLocationLabel.textColor = .nanuriGray4
        cellView.addSubview(productLocationLabel)
        productLocationLabel.snp.makeConstraints { make in
            make.left.equalTo(locationImageView.snp.right).inset(-5)
            make.top.equalTo(locationImageView.snp.top)
        }
        
        cellView.addSubview(dDayTagView)
        dDayTagView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(productImageView.snp.top)
        }
        
        productNameLabel.attributedText = .attributeFont(font: .PMedium, size: 16, text: "슬로우코프 비건 향균 칫솔", lineHeight: 20)
        cellView.addSubview(productNameLabel)
        productNameLabel.snp.makeConstraints { make in
            make.top.equalTo(locationImageView.snp.bottom).inset(-5)
            make.left.equalTo(locationImageView.snp.left)
            make.right.equalToSuperview().inset(16)
        }
        
        productPriceLabel.attributedText = .attributeFont(font: .PBold, size: 16, text: "7,000원", lineHeight: 19)
        cellView.addSubview(productPriceLabel)
        productPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(productNameLabel.snp.bottom).inset(-5)
            make.left.equalTo(productNameLabel.snp.left)
            make.right.equalToSuperview().inset(16)
        }
        
        cellView.addSubview(deliveryTagView)
        deliveryTagView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.left.equalTo(productImageView.snp.right).inset(-16)
        }
        
        totalRecruitLabel.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "/5", lineHeight: 14)
        totalRecruitLabel.textColor = .nanuriGray3
        cellView.addSubview(totalRecruitLabel)
        totalRecruitLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(10)
        }
        
        productParticipantLabel.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "2", lineHeight: 14)
        productParticipantLabel.textColor = .nanuriBlack1
        cellView.addSubview(productParticipantLabel)
        productParticipantLabel.snp.makeConstraints { make in
            make.right.equalTo(totalRecruitLabel.snp.left)
            make.bottom.equalToSuperview().inset(10)
        }
        
        let participantImageView = UIImageView()
        participantImageView.image = UIImage(named: "people_ic")
        cellView.addSubview(participantImageView)
        participantImageView.snp.makeConstraints { make in
            make.right.equalTo(productParticipantLabel.snp.left).inset(-6)
            make.bottom.equalToSuperview().inset(10)
            make.height.width.equalTo(16)
        }
        
        cellView.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.top).inset(-10)
            make.bottom.equalTo(productImageView.snp.bottom).inset(-10)
            make.edges.equalToSuperview()
        }
    }
}
