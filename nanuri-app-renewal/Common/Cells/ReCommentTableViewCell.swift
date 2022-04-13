//
//  ReCommentTableViewCell.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/09.
//

import UIKit

class ReCommentTableViewCell: UITableViewCell {
    
    static let cellId = "commentCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
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
    
    func setUpView() {
        let cellView = UIView()
        cellView.backgroundColor = .nanuriGray1
        self.contentView.addSubview(cellView)
        
        let reCommentImageView = UIImageView()
        reCommentImageView.image = UIImage(named: "recomment_ic")
        cellView.addSubview(reCommentImageView)
        reCommentImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.left.equalToSuperview().inset(16)
        }
        
        let commentView = UIView()
        cellView.addSubview(commentView)
        
        let user = UILabel()
        user.attributedText = .attributeFont(font: .PBold, size: 13, text: "프로자취러", lineHeight: 16)
        commentView.addSubview(user)
        user.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.left.equalToSuperview()
        }
        
        let levelView = LevelView(.tree, isLevelName: true)
        commentView.addSubview(levelView)
        levelView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalTo(user.snp.right).inset(-6)
        }
        
        let moreButton = UIButton()
        moreButton.setImage(UIImage(named: "more_gray_ic"), for: .normal)
        commentView.addSubview(moreButton)
        moreButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(16)
        }
        
        let comment = UILabel()
        comment.numberOfLines = 3
        comment.attributedText = .attributeFont(font: .PRegular, size: 13, text: "ㅠㅠ 2명뿐이면 어려울 거 같아용..", lineHeight: 19)
        commentView.addSubview(comment)
        comment.snp.makeConstraints { make in
            make.top.equalTo(user.snp.bottom).inset(-8)
            make.left.equalToSuperview()
            make.right.equalToSuperview().inset(16)
        }
        
        let commentTime = UILabel()
        commentTime.attributedText = .attributeFont(font: .PRegular, size: 12, text: "2022.03.22(화) 13:48", lineHeight: 18)
        commentTime.textColor = .nanuriGray3
        commentView.addSubview(commentTime)
        commentTime.snp.makeConstraints { make in
            make.top.equalTo(comment.snp.bottom).inset(-14)
            make.left.equalToSuperview()
        }
        
        commentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(reCommentImageView.snp.right).inset(-10)
            make.right.equalToSuperview()
        }
        
        cellView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.left.equalToSuperview()
            make.bottom.equalTo(commentTime.snp.bottom).inset(-16)
        }
        
    }

}
