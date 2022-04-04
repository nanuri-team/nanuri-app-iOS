//
//  MainProductTableViewCell.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import UIKit

class MainProductTableViewCell: UITableViewCell {
    
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
        cellView.layer.borderColor = UIColor.nanuriLightGray.cgColor
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
        
        let productLocationLabel = UILabel()
        productLocationLabel.attributedText = NSAttributedString(string: "서울시 강남구")
        productLocationLabel.font = UIFont.systemFont(ofSize: 12)
        cellView.addSubview(productLocationLabel)
        productLocationLabel.snp.makeConstraints { make in
            make.left.equalTo(locationImageView.snp.right).inset(-2)
            make.top.equalToSuperview().inset(14)
        }
        
        let productImage = UIImageView()
        productImage.backgroundColor = .nanuriLightGray
        productImage.contentMode = .scaleToFill
        cellView.addSubview(productImage)
        productImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.height.width.equalTo(cellView.snp.height)
        }
        
        let productName = UILabel()
        productName.attributedText = NSAttributedString(string: "로스팅 원두")
        productName.font = UIFont.systemFont(ofSize: 17)
        cellView.addSubview(productName)
        productName.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(14)
            make.top.equalTo(locationImageView.snp.bottom).inset(-4)
            make.right.equalTo(productImage.snp.left).inset(10)
        }
        
        let productPrice = UILabel()
        productPrice.attributedText = NSAttributedString(string: "3,500원")
        productPrice.textAlignment = .right
        productPrice.font = UIFont.systemFont(ofSize: 16)
        cellView.addSubview(productPrice)
        productPrice.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom).inset(-5)
            make.left.equalToSuperview().inset(14)
            make.right.equalTo(productImage.snp.left).inset(-10)
        }
        
        let deliveryTagView = DeliveryTagView(type: .direct)
        cellView.addSubview(deliveryTagView)
        deliveryTagView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(14)
            make.bottom.equalToSuperview().inset(14)
        }
        
        let dDayTagView = DDayTagView(dDay: "5")
        cellView.addSubview(dDayTagView)
        dDayTagView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(14)
            make.left.equalTo(deliveryTagView.snp.right).inset(-4)
        }
        
        let totalRecruit = UILabel()
        totalRecruit.attributedText = NSAttributedString(string: "/5")
        totalRecruit.font = UIFont.systemFont(ofSize: 12)
        totalRecruit.textColor = .nanuriGray
        cellView.addSubview(totalRecruit)
        totalRecruit.snp.makeConstraints { make in
            make.right.equalTo(productImage.snp.left).inset(-10)
            make.bottom.equalToSuperview().inset(14)
        }
        
        let productParticipant = UILabel()
        productParticipant.attributedText = NSAttributedString(string: "2")
        productParticipant.font = UIFont.systemFont(ofSize: 12)
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
