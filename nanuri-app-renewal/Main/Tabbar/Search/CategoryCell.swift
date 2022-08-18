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
            self.cellview.layer.borderColor = isSelected ? UIColor.nanuriGreen.cgColor : UIColor.nanuriGray4.cgColor
            self.categoryName.textColor = isSelected ? .nanuriGreen : .nanuriGray4
        }
    }
    
    let cellview: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.nanuriGray4.cgColor
        view.layer.cornerRadius = 14
        return view
    }()
    
    let categoryName: UILabel = {
        let label = UILabel()
        label.textColor = .nanuriGray4
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

