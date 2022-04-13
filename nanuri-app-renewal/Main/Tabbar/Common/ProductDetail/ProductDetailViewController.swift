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
    
    @objc func selectCommentButton() {
        presentCommentViewController()
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
    
    func presentCommentViewController() {
        let commentViewController = CommentViewController()
        commentViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(commentViewController, animated: true)
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
        purchaseButton.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: "공동 구매 참여하기", lineHeight: 18), for: .normal)
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
        commentButton.addTarget(self, action: #selector(selectCommentButton), for: .touchUpInside)

        
        let commentCount = UILabel()
        commentCount.attributedText = .attributeFont(font: .PRegular, size: 12, text: "0", lineHeight: 18)
        commentCount.textColor = .nanuriGray3
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
        favoriteCount.attributedText = .attributeFont(font: .PRegular, size: 12, text: "12", lineHeight: 18)
        favoriteCount.textColor = .nanuriGray3
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
        productLinkButton.setAttributedTitle(.attributeFont(font: .PRegular, size: 15, text: "상품 링크 바로가기", lineHeight: 18), for: .normal)
        productLinkButton.setImage(UIImage(named: "link_ic"), for: .normal)
        productLinkButton.layer.borderWidth = 1
        productLinkButton.backgroundColor = .white
        productLinkButton.layer.borderColor = UIColor.nanuriGreen.cgColor
        productLinkButton.layer.cornerRadius = 36 / 2
        productLinkButton.setTitleColor(.nanuriGreen, for: .normal)
        productImageView.addSubview(productLinkButton)
        productLinkButton.snp.makeConstraints { make in
            make.bottom.equalTo(productImage.snp.bottom).inset(22)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(36)
            make.width.equalTo(158)
        }
        
        let categoryLabel = UILabel()
        categoryLabel.attributedText = .attributeFont(font: .NSRExtrabold, size: 13, text: "#생활용품", lineHeight: 14.76)
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
        productName.attributedText = .attributeFont(font: .PSemibold, size: 22, text: "로스팅 원두", lineHeight: 26)
        productDetailScrollView.addSubview(productName)
        productName.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).inset(-8)
            make.left.right.equalToSuperview().inset(16)
        }
        
        let purchaseDate = UILabel()
        purchaseDate.attributedText = .attributeFont(font: .PRegular, size: 13, text: "2022.03.02 - 2022.03.25", lineHeight: 15)
        purchaseDate.textColor = .nanuriGray4
        productDetailScrollView.addSubview(purchaseDate)
        purchaseDate.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom).inset(-8)
            make.left.equalToSuperview().inset(16)
        }
        
        let productPrice = UILabel()
        productPrice.attributedText = .attributeFont(font: .PBold, size: 18, text: "3,500원", lineHeight: 21.6)
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
        productParticipant.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "2", lineHeight: 13.62)
        productParticipant.textColor = .nanuriOrange
        productDetailScrollView.addSubview(productParticipant)
        productParticipant.snp.makeConstraints { make in
            make.top.equalTo(purchaseDate.snp.bottom).inset(-13)
            make.left.equalTo(participantImageView.snp.right).inset(-6)
        }
        
        let totalRecruit = UILabel()
        totalRecruit.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "/ 5", lineHeight: 13.62)
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
        progress.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "\(Int(participantProgress.progress * 100))%", lineHeight: 13.62)
        progress.textColor = .nanuriGray4
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
        user.attributedText = .attributeFont(font: .NSRExtrabold, size: 15, text: "프로자취러", lineHeight: 17.03)
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
        contents.attributedText = .attributeFont(font: .PRegular, size: 15, text: """
로스팅 원두 배송합니다!
코스트코에서 사올 예정이고 1인당 1개씩만 주문 가능합니다!

가격은 배송비 포함해서 + 1000원이구요
주문주실 때 주소 적어주세요!
로스팅 원두 배송합니다!
코스트코에서 사올 예정이고 1인당 1개씩만 주문 가능합니다!

가격은 배송비 포함해서 + 1000원이구요
주문주실 때 주소 적어주세요!
""", lineHeight: 22)
        productDetailScrollView.addSubview(contents)
        contents.isEditable = false
        contents.isScrollEnabled = false
//        contents.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let contensViewHeight = bottomViewHeight + 20
        
        contents.snp.makeConstraints { make in
            make.top.equalTo(locationTagView.snp.bottom).inset(-24)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(contensViewHeight)
        }
        
    }

}
