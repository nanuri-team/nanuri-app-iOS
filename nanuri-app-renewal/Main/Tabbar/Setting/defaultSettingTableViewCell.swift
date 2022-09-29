//
//  DefaultSettingTableViewCell.swift
//  nanuri-app-renewal
//
//  Created by heyji on 2022/09/08.
//

import UIKit

class DefaultSettingTableViewCell: UITableViewCell {
    
    static let cellId: String = "defaultSettingCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.attributedText = .attributeFont(font: .PRegular, size: 15, text: "", lineHeight: 18)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
    private func setupCell() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(16)
        }
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
}
