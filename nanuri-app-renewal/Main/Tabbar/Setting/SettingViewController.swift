//
//  SettingViewController.swift
//  nanuri-app-renewal
//
//  Created by a0000 on 2022/04/05.
//

import UIKit
import SafariServices
import MessageUI

class SettingViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let sortOfSection: [[String]] = [["활동 알림 설정", "채팅 알림 설정", "마케팅 알림 설정"],
                                        ["공지사항", "도움말", "문의하기"],
                                        ["이용약관", "개인정보처리방침", "위치 기반 서비스 이용약관", "오픈소스 라이선스"],
                                        ["로그아웃", "회원탈퇴"]]
    private let descriptionOfFirstSection: [String] = ["댓글, 즐겨찾기, 모집 마감 등 공동구매 활동에 대한 알림입니다.", "채팅방 생성, 새로운 채팅 등 채팅에 대한 알림입니다.", "프로모션, 이벤트 등 광고성 소식에 대한 알림입니다."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 테이블뷰에서 셀 선택 후 돌아왔을떄 선택된 셀 해제
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    
    private func setUpView() {
        self.navigationItem.title = "설정"
        extendedLayoutIncludesOpaqueBars = true
        let backButton = UIBarButtonItem(image: UIImage(named: "back_ic"), style: .plain, target: self, action: #selector(selectBackButton))
        self.navigationItem.setLeftBarButton(backButton, animated: true)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(CustomSettingTableViewCell.self, forCellReuseIdentifier: CustomSettingTableViewCell.cellId)
        tableView.register(DefaultSettingTableViewCell.self, forCellReuseIdentifier: DefaultSettingTableViewCell.cellId)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc private func selectBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func activeSwitchTapped(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: NotiSetting.notiOfActive.rawValue)
    }
    
    @objc private func chatSwitchTapped(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: NotiSetting.notiOfChat.rawValue)
    }
    
    @objc private func eventSwitchTapped(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: NotiSetting.notiOfEvent.rawValue)
    }
}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate, CustomAlertDelegate {
    
    // DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return sortOfSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return sortOfSection[0].count
        case 1:
            return sortOfSection[1].count
        case 2:
            return sortOfSection[2].count
        case 3:
            return sortOfSection[3].count
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CustomSettingTableViewCell.cellId, for: indexPath) as! CustomSettingTableViewCell
            cell.configure(title: sortOfSection[indexPath.section][indexPath.row], description: descriptionOfFirstSection[indexPath.row])
            switch indexPath.row {
            case 0:
                cell.pushSwitch.isOn = UserDefaults.standard.bool(forKey: NotiSetting.notiOfActive.rawValue)
                cell.pushSwitch.addTarget(self, action: #selector(activeSwitchTapped), for: .touchUpInside)
            case 1:
                cell.pushSwitch.isOn = UserDefaults.standard.bool(forKey: NotiSetting.notiOfChat.rawValue)
                cell.pushSwitch.addTarget(self, action: #selector(chatSwitchTapped), for: .touchUpInside)
            case 2:
                cell.pushSwitch.isOn = UserDefaults.standard.bool(forKey: NotiSetting.notiOfEvent.rawValue)
                cell.pushSwitch.addTarget(self, action: #selector(eventSwitchTapped), for: .touchUpInside)
            default:
                break
            }
            return cell
        case 1, 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: DefaultSettingTableViewCell.cellId, for: indexPath) as! DefaultSettingTableViewCell
            cell.configure(title: sortOfSection[indexPath.section][indexPath.row])
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: DefaultSettingTableViewCell.cellId, for: indexPath) as! DefaultSettingTableViewCell
            if indexPath.row == 0 {
                cell.configure(title: sortOfSection[indexPath.section][indexPath.row])
            } else {
                cell.configure(title: sortOfSection[indexPath.section][indexPath.row])
                cell.titleLabel.textColor = .nanuriGray4
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    // Delegate
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 67
        }
        return 48
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            break
        case 1:
            if indexPath.row == 0 {
                // TODO: 공지사항
                guard let url = URL(string: "https://www.google.com") else { return }
                let safari = SFSafariViewController(url: url)
                present(safari, animated: true)
            } else if indexPath.row == 1 {
                // TODO: 도움말
                
            } else {
                // 문의하기
                self.sendEmail()
            }
        case 2:
            if indexPath.row == 0 {
                // TODO: 이용약관
                guard let url = URL(string: "https://www.google.com") else { return }
                let safari = SFSafariViewController(url: url)
                present(safari, animated: true)
            } else if indexPath.row == 1 {
                // TODO: 개인정보처리방침
                
            } else if indexPath.row == 2 {
                // TODO: 위치 기반 서비스 이용야관
                
            } else {
                // TODO: 오픈소스 라이선스
                
            }
        case 3:
            if indexPath.row == 0 {
                // 로그아웃
                for key in UserDefaults.standard.dictionaryRepresentation().keys {
                    UserDefaults.standard.removeObject(forKey: key.description)
                }
                let viewController = LoginViewController()
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(viewController)
                print("로그아웃되었습니다.")
                
            } else {
                // 회원탈퇴
                let viewController = CustomAlertViewController(firstTitle: "나누리 회원을", secondEmphTitle: "탈퇴", backSecondTitle: "하시겠습니까?", descriptionContent: "탈퇴 30일 후, 계정이 완전히 삭제됩니다.\n신중하게 선택해주세요.", grayColorButtonTitle: "취소", greenColorButtonTitle: "탈퇴하기", customAlertType: .doneAndCancel, alertHeight: 244)
                viewController.delegate = self
                viewController.modalTransitionStyle = .crossDissolve
                viewController.modalPresentationStyle = .overFullScreen
                self.present(viewController, animated: true)
            }
        default:
            break
        }
    }
    
    func action() {
        let params: [String: Any] = ["is_active": false]
        NetworkService.shared.patchUserIsActiveRequest(parameters: params)
        
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
        
        self.view.window?.rootViewController?.dismiss(animated: true, completion: {
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
            guard let rootViewController = sceneDelegate.window?.rootViewController as? MainViewController else { return }
            rootViewController.getLoginViewController()
        })
    }
    
    func exit() {
        
    }
    
    // 첫번째 섹션은 셀 선택이 되지 않도록 설정
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section != 0
    }
}

