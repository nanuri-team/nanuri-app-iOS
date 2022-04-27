//
//  ChattingViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/23.
//

import UIKit

class ChattingViewController: UIViewController {
    
    var bottomViewHeight = 64
    var edgeHeight = 34

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "채팅"
        
        let backButton = UIBarButtonItem(image: UIImage(named: "back_ic"), style: .plain, target: self, action: #selector(selectBackButton))
        self.navigationItem.setLeftBarButton(backButton, animated: true)
        
        setUpView()
        
    }
    
    @objc func selectBackButton() {
        self.navigationController?.popViewController(animated: true)
    }

    func setUpView() {
        let chatTableView = UITableView()
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.separatorStyle = .none
        chatTableView.separatorInset = .zero
        self.view.addSubview(chatTableView)
        
        let chatTableViewHeight = (CGFloat(edgeHeight) + CGFloat(bottomViewHeight))
        chatTableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(chatTableViewHeight)
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
        
        let chatTextField = UITextField()
        chatTextField.borderStyle = .line
        chatTextField.backgroundColor = .nanuriGray1
        chatTextField.clipsToBounds = true
        chatTextField.layer.borderWidth = 1
        chatTextField.layer.borderColor = UIColor.nanuriGray2.cgColor
        chatTextField.attributedText = .attributeFont(font: .PRegular, size: 15, text: "", lineHeight: 18)
        chatTextField.addPadding(width: 20)
        bottomView.addSubview(chatTextField)
        chatTextField.layer.cornerRadius = 25
        chatTextField.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview().inset(8)
        }
        
        let sendButton = UIButton()
        sendButton.setImage(UIImage(named: "chat_ic"), for: .normal)
        chatTextField.addSubview(sendButton)
        sendButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(8)
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
        }
    }
}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "\(indexPath.row)"
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            return reuseCell
        } else {
            if indexPath.row % 2 == 0 {
                let cell = MyChatMessageViewCell.init(style: .default, reuseIdentifier: identifier)
                cell.selectionStyle = .none
                
                return cell
            } else {
                let cell = YourChatMessageViewCell.init(style: .default, reuseIdentifier: identifier)
                cell.selectionStyle = .none
                
                return cell
            }
        }
    }
}
