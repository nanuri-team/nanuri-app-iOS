//
//  AlertViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/15.
//

import UIKit

class AlertViewController: UIViewController {
    
    let okHandler: (() -> Void)?
    let cancelHandler: (() -> Void)?
    
    var contents = UIView()
    var okString: String = ""
    var cancelString: String = ""
    var contentsViewHeight: CGFloat = 301
    
    // 버튼 한 개
    convenience init(contents: UIView, contentsViewHeight: CGFloat = 301, okString: String, okHandler: (() -> Void)?) {
        self.init(contents: contents, contentsViewHeight: contentsViewHeight, cancelString: "", okString: okString, okHandler: okHandler, cancelHandler: nil)
    }
    
    // 버튼 두 개
    convenience init(contents: UIView, contentsViewHeight: CGFloat = 301, cancelString: String, okString: String, cancelHandler: (() -> Void)?, okHandler: (() -> Void)?) {
        self.init(contents: contents, contentsViewHeight: contentsViewHeight, cancelString: cancelString, okString: okString, okHandler: okHandler, cancelHandler: cancelHandler)
        }
    
    init(contents: UIView, contentsViewHeight: CGFloat = 301, cancelString: String, okString: String, okHandler: (() -> Void)?, cancelHandler: (() -> Void)?) {
        self.contents = contents
        self.cancelString = cancelString
        self.okString = okString
        self.cancelHandler = cancelHandler
        self.okHandler = okHandler
        self.contentsViewHeight = contentsViewHeight
        
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .black.withAlphaComponent(0.3)
        self.modalPresentationStyle = .overFullScreen
        
        setUpView()
    }
    
    @objc func selectOkButton() {
        self.dismiss(animated: false) {
            if let okHandler = self.okHandler {
                okHandler()
            }
        }
    }
    
    @objc func selectCancelButton() {
        self.dismiss(animated: false) {
            if let cancelHandler = self.cancelHandler {
                cancelHandler()
            }
        }
    }
    
    func present(_ view: UIViewController?, alertView: UIViewController, animated: Bool) {
        guard let view = view else {
            return
        }
        
        view.present(self, animated: animated, completion: nil)
    }
    
    func setUpView() {
        let alertView = UIView()
        alertView.backgroundColor = .white
        alertView.layer.cornerRadius = 12
        self.view.addSubview(alertView)
        
        let buttonView = UIView()
        alertView.addSubview(buttonView)
        buttonView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(48)
        }
        
        let okButton = MainButton(style: .main)
        okButton.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: okString, lineHeight: 18), for: .normal)
        buttonView.addSubview(okButton)
        okButton.addTarget(self, action: #selector(selectOkButton), for: .touchUpInside)
        
        let cancelButton = MainButton(style: .disable)
        cancelButton.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: cancelString, lineHeight: 18), for: .normal)
        buttonView.addSubview(cancelButton)
        cancelButton.addTarget(self, action: #selector(selectCancelButton), for: .touchUpInside)
        
        
        if cancelString == "" {
            okButton.snp.makeConstraints { make in
                make.bottom.equalToSuperview()
                make.left.right.equalToSuperview().inset(16)
            }
            cancelButton.isHidden = true
        } else {
            cancelButton.isHidden = false
            cancelButton.snp.makeConstraints { make in
                make.bottom.equalToSuperview()
                make.left.equalToSuperview().inset(16)
                make.width.equalToSuperview().multipliedBy(0.43)
            }
            
            okButton.snp.makeConstraints { make in
                make.bottom.equalToSuperview()
                make.right.equalToSuperview().inset(16)
                make.width.equalToSuperview().multipliedBy(0.43)
            }
        }
        
        alertView.addSubview(self.contents)
        self.contents.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalTo(buttonView.snp.top)
            make.height.equalTo(contentsViewHeight)
        }
        
        alertView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.bottom.equalTo(buttonView.snp.bottom).inset(-16)
            make.top.equalTo(contents.snp.top)
            make.left.right.equalToSuperview().inset(15)
        }
    }

}
