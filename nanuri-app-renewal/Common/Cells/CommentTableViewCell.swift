//
//  CommentTableViewCell.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/09.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
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
        cellView.backgroundColor = .white
        self.contentView.addSubview(cellView)
        
        let user = UILabel()
        user.attributedText = NSAttributedString(string: "닉네임뭐하지")
        user.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        cellView.addSubview(user)
        user.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.left.equalToSuperview().inset(16)
        }
        
        let levelView = LevelView(.flower, isLevelName: true)
        cellView.addSubview(levelView)
        levelView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalTo(user.snp.right).inset(-6)
        }
        
        let moreButton = UIButton()
        moreButton.setImage(UIImage(named: "more_gray_ic"), for: .normal)
        cellView.addSubview(moreButton)
        moreButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(16)
        }
        
        let comment = UILabel()
        comment.numberOfLines = 3
        comment.attributedText = NSAttributedString(string: "혹시 인원 못 모여도 공구 진행해주실 수 있나요 ㅜㅜ 제발 해주세여")
        comment.font = UIFont.systemFont(ofSize: 13)
        cellView.addSubview(comment)
        comment.snp.makeConstraints { make in
            make.top.equalTo(user.snp.bottom).inset(-8)
            make.left.right.equalToSuperview().inset(16)
        }
        
        let commentTime = UILabel()
        commentTime.attributedText = NSAttributedString(string: "2022.03.22(화) 13:48")
        commentTime.font = UIFont.systemFont(ofSize: 12)
        commentTime.textColor = .nanuriGray3
        cellView.addSubview(commentTime)
        commentTime.snp.makeConstraints { make in
            make.top.equalTo(comment.snp.bottom).inset(-14)
            make.left.equalToSuperview().inset(16)
        }
        
        let reCommentButton = UIButton()
        reCommentButton.setAttributedTitle(NSAttributedString(string: "답글"), for: .normal)
        reCommentButton.layer.borderColor = UIColor.nanuriGray3.cgColor
        reCommentButton.layer.borderWidth = 1
        reCommentButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        reCommentButton.setTitleColor(.nanuriGray3, for: .normal)
        cellView.addSubview(reCommentButton)
        reCommentButton.snp.makeConstraints { make in
            make.top.equalTo(comment.snp.bottom).inset(-10)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(22)
            make.width.equalTo(37)
        }
        
        cellView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalTo(commentTime.snp.bottom).inset(-16)
        }
        
    }

}
