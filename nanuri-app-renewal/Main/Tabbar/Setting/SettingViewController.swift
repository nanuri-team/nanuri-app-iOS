//
//  SettingViewController.swift
//  nanuri-app-renewal
//
//  Created by a0000 on 2022/04/05.
//

import UIKit

class SettingViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let sortOfSection: [[String]] = [["활동 알림 설정", "채팅 알림 설정", "마케팅 알림 설정"],
                                        ["공지사항", "도움말", "문의하기"],
                                        ["이용약관", "개인정보처리방침", "위치 기반 서비스 이용약관", "오픈소스 라이선스"],
                                        ["로그아웃", "회원탈퇴"]]

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        self.navigationItem.title = "설정"
        extendedLayoutIncludesOpaqueBars = true
        let backButton = UIBarButtonItem(image: UIImage(named: "back_ic"), style: .plain, target: self, action: #selector(selectBackButton))
        self.navigationItem.setLeftBarButton(backButton, animated: true)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc func selectBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func switchTapped(_ sender: UISwitch) {
        print(sender)
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    // DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortOfSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return sortOfSection[0].count
        } else if section == 1 {
            return sortOfSection[1].count
        } else if section == 2 {
            return sortOfSection[2].count
        }
        return sortOfSection[3].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        
        if indexPath.section == 0 {
            let pushSwitch = UISwitch()
            cell.contentView.addSubview(pushSwitch)
            pushSwitch.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.right.equalTo(-16)
            }
            pushSwitch.addTarget(self, action: #selector(switchTapped), for: .touchUpInside)
            cell.textLabel?.text = sortOfSection[indexPath.section][indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel?.text = sortOfSection[indexPath.section][indexPath.row]
        } else if indexPath.section == 2 {
            cell.textLabel?.text = sortOfSection[indexPath.section][indexPath.row]
        } else {
            if indexPath.row == 0 {
                cell.textLabel?.text = sortOfSection[indexPath.section][0]
            } else {
                cell.textLabel?.text = sortOfSection[indexPath.section][1]
                cell.textLabel?.textColor = .nanuriGray4
                cell.backgroundColor = .clear
            }
        }
        return cell
    }
    
    // Delegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            print(indexPath.row)
        case 1:
            print(indexPath.row)
        case 2:
            print(indexPath.row)
        case 3:
            if indexPath.row == 0 {
                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                    UserDefaults.standard.removeObject(forKey: key.description)
                }
                print("로그아웃되었습니다.")
                
            } else {
                let signOutViewController = SignOutViewController()
                signOutViewController.modalTransitionStyle = .crossDissolve
                signOutViewController.modalPresentationStyle = .overFullScreen
                self.present(signOutViewController, animated: true, completion: nil)
            }
        default:
            break
        }
    }
}
