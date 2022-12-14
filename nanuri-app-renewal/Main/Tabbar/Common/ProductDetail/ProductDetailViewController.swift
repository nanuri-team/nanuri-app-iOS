//
//  ProductDetailViewController.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/07.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    let purchaseButton = MainButton(style: .main)
    
    var bottomViewHeight = 64
    var edgeHeight = 34
    let ratioWidth = UIScreen.main.bounds.width / 375
    var postInfo: ResultInfo?
    var purcahsePosts: [ResultInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        extendedLayoutIncludesOpaqueBars = true
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
        let optionBottomSheetViewController = BottomSheetViewController(subView: OptionView())
        optionBottomSheetViewController.modalPresentationStyle = .overFullScreen
        self.present(optionBottomSheetViewController, animated: false, completion: nil)
    }
    
    @objc func selectCommentButton() {
        presentCommentViewController()
    }
    
    @objc func selectProductLinkButton() {
        guard let postInfo = postInfo else {
            return
        }

        if let url = URL(string: postInfo.productUrl) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    @objc func selectPurchaseButton() {
        purchaseButton.setStyle(style: .disable)
        purchaseButton.isEnabled = false
        purchaseButton.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: "이미 참여한 공동 구매 입니다!", lineHeight: 18), for: .normal)
        
    }
    
    func presentAlertViewController() {
        let contentView = UIView()
        
        let titleLabel = UILabel()
        titleLabel.attributedText = .attributeFont(font: .PBold, size: 20, text: "등록한 상품을\n정말 삭제하시겠습니까?", lineHeight: 24)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(44)
            make.centerX.equalToSuperview()
        }
        
        let reasonTextView = TextView()
        reasonTextView.layer.borderWidth = 1
        reasonTextView.layer.borderColor = UIColor.nanuriGray2.cgColor
        reasonTextView.layer.cornerRadius = 8
        reasonTextView.placeholder(text: "취소 사유를 작성해주세요.\n작성하신 사유는 참여자에게만 공개됩니다.\n(예: 상품 가격 변동, 상품 품절, 단순 변심)")
        contentView.addSubview(reasonTextView)
        reasonTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-24)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(165)
        }
        
        let alert = AlertViewController.init(contents: contentView, cancelString: "취소", okString: "삭제", okHandler: {
            self.presentDeleteCompleteAlertViewController()
        }, cancelHandler: nil)
        alert.present(self, alertView: alert, animated: false)
    }
    
    func presentDeleteCompleteAlertViewController() {
    
        let contentView = UIView()
        
        let titleLabel = UILabel()
        titleLabel.attributedText = .attributeFont(font: .PBold, size: 20, text: "등록한 상품이\n정상적으로 삭제되었습니다.", lineHeight: 24)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(44)
            make.centerX.equalToSuperview()
        }
        
        let alert = AlertViewController.init(contents: contentView, contentsViewHeight: 120, okString: "확인", okHandler: nil)
        alert.present(self, alertView: alert, animated: false)
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
        
        guard let postInfo = postInfo else {
            return
        }
        
       
        
        if postInfo.writer == "nanuriaws@gmail.com" {
            purchaseButton.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: "공동 구매 진행하기", lineHeight: 18), for: .normal)
        } else {
            purchaseButton.setAttributedTitle(.attributeFont(font: .PBold, size: 15, text: "공동 구매 참여하기", lineHeight: 18), for: .normal)
        }
        
        bottomView.addSubview(purchaseButton)
        purchaseButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(8)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.top.bottom.equalToSuperview().inset(8)
        }
        purchaseButton.addTarget(self, action: #selector(selectPurchaseButton), for: .touchUpInside)
        
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
        
        guard let postInfo = postInfo else {
            return
        }
        
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
            make.left.right.equalTo(self.view)
            make.width.height.equalTo(375)
        }
        
        let productImage = UIImageView()
        productImage.imageUpload(url: postInfo.image?.replaceImageUrl() ?? "")
        productImage.contentMode = .scaleToFill
        productImage.backgroundColor = .nanuriGray2
        productImageView.addSubview(productImage)
        productImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalTo(self.view)
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
        productLinkButton.addTarget(self, action: #selector(selectProductLinkButton), for: .touchUpInside)
        
        let categoryLabel = UILabel()
        categoryLabel.attributedText = .attributeFont(font: .NSRExtrabold, size: 13, text: "#\(postInfo.category ?? "")", lineHeight: 14.76)
        categoryLabel.textColor = .nanuriGreen
        productDetailScrollView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).inset(-24)
            make.left.equalToSuperview().inset(16)
        }
        
        let dDayTagView = DDayTagView()
        dDayTagView.setDday(dDay: postInfo.waitedUntil?.dDaycalculator() ?? "")
        productDetailScrollView.addSubview(dDayTagView)
        dDayTagView.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).inset(-24)
            make.right.equalTo(self.view).inset(16)
        }
        
        let deliveryTagView = DeliveryTagView()
        deliveryTagView.setDeliveryType(type: postInfo.tradeType ?? "")
        productDetailScrollView.addSubview(deliveryTagView)
        deliveryTagView.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).inset(-24)
            make.right.equalTo(dDayTagView.snp.left).inset(-4)
        }
        
        let productName = UILabel()
        productName.attributedText = .attributeFont(font: .PSemibold, size: 22, text: postInfo.title, lineHeight: 26)
        productDetailScrollView.addSubview(productName)
        productName.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).inset(-8)
            make.left.right.equalTo(self.view).inset(16)
        }
        
        let purchaseDate = UILabel()
        let waitedFromDate = DateFormatter().changeDateFormat(DateFormatter().changeStringToDate(postInfo.waitedFrom ?? "", format: .dahsed), format: .dot)
        let waitedUntilDate = DateFormatter().changeDateFormat(DateFormatter().changeStringToDate(postInfo.waitedUntil ?? "", format: .dahsed), format: .dot)
        purchaseDate.attributedText = .attributeFont(font: .PRegular, size: 13, text: "\(waitedFromDate) - \(waitedUntilDate)", lineHeight: 15)
        purchaseDate.textColor = .nanuriGray4
        productDetailScrollView.addSubview(purchaseDate)
        purchaseDate.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom).inset(-8)
            make.left.equalToSuperview().inset(16)
        }
        
        let productPrice = UILabel()
        productPrice.attributedText = .attributeFont(font: .PBold, size: 18, text: "\(postInfo.unitPrice.toPriceNumberFormmat())원", lineHeight: 21.6)
        productDetailScrollView.addSubview(productPrice)
        productPrice.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom)
            make.right.equalTo(self.view).inset(16)
        }
        
        let participantImageView = UIImageView()
        participantImageView.image = UIImage(named: "people_ic")
        productDetailScrollView.addSubview(participantImageView)
        participantImageView.snp.makeConstraints { make in
            make.top.equalTo(purchaseDate.snp.bottom).inset(-12)
            make.left.equalToSuperview().inset(16)
        }
        
        let productParticipant = UILabel()
        productParticipant.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "\(postInfo.numParticipants)", lineHeight: 13.62)
        productParticipant.textColor = .nanuriOrange
        productDetailScrollView.addSubview(productParticipant)
        productParticipant.snp.makeConstraints { make in
            make.top.equalTo(purchaseDate.snp.bottom).inset(-13)
            make.left.equalTo(participantImageView.snp.right).inset(-6)
        }
        
        let totalRecruit = UILabel()
        totalRecruit.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "/ \(postInfo.maxParticipants)", lineHeight: 13.62)
        totalRecruit.textColor = .nanuriGray4
        productDetailScrollView.addSubview(totalRecruit)
        totalRecruit.snp.makeConstraints { make in
            make.top.equalTo(purchaseDate.snp.bottom).inset(-13)
            make.left.equalTo(productParticipant.snp.right).inset(-2)
        }
        
        let percentage = Float(postInfo.numParticipants) / Float(postInfo.maxParticipants)
        
        let participantProgress = UIProgressView()
        participantProgress.progressViewStyle = .default
        participantProgress.progressTintColor = .nanuriGray3
        participantProgress.trackTintColor = .nanuriGray1
        participantProgress.progress = percentage
        productDetailScrollView.addSubview(participantProgress)
        participantProgress.snp.makeConstraints { make in
            make.top.equalTo(participantImageView.snp.bottom).inset(-4)
            make.left.right.equalTo(self.view).inset(16)
            make.height.equalTo(8)
        }
        
        let progress = UILabel()
        progress.attributedText = .attributeFont(font: .NSRExtrabold, size: 12, text: "\(Int(percentage * 100))%", lineHeight: 13.62)
        progress.textColor = .nanuriGray4
        productDetailScrollView.addSubview(progress)
        progress.snp.makeConstraints { make in
            make.top.equalTo(productPrice.snp.bottom).inset(-16)
            make.right.equalTo(self.view).inset(16)
            make.bottom.equalTo(participantProgress.snp.top).inset(-4)
        }
        
        let separateView = UIView()
        separateView.backgroundColor = .nanuriGray2
        productDetailScrollView.addSubview(separateView)
        separateView.snp.makeConstraints { make in
            make.top.equalTo(participantProgress.snp.bottom).inset(-16)
            make.left.right.equalTo(self.view)
            make.height.equalTo(1)
        }
        
        let locationTagView = LocationTagView(location: postInfo.writerAddress ?? "")
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
        user.attributedText = .attributeFont(font: .NSRExtrabold, size: 15, text: postInfo.writerNickname ?? "", lineHeight: 17.03)
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
        contents.typingAttributes = [
                   .font : UIFont(name: "Pretendard-Regular", size: 15)!,
                   .kern : -0.3,
                   .foregroundColor: UIColor.black,
               ]
        productDetailScrollView.addSubview(contents)
        contents.text = postInfo.description
        contents.isEditable = false
        contents.isScrollEnabled = false
//        contents.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let contensViewHeight = bottomViewHeight + 20
        
        contents.snp.makeConstraints { make in
            make.top.equalTo(locationTagView.snp.bottom).inset(-24)
            make.left.right.equalTo(self.view).inset(16)
            make.height.equalTo(contents.contentSize.height)
            make.bottom.equalToSuperview()
//            make.bottom.equalToSuperview().inset(contensViewHeight)
        }
        
    }

}
