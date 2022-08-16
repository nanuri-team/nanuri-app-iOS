//
//  NotificationViewController.swift
//  nanuri-app-renewal
//
//  Created by heyji on 2022/08/15.
//

import UIKit

class NotificationViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    let emptyNotiView: EmptyNotiView = {
        let view = EmptyNotiView()
        return view
    }()
    let data: [String] = ["test"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        if data.count == 0 {
            self.emptyNotiView.isHidden = false
        } else {
            self.emptyNotiView.isHidden = true
        }
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "알림"
        extendedLayoutIncludesOpaqueBars = true // 정리
        
        let backButton = UIBarButtonItem(image: UIImage(named: "back_ic"), style: .plain, target: self, action: #selector(tappedBackButton))
        self.navigationItem.setLeftBarButton(backButton, animated: true)
        let deleteButton = UIBarButtonItem(title: "모두 삭제", style: .done, target: self, action: #selector(tappedDeleteButton))
        deleteButton.tintColor = .nanuriGreen
        self.navigationItem.setRightBarButton(deleteButton, animated: true)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(NotificationTableViewCell.self, forCellReuseIdentifier: NotificationTableViewCell.cellID)
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 알림이 없을때
        tableView.addSubview(emptyNotiView)
        emptyNotiView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func tappedBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tappedDeleteButton() {
        // 알림 모두 삭제
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.cellID, for: indexPath)
        return cell
    }
    
    // Cell 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
