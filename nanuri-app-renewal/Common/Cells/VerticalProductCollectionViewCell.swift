//
//  VerticalProductCollectionViewCell.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/05.
//

import UIKit

class VerticalProductCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "verticalProductCell"
    
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
        
        let productImageView = UIImageView()
        productImageView.layer.cornerRadius = 12
        productImageView.backgroundColor = .nanuriGray2
        cellView.addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.width.equalTo(120)
        }
        
        let dDayTagView = DDayTagView(dDay: "3")
        cellView.addSubview(dDayTagView)
        dDayTagView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.right.equalToSuperview().inset(6)
        }
        
        let deliveryTagView = DeliveryTagView(type: .delivery)
        cellView.addSubview(deliveryTagView)
        deliveryTagView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.right.equalTo(dDayTagView.snp.left).inset(-2)
        }
        
        let productName = UILabel()
        productName.attributedText = NSAttributedString(string: "로스팅 원두")
        productName.font = UIFont.systemFont(ofSize: 14)
        cellView.addSubview(productName)
        productName.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(productImageView.snp.bottom).inset(-6)
        }
        
        let productPrice = UILabel()
        productPrice.attributedText = NSAttributedString(string: "3,500원")
        productPrice.font = UIFont.systemFont(ofSize: 11)
        cellView.addSubview(productPrice)
        productPrice.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom).inset(-4)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        let totalRecruit = UILabel()
        totalRecruit.attributedText = NSAttributedString(string: "/5")
        totalRecruit.font = UIFont.systemFont(ofSize: 12)
        totalRecruit.textColor = .nanuriGray4
        cellView.addSubview(totalRecruit)
        totalRecruit.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom).inset(-4)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        let productParticipant = UILabel()
        productParticipant.attributedText = NSAttributedString(string: "2")
        productParticipant.font = UIFont.systemFont(ofSize: 12)
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
