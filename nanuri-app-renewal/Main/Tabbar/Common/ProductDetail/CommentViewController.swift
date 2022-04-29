//
//  CommentViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/09.
//

import UIKit

class CommentViewController: UIViewController {
    
    var bottomViewHeight = 64
    var edgeHeight = 34

    override func viewDidLoad() {
        super.viewDidLoad()
        extendedLayoutIncludesOpaqueBars = true
        self.view.backgroundColor = .white
        self.title = "댓글"
        let backButton = UIBarButtonItem(image: UIImage(named: "back_ic"), style: .plain, target: self, action: #selector(selectBackButton))
        self.navigationItem.setLeftBarButton(backButton, animated: true)

        setUpView()
    }
    
    @objc func selectBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpView() {
        let commentTableView = UITableView()
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.separatorColor = .nanuriGray1
        commentTableView.separatorInset = .zero
        self.view.addSubview(commentTableView)
        
        let commentTableViewHeight = (CGFloat(edgeHeight) + CGFloat(bottomViewHeight))
        commentTableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(commentTableViewHeight)
        }
        
        let bottomView = UIView()
        bottomView.backgroundColor = .white
        self.view.addSubview(bottomView)
        self.view.bringSubviewToFront(bottomView)
        bottomView.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.right.left.equalToSuperview()
            make.height.equalTo(bottomViewHeight)
        }
        
        
        let topLineView = UIView()
        topLineView.backgroundColor = .nanuriGray2
        bottomView.addSubview(topLineView)
        topLineView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalToSuperview()
        }
        
        let commentTextField = UITextField()
        commentTextField.placeholder = "댓글을 입력해주세요."
        commentTextField.borderStyle = .line
        commentTextField.backgroundColor = .nanuriGray1
        commentTextField.clipsToBounds = true
        commentTextField.layer.borderWidth = 1
        commentTextField.layer.borderColor = UIColor.nanuriGray2.cgColor
        commentTextField.attributedText = .attributeFont(font: .PRegular, size: 15, text: "", lineHeight: 18)
        commentTextField.addPadding(width: 20)
        bottomView.addSubview(commentTextField)
        commentTextField.layer.cornerRadius = 25
        commentTextField.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview().inset(8)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        let sendButton = UIButton()
        sendButton.setImage(UIImage(named: "send_ic"), for: .normal)
        bottomView.addSubview(sendButton)
        sendButton.snp.makeConstraints { make in
            make.left.equalTo(commentTextField.snp.right)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.centerY.equalToSuperview()
        }
    }
}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "\(indexPath.row)"
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            return reuseCell
        } else {
            
            if indexPath.row % 2 == 0 {
                let cell = CommentTableViewCell.init(style: .default, reuseIdentifier: identifier)
                cell.selectionStyle = .none
                
                return cell
            } else {
                let cell = ReCommentTableViewCell.init(style: .default, reuseIdentifier: identifier)
                cell.selectionStyle = .none
                
                return cell
            }
        }
    }
    
    
}
