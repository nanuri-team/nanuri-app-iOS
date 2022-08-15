//
//  NotificationTableViewCell.swift
//  nanuri-app-renewal
//
//  Created by heyji on 2022/08/15.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let cellBackgroudView: UIView = {
        let view = UIView()
        view.backgroundColor = .nanuriLightGreen.withAlphaComponent(0.1)
        return view
    }()
    
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 28
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .nanuriGray1
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.nanuriGray2.cgColor
        return imageView
    }()
    
    let notificationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .nanuriGray7
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .nanuriGray3
        return label
    }()
    
    static let cellID = "notificationCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        contentView.addSubview(cellView)
        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(88)
        }
        
        cellView.addSubview(cellBackgroudView)
        cellBackgroudView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
          
        cellView.addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.centerY.equalToSuperview()
            make.width.equalTo(56)
            make.height.equalTo(56)
        }
        
        cellView.addSubview(notificationLabel)
        notificationLabel.attributedText = .attributeFont(font: .PRegular, size: 13, text: "새싹자취생님이 회원님의 상품 '로스팅 원두'를 관심 등록하였습니다.", lineHeight: 19)
        notificationLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.top)
            make.left.equalTo(productImageView.snp.right).inset(-10)
            make.right.equalTo(32)
            make.height.equalTo(38)
        }
        
        cellView.addSubview(dateLabel)
        dateLabel.attributedText = .attributeFont(font: .PRegular, size: 12, text: "2022.08.22(화) 13:48", lineHeight: 18)
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(notificationLabel.snp.left)
            make.bottom.equalTo(productImageView.snp.bottom)
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            cellBackgroudView.backgroundColor = .white
        }
    }

}
