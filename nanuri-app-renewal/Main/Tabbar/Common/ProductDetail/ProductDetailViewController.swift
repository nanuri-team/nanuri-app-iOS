//
//  ProductDetailViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/07.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    var bottomViewHeight = 64
    var edgeHeight = 34
    let ratioWidth = UIScreen.main.bounds.width / 375

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "상품 정보"
        let backButton = UIBarButtonItem(image: UIImage(named: "back_ic"), style: .plain, target: self, action: #selector(selectBackButton))
        let optionButton = UIBarButtonItem(image: UIImage(named: "more_ic"), style: .plain, target: self, action: #selector(selectOptionButton))
        self.navigationItem.setLeftBarButton(backButton, animated: true)
        self.navigationItem.setRightBarButton(optionButton, animated: true)
        
        setUpView()
        setUpBottomView()
    }

    @objc func selectBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectOptionButton() {
        print("Click")
        presentOptionAlert()
    }
    
    func presentOptionAlert() {
        let optionAlert = UIAlertController(title: "상품을 수정하거나 삭제할 수 있습니다.", message: nil, preferredStyle: .actionSheet)
        let editAction = UIAlertAction(title: "수정하기", style: .default, handler: nil)
        let deleteAction = UIAlertAction(title: "삭제하기", style: .destructive, handler: nil)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        optionAlert.addAction(editAction)
        optionAlert.addAction(deleteAction)
        optionAlert.addAction(cancelAction)
        
        self.present(optionAlert, animated: true, completion: nil)
    }
    
    func setUpBottomView() {
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
        
        
        let purchaseButton = MainButton(style: .main)
        purchaseButton.setAttributedTitle(NSAttributedString(string: "공동 구매 참여하기"), for: .normal)
        bottomView.addSubview(purchaseButton)
        purchaseButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(8)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.top.bottom.equalToSuperview().inset(8)
        }
        
        let commentView = UIView()
        bottomView.addSubview(commentView)
        commentView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(13)
            make.left.equalTo(purchaseButton.snp.right).inset(-5)
            make.width.equalToSuperview().multipliedBy(0.1)
            make.bottom.equalToSuperview().inset(9)
        }
        
        let commentButton = UIButton()
        commentButton.setImage(UIImage(named: "comment_ic"), for: .normal)
        commentView.addSubview(commentButton)
        commentButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        let commentCount = UILabel()
        commentCount.attributedText = NSAttributedString(string: "0")
        commentCount.textColor = .nanuriGray3
        commentCount.font = UIFont.systemFont(ofSize: 12)
        commentView.addSubview(commentCount)
        commentCount.snp.makeConstraints { make in
            make.top.equalTo(commentButton.snp.bottom).inset(-4)
            make.centerX.equalToSuperview()
        }
        
        let favoriteView = UIView()
        bottomView.addSubview(favoriteView)
        favoriteView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(13)
            make.left.equalTo(commentView.snp.right)
            make.width.equalToSuperview().multipliedBy(0.1)
            make.bottom.equalToSuperview().inset(9)
        }
        
        let favoriteButton = UIButton()
        favoriteButton.setImage(UIImage(named: "favorite_ic"), for: .normal)
        favoriteView.addSubview(favoriteButton)
        favoriteButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        let favoriteCount = UILabel()
        favoriteCount.attributedText = NSAttributedString(string: "12")
        favoriteCount.textColor = .nanuriGray3
        favoriteCount.font = UIFont.systemFont(ofSize: 12)
        favoriteView.addSubview(favoriteCount)
        favoriteCount.snp.makeConstraints { make in
            make.top.equalTo(favoriteButton.snp.bottom).inset(-4)
            make.centerX.equalToSuperview()
        }
        
    }
    
    func setUpView() {
        
        let productDetailScrollView = UIScrollView()
        productDetailScrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - CGFloat(edgeHeight))
        productDetailScrollView.contentSize = CGSize(width: productDetailScrollView.frame.width, height: productDetailScrollView.frame.height)
        self.view.addSubview(productDetailScrollView)
        
        print(self.view.frame.width)
        print(productDetailScrollView.frame.width)
        
        let productImageView = UIView()
        productDetailScrollView.addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.width.height.equalTo(375)
        }
        
        let productImage = UIImageView()
        productImage.backgroundColor = .nanuriGray2
        productImageView.addSubview(productImage)
        productImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.width.height.equalToSuperview()
        }
        
        let productLinkButton = UIButton()
        productLinkButton.setAttributedTitle(NSAttributedString(string: "상품 링크 바로가기"), for: .normal)
        productLinkButton.setImage(UIImage(named: "link_ic"), for: .normal)
        productLinkButton.layer.borderWidth = 1
        productLinkButton.backgroundColor = .white
        productLinkButton.layer.borderColor = UIColor.nanuriGreen.cgColor
        productLinkButton.layer.cornerRadius = 36 / 2
        productLinkButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        productLinkButton.setTitleColor(.nanuriGreen, for: .normal)
        productImageView.addSubview(productLinkButton)
        productLinkButton.snp.makeConstraints { make in
            make.bottom.equalTo(productImage.snp.bottom).inset(22)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(36)
            make.width.equalTo(158)
        }
        
        let categoryLabel = UILabel()
        categoryLabel.attributedText = NSAttributedString(string: "#생활용품")
        categoryLabel.font = UIFont.systemFont(ofSize: 13)
        categoryLabel.textColor = .nanuriGreen
        productDetailScrollView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).inset(-24)
            make.left.equalToSuperview().inset(16)
        }
        
        let dDayTagView = DDayTagView(dDay: "365")
        productDetailScrollView.addSubview(dDayTagView)
        dDayTagView.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).inset(-24)
            make.right.equalToSuperview().inset(16)
        }
        
        let deliveryTagView = DeliveryTagView(type: .delivery)
        productDetailScrollView.addSubview(deliveryTagView)
        deliveryTagView.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).inset(-24)
            make.right.equalTo(dDayTagView.snp.left).inset(-4)
        }
        
        let productName = UILabel()
        productName.attributedText = NSAttributedString(string: "로스팅 원두")
        productName.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        productDetailScrollView.addSubview(productName)
        productName.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).inset(-8)
            make.left.right.equalToSuperview().inset(16)
        }
        
        let purchaseDate = UILabel()
        purchaseDate.attributedText = NSAttributedString(string: "2022.03.02 - 2022.03.25")
        purchaseDate.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        purchaseDate.textColor = .nanuriGray4
        productDetailScrollView.addSubview(purchaseDate)
        purchaseDate.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom).inset(-8)
            make.left.equalToSuperview().inset(16)
        }
        
        let productPrice = UILabel()
        productPrice.attributedText = NSAttributedString(string: "3,500원")
        productPrice.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        productDetailScrollView.addSubview(productPrice)
        productPrice.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom)
            make.right.equalToSuperview().inset(16)
        }
        
        let participantImageView = UIImageView()
        participantImageView.image = UIImage(named: "people_ic")
        productDetailScrollView.addSubview(participantImageView)
        participantImageView.snp.makeConstraints { make in
            make.top.equalTo(purchaseDate.snp.bottom).inset(-12)
            make.left.equalToSuperview().inset(16)
        }
        
        let productParticipant = UILabel()
        productParticipant.attributedText = NSAttributedString(string: "2")
        productParticipant.font = UIFont.systemFont(ofSize: 12)
        productParticipant.textColor = .nanuriOrange
        productDetailScrollView.addSubview(productParticipant)
        productParticipant.snp.makeConstraints { make in
            make.top.equalTo(purchaseDate.snp.bottom).inset(-13)
            make.left.equalTo(participantImageView.snp.right).inset(-6)
        }
        
        let totalRecruit = UILabel()
        totalRecruit.attributedText = NSAttributedString(string: "/ 5")
        totalRecruit.font = UIFont.systemFont(ofSize: 12)
        totalRecruit.textColor = .nanuriGray4
        productDetailScrollView.addSubview(totalRecruit)
        totalRecruit.snp.makeConstraints { make in
            make.top.equalTo(purchaseDate.snp.bottom).inset(-13)
            make.left.equalTo(productParticipant.snp.right).inset(-2)
        }
        
        let participantProgress = UIProgressView()
        participantProgress.progressViewStyle = .default
        participantProgress.progressTintColor = .nanuriGray3
        participantProgress.trackTintColor = .nanuriGray1
        participantProgress.progress = 0.5
        productDetailScrollView.addSubview(participantProgress)
        participantProgress.snp.makeConstraints { make in
            make.top.equalTo(participantImageView.snp.bottom).inset(-4)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(8)
        }
        
        let progress = UILabel()
        progress.attributedText = NSAttributedString(string: "\(Int(participantProgress.progress * 100))%")
        progress.textColor = .nanuriGray4
        progress.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        productDetailScrollView.addSubview(progress)
        progress.snp.makeConstraints { make in
            make.top.equalTo(productPrice.snp.bottom).inset(-16)
            make.right.equalToSuperview().inset(16)
            make.bottom.equalTo(participantProgress.snp.top).inset(-4)
        }
        
        let separateView = UIView()
        separateView.backgroundColor = .nanuriGray2
        productDetailScrollView.addSubview(separateView)
        separateView.snp.makeConstraints { make in
            make.top.equalTo(participantProgress.snp.bottom).inset(-16)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        let locationTagView = LocationTagView(location: "서울시 강남구")
        productDetailScrollView.addSubview(locationTagView)
        locationTagView.snp.makeConstraints { make in
            make.top.equalTo(separateView.snp.bottom).inset(-24)
            make.left.equalToSuperview().inset(16)
        }
        
        let userLevelView = UIView()
        productDetailScrollView.addSubview(userLevelView)
        
        let level = LevelView(.flower)
        userLevelView.addSubview(level)
        level.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        let user = UILabel()
        user.attributedText = NSAttributedString(string: "프로자취러")
        user.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        userLevelView.addSubview(user)
        user.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalTo(level.snp.left).inset(4)
            make.centerY.equalToSuperview()
        }
        
        userLevelView.snp.makeConstraints { make in
            make.top.equalTo(separateView.snp.bottom).inset(-24)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(17)
        }
        
        let contents = UITextView()
        contents.attributedText = NSAttributedString(string: """
    로스팅 원두 배송합니다!\n
    코스트코에서 사올 예정이고 1인당 1개씩만 주문 가능합니다!\n
    \n
    가격은 배송비 포함해서 + 1000원이구요\n
    주문주실 때 주소 적어주세요!\n
    로스팅 원두 배송합니다!\n
    코스트코에서 사올 예정이고 1인당 1개씩만 주문 가능합니다!\n
    \n
    가격은 배송비 포함해서 + 1000원이구요\n
    주문주실 때 주소 적어주세요!\n
    로스팅 원두 배송합니다!\n
    코스트코에서 사올 예정이고 1인당 1개씩만 주문 가능합니다!\n
    \n
    가격은 배송비 포함해서 + 1000원이구요\n
    주문주실 때 주소 적어주세요!\n
""")
        productDetailScrollView.addSubview(contents)
        contents.isEditable = false
        contents.isScrollEnabled = false
        contents.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        contents.font = UIFont.systemFont(ofSize: 12)
        
        let contensViewHeight = bottomViewHeight + 20
        
        contents.snp.makeConstraints { make in
            make.top.equalTo(locationTagView.snp.bottom).inset(-24)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(contensViewHeight)
        }
        
    }

}
