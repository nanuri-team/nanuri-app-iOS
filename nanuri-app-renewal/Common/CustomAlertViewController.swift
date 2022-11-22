//
//  CustomAlertViewController.swift
//  nanuri-app-renewal
//
//  Created by heyji on 2022/11/09.
//

import UIKit

protocol CustomAlertDelegate {
    func action()
    func exit()
}

enum CustomAlertType {
    case onlyDone
    case doneAndCancel
}

class CustomAlertViewController: UIViewController {
    
    lazy var backgroudView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        view.backgroundColor = .black.withAlphaComponent(0.4)
        return view
    }()
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    lazy var firstTitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .attributeFont(font: .PSemibold, size: 20, text: firstTitle, lineHeight: 24)
        label.textAlignment = .center
        return label
    }()
    lazy var frontSecondTitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .attributeFont(font: .PSemibold, size: 20, text: frontSecondTitle, lineHeight: 24)
        return label
    }()
    lazy var secondEmphTitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .attributeFont(font: .PSemibold, size: 20, text: secondEmphTitle, lineHeight: 24)
        label.textColor = .nanuriRed
        return label
    }()
    lazy var secondTitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .attributeFont(font: .PSemibold, size: 20, text: backSecondTitle, lineHeight: 24)
        return label
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [frontSecondTitleLabel, secondEmphTitleLabel, secondTitleLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .attributeFont(font: .PRegular, size: 15, text: descriptionContent, lineHeight: 22)
        label.textAlignment = .center
        label.textColor = .nanuriGray4
        label.numberOfLines = 2
        return label
    }()
    lazy var grayColorButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: grayColorButtonTitle, lineHeight: 18), for: .normal)
        button.setTitleColor(.nanuriGray5, for: .normal)
        button.backgroundColor = .nanuriGray2
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    lazy var greenColorButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: greenColorButtonTitle, lineHeight: 18), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .nanuriGreen
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [grayColorButton, greenColorButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    var firstTitle: String
    var frontSecondTitle: String
    var secondEmphTitle: String
    var backSecondTitle: String
    var descriptionContent: String
    var grayColorButtonTitle: String
    var greenColorButtonTitle: String
    var customAlertType: CustomAlertType
    var height: Int
    
    var delegate: CustomAlertDelegate?
    
    init(firstTitle: String, frontSecondTitle: String? = nil, secondEmphTitle: String? = nil, backSecondTitle: String? = nil, descriptionContent: String? = nil, grayColorButtonTitle: String? = nil, greenColorButtonTitle: String? = nil, customAlertType: CustomAlertType, alertHeight: Int) {
        self.firstTitle = firstTitle
        self.frontSecondTitle = frontSecondTitle ?? ""
        self.secondEmphTitle = secondEmphTitle ?? ""
        self.backSecondTitle = backSecondTitle ?? ""
        self.descriptionContent = descriptionContent ?? ""
        self.grayColorButtonTitle = grayColorButtonTitle ?? ""
        self.greenColorButtonTitle = greenColorButtonTitle ?? ""
        self.customAlertType = customAlertType
        self.height = alertHeight
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        setCustomAlertView()
        
        switch customAlertType {
        case .onlyDone:
            grayColorButton.isHidden = false
            greenColorButton.isHidden = true
        case .doneAndCancel:
            grayColorButton.isHidden = false
            greenColorButton.isHidden = false
        }
    }
    
    private func setCustomAlertView() {
        self.view.addSubview(backgroudView)
        backgroudView.addSubview(mainView)
        mainView.addSubview(firstTitleLabel)
        mainView.addSubview(stackView)
        mainView.addSubview(descriptionLabel)
        mainView.addSubview(buttonStackView)
        
        backgroudView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mainView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(self.height)
        }
        firstTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(44)
            make.centerX.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(firstTitleLabel.snp.bottom).offset(4)
            make.height.equalTo(25)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        buttonStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.exit()
        }

    }
    
    @objc func actionButtonTapped() {
        self.dismiss(animated: true) {
            self.delegate?.action()
        }
    }
}
