//
//  CustomSettingTableViewCell.swift
//  nanuri-app-renewal
//
//  Created by heyji on 2022/09/08.
//

import UIKit

class CustomSettingTableViewCell: UITableViewCell {
    
    static let cellId = "SettingCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.attributedText = .attributeFont(font: .PRegular, size: 15, text: "", lineHeight: 18)
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .nanuriGray4
        label.attributedText = .attributeFont(font: .PRegular, size: 11, text: "", lineHeight: 13)
        label.font = .systemFont(ofSize: 11)
        label.numberOfLines = 2
        return label
    }()
    let pushSwitch: UISwitch = {
        let pushSwitch = UISwitch()
        pushSwitch.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        return pushSwitch
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 6
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    private func setupCell() {
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(16)
        }
        contentView.addSubview(pushSwitch)
        pushSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
            make.left.greaterThanOrEqualTo(stackView.snp.right).inset(30)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
