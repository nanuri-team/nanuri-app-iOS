//
//  EmptyNotiView.swift
//  nanuri-app-renewal
//
//  Created by heyji on 2022/08/16.
//

import UIKit

final class EmptyNotiView: UIView {
    
    let emptyView = UIView()
    
    let emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "face.smiling")
        imageView.tintColor = .nanuriGray2
        return imageView
    }()
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .nanuriGray3
        label.attributedText = .attributeFont(font: .PBold, size: 24, text: "아직 알림이 없습니다.", lineHeight: 24)
        label.textAlignment = .center
        return label
    }()
    
    let emptyDescriptionLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .attributeFont(font: .PRegular, size: 15, text: "즐겨찾기한 상품의 소식, 내가 등록한\n상품의 소식 등을 알림으로 전해드려요.", lineHeight: 22)
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .nanuriGray3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-88)
            make.width.equalTo(300)
            make.height.equalTo(200)
        }
        
        addSubview(emptyImageView)
        emptyImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emptyView.snp.top)
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
        
        addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emptyImageView.snp.bottom).inset(-24)
        }
        
        addSubview(emptyDescriptionLabel)
        emptyDescriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emptyLabel.snp.bottom).inset(-16)
        }
    }
}