extension SettingViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let composeViewController = MFMailComposeViewController()
            composeViewController.mailComposeDelegate = self
            
            let bodyString = """
                                 이곳에 내용을 작성해주세요.
                                 
                                 
                                 -------------------
                                 
                                 Device Model : \(self.getDeviceIdentifier())
                                 Device OS : \(UIDevice.current.systemVersion)
                                 App Version : \(self.getCurrentVersion())
                                 
                                 -------------------
                                 """
            
            composeViewController.setToRecipients(["nanuriapp@gmail.com"])
            composeViewController.setSubject("<나누리> 문의 및 의견")
            composeViewController.setMessageBody(bodyString, isHTML: false)
            
            self.present(composeViewController, animated: true, completion: nil)
        } else {
            print("메일 보내기 실패")
            let sendMailErrorAlert = UIAlertController(title: "메일 전송 실패", message: "메일을 보내려면 'Mail' 앱이 필요합니다. App Store에서 해당 앱을 복원하거나 이메일 설정을 확인하고 다시 시도해주세요.", preferredStyle: .alert)
            let goAppStoreAction = UIAlertAction(title: "App Store로 이동하기", style: .default) { _ in
                // 앱스토어로 이동하기(Mail)
                if let url = URL(string: "https://apps.apple.com/kr/app/mail/id1108187098"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }
            let cancleAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
            
            sendMailErrorAlert.addAction(goAppStoreAction)
            sendMailErrorAlert.addAction(cancleAction)
            self.present(sendMailErrorAlert, animated: true, completion: nil)
        }
    }
    // Device Identifier 찾기
    func getDeviceIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        return identifier
    }
    
    // 현재 버전 가져오기
    func getCurrentVersion() -> String {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
        return version
    }
}
