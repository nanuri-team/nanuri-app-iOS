//
//  ChattingViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/23.
//

import UIKit
import Starscream


class ChattingViewController: UIViewController {
    
    private var socket: WebSocket!
    let chatTableView = UITableView()
    let chatTextField = UITextField()
    
    var bottomViewHeight = 64
    var edgeHeight = 34
    var roomName = "uuid"
    var messageData: [ChatResponse] = []
    var loadMessageData: [LoadChatResponse] = []
    var messageType = "load_message"

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "채팅"
        extendedLayoutIncludesOpaqueBars = true
        let backButton = UIBarButtonItem(image: UIImage(named: "back_ic"), style: .plain, target: self, action: #selector(selectBackButton))
        self.navigationItem.setLeftBarButton(backButton, animated: true)
        
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpWebSocket()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        socket.disconnect()
    }
    
    @objc func selectBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectSendButton() {
        guard let chatText = chatTextField.text else { return }
        self.sendMessage(chatText)
        chatTextField.text = ""
    }
    
    func tableViewOffset() {
    }
    
    private func setUpWriteData(chatType: String, message: String) -> String {
        let data = SendChatResponse(type: chatType, message: message)
        let json = try? JSONEncoder().encode(data)
        let value = String(decoding: json!, as: UTF8.self)
        return value
    }
    
    private func setUpWebSocket() {
        print("setUpSocket")
        let url = URL(string: "wss://nanuri.app/ws/chat/\(roomName)/?token=\(Singleton.shared.userToken)")!
        let request = URLRequest(url: url)
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
    
    private func sendMessage(_ message: String) {
        messageType = ChatType.sendMessage
        if !message.isEmpty {
            socket.write(string: setUpWriteData(chatType: messageType, message: message))
        }
    }
    
    private func loadMessage() {
        print("loadMessage")
        messageType = ChatType.loadMessage
        socket.write(string: setUpWriteData(chatType: messageType, message: ""))
    }
    
    func tableScrollUpdate() {
        let indexPath = IndexPath( row: messageData.count - 1, section: 0 )
        self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
    }

    func setUpView() {
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.separatorStyle = .none
        chatTableView.separatorInset = .zero
        chatTableView.rowHeight = UITableView.automaticDimension
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
        sendButton.addTarget(self, action: #selector(selectSendButton), for: .touchUpInside)
    }
}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
      return messageData.count
  }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let messageData = messageData[indexPath.row]
        let identifier = "\(indexPath.row)"
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            return reuseCell
        } else {
            if messageData.sender == "nanuriaws@gmail.com" {
                let cell = MyChatMessageViewCell.init(style: .default, reuseIdentifier: identifier)
                cell.selectionStyle = .none
                
                cell.chatLabel.attributedText = .attributeFont(font: .PRegular, size: 13, text: messageData.message, lineHeight: 19)
                
                return cell
            } else {
                let cell = YourChatMessageViewCell.init(style: .default, reuseIdentifier: identifier)
                cell.selectionStyle = .none
                cell.userName.attributedText = .attributeFont(font: .PBold, size: 13, text: messageData.sender, lineHeight: 15)
                cell.chatLabel.attributedText = .attributeFont(font: .PRegular, size: 13, text: messageData.message, lineHeight: 19)
                
                return cell
            }
        }
    }
}

extension ChattingViewController: WebSocketDelegate {
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
//          client.write(string: "userName")
            print("websocket is connected: \(headers)")
            self.loadMessage()
        case .disconnected(let reason, let code):
          print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let text):
            print("text")
            guard let data = text.data(using: .utf16),
                  let jsonData = try? JSONSerialization.jsonObject(with: data, options: []),
                  let jsonDict = jsonData as? NSDictionary
            else { return }
   
            if messageType == ChatType.loadMessage {
                guard let data = jsonDict["message"] as? NSArray else { return }
                
                for i in 0..<data.count {
                    guard  let message = data[i] as? NSDictionary,
                           let text = message["message"] as? String,
                           let sender = message["message_from"] as? String
                    else { return }
                    messageData.append(ChatResponse(message: text, sender: sender, createdAt: ""))
                }
                self.chatTableView.reloadData()
            } else {
                guard let text = jsonDict["message"] as? String,
                      let sender = jsonDict["sender"] as? String
                else { return }
                messageData.append(ChatResponse(message: text, sender: sender, createdAt: ""))
                self.chatTableView.reloadData()
            }
            self.tableScrollUpdate()
        case .binary(let data):
          print("Received data: \(data.count)")
        case .ping(_):
          break
        case .pong(_):
          break
        case .viabilityChanged(_):
          break
        case .reconnectSuggested(_):
          break
        case .cancelled:
          print("websocket is canclled")
        case .error(let error):
          print("websocket is error = \(error!)")
        }
    }
    
}
