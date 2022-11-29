//
//  CategoryCell.swift
//  nanuri-app-renewal
//
//  Created by heyji on 2022/08/16.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    static let cellID = "CatagoryCell"
    
    override var isSelected: Bool {
        didSet {
            self.cellview.backgroundColor = isSelected ? .nanuriGreen : .nanuriGray2.withAlphaComponent(0.5)
            self.categoryName.textColor = isSelected ? .white : .nanuriGray4
        }
    }
    
    let cellview: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 14
        view.backgroundColor = .nanuriGray2.withAlphaComponent(0.5)
        return view
    }()
    
    let categoryName: UILabel = {
        let label = UILabel()
        label.textColor = .nanuriGray4
        label.attributedText = .attributeFont(font: .PRegular, size: 14, text: "", lineHeight: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        self.categoryName.text = text
    }
    
    private func setupView() {
        addSubview(cellview)
        cellview.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(1)
            make.left.right.equalToSuperview()
            make.height.equalTo(28)
        }
        
        cellview.addSubview(categoryName)
        categoryName.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
    }
}

