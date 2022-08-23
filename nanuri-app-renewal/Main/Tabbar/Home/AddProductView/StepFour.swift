//
//  StepFour.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/08/23.
//

import UIKit

extension AddProductViewController {
    func setUpStepFourView() {
        
        stepFourView.backgroundColor = .nanuriBlue
        stepFourView.alpha = 0.0
        self.view.addSubview(stepFourView)
        stepFourView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        deliveryTableView.separatorInset = .zero
        deliveryTableView.separatorColor = .nanuriGray2
        deliveryTableView.delegate = self
        deliveryTableView.dataSource = self
        stepFourView.addSubview(deliveryTableView)
        deliveryTableView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
    }
}

extension AddProductViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == deliveryTableView {
            return deliveryName.count
        } else if tableView == categoryTableView {
            return categoryImageName.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == deliveryTableView {
            let identifier = "\(indexPath.row)"
            
            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) { return reuseCell }
            
            let cell = UITableViewCell.init(style: .default, reuseIdentifier: identifier)
            cell.selectionStyle = .none
            
            let deliveryNameLabel = UILabel()
            deliveryNameLabel.attributedText = .attributeFont(font: .PBold, size: 16, text: deliveryName[indexPath.row], lineHeight: 19)
            cell.contentView.addSubview(deliveryNameLabel)
            deliveryNameLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(22)
                make.left.equalToSuperview().inset(24)
            }
            
            let deliveryDescriptionLabel = UILabel()
            deliveryDescriptionLabel.attributedText = .attributeFont(font: .PRegular, size: 12, text: deliveryDescription[indexPath.row], lineHeight: 14)
            deliveryDescriptionLabel.textColor = .nanuriGray4
            cell.contentView.addSubview(deliveryDescriptionLabel)
            deliveryDescriptionLabel.snp.makeConstraints { make in
                make.top.equalTo(deliveryNameLabel.snp.bottom).inset(-8)
                make.left.equalToSuperview().inset(24)
            }
            
            let radioButton = UIButton()
            radioButton.setImage(UIImage(named: "radio_ic"), for: .normal)
            radioButton.tag = indexPath.row
            cell.contentView.addSubview(radioButton)
            radioButton.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().inset(16)
            }
            
            if indexPath.row == 0 {
                radioButton.setImage(UIImage(named: "radio_select_ic"), for: .normal)
                selectIndex = indexPath.row
            }
            
            radioButtonArray.append(radioButton)
            
            return cell
            
        } else if tableView == categoryTableView {
            let identifier = "\(indexPath.row)"
            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
                return reuseCell
            }
            let cell = UITableViewCell.init(style: .default, reuseIdentifier: identifier)
            cell.selectionStyle = .none
            
            let categoryImageView = UIImageView()
            categoryImageView.image = UIImage(named: categoryImageName[indexPath.row])
            cell.contentView.addSubview(categoryImageView)
            categoryImageView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
//                make.top.equalToSuperview().inset(16)
                make.width.height.equalTo(32)
                make.left.equalToSuperview().inset(16)
            }
            
            let categoryLabel = UILabel()
            categoryLabel.attributedText = .attributeFont(font: .PRegular, size: 15, text: categoryName[indexPath.row], lineHeight: 18)
            cell.contentView.addSubview(categoryLabel)
            categoryLabel.snp.makeConstraints { make in
                make.left.equalTo(categoryImageView.snp.right).inset(-16)
                make.centerY.equalToSuperview()
            }
            
            let radioButton = UIButton()
            radioButton.setImage(UIImage(named: "radio_ic"), for: .normal)
            radioButton.tag = indexPath.row
            cell.contentView.addSubview(radioButton)
            radioButton.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().inset(16)
            }
            
            if indexPath.row == 0 {
                radioButton.setImage(UIImage(named: "radio_select_ic"), for: .normal)
                selectIndex = indexPath.row
            }
            
            radioButtonArray.append(radioButton)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == deliveryTableView {
            return 84
        } else if tableView == categoryTableView {
            return 64
        } else {
            return 0
        }
    }
}
