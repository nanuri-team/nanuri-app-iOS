//
//  Extension.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import Foundation
import UIKit

import SDWebImage
import CoreLocation

extension UIColor {
    class var nanuriGreen: UIColor {
        // rgba(99, 178, 97, 1)
        return UIColor(red: 99.0 / 255.0, green: 178.0 / 255.0, blue: 97.0 / 255.0, alpha: 1)
    }

    class var nanuriLevelMint: UIColor {
        // rgba(133, 228, 205, 1)
        return UIColor(red: 133.0 / 255.0, green: 228.0 / 255.0, blue: 205.0 / 255.0, alpha: 1)
    }

    class var nanuriLevelGreen: UIColor {
        // rgba(173, 233, 112, 1)
        return UIColor(red: 173.0 / 255.0, green: 233.0 / 255.0, blue: 112.0 / 255.0, alpha: 1)
    }
    
    class var nanuriLightGreen: UIColor {
        // rgba(164, 225, 163, 0.2)
        return UIColor(red: 164.0 / 255.0, green: 225.0 / 255.0, blue: 163.0 / 255.0, alpha: 1)
    }
    
    class var nanuriDarkGreen: UIColor {
        // rgba(91, 121, 96, 1)
        return UIColor(red: 91.0 / 255.0, green: 121.0 / 255.0, blue: 96.0 / 255.0, alpha: 1)
    }
    
    class var nanuriBrown: UIColor {
        // rgba(200, 143, 143, 1)
        return UIColor(red: 200.0 / 255.0, green: 143.0 / 255.0, blue: 143.0 / 255.0, alpha: 1)
    }
    
    class var nanuriBlue: UIColor {
        // rgba(155, 179, 226, 1)
        return UIColor(red: 155.0 / 255.0, green: 179.0 / 255.0, blue: 226.0 / 255.0, alpha: 1)
    }
    
    class var nanuriGray8: UIColor {
        // rgba(217, 217, 217, 1)
        return UIColor(red: 217.0 / 255.0, green: 217.0 / 255.0, blue: 217.0 / 255.0, alpha: 1)
    }
    
    class var nanuriGray7: UIColor {
        // rgba(80, 81, 85, 1)
        return UIColor(red: 80.0 / 255.0, green: 81.0 / 255.0, blue: 85.0 / 255.0, alpha: 1)
    }
    
    class var nanuriGray6: UIColor {
        // rgba(109, 109, 113, 1)
        return UIColor(red: 109.0 / 255.0, green: 109.0 / 255.0, blue: 113.0 / 255.0, alpha: 1)
    }
    
    class var nanuriGray5: UIColor {
        // rgba(137, 137, 142, 1)
        return UIColor(red: 137.0 / 255.0, green: 137.0 / 255.0, blue: 142.0 / 255.0, alpha: 1)
    }
    
    class var nanuriGray4: UIColor {
        // rgba(162, 162, 167, 1)
        return UIColor(red: 162.0 / 255.0, green: 162.0 / 255.0, blue: 167.0 / 255.0, alpha: 1)
    }
    
    class var nanuriGray3: UIColor {
        // rgba(204, 205, 209, 1)
        return UIColor(red: 204.0 / 255.0, green: 205.0 / 255.0, blue: 209.0 / 255.0, alpha: 1)
    }
    
    class var nanuriGray2: UIColor {
        // rgba(232, 233, 235, 1)
        return UIColor(red: 232.0 / 255.0, green: 233.0 / 255.0, blue: 235.0 / 255.0, alpha: 1)
    }
    
    class var nanuriGray1: UIColor {
        // rgba(250, 250, 252, 1)
        return UIColor(red: 250.0 / 255.0, green: 250.0 / 255.0, blue: 252.0 / 255.0, alpha: 1)
    }
    
    class var nanuriOrange: UIColor {
        // rgba(255, 158, 86, 1)
        return UIColor(red: 255.0 / 255.0, green: 158.0 / 255.0, blue: 86.0 / 255.0, alpha: 1)
    }

    class var nanuriLevelOrange: UIColor {
        // rgba(243, 198, 110, 1)
        return UIColor(red: 243.0 / 255.0, green: 198.0 / 255.0, blue: 110.0 / 255.0, alpha: 1)
    }

    class var nanuriYellow: UIColor {
        // rgba(241, 235, 96, 1)
        return UIColor(red: 241.0 / 255.0, green: 235.0 / 255.0, blue: 96.0 / 255.0, alpha: 1)
    }
    
    class var nanuriRed: UIColor {
        // rgba(255, 59, 48, 1)
        return UIColor(red: 255.0 / 255.0, green: 59.0 / 255.0, blue: 48.0 / 255.0, alpha: 1)
    }
    
    class var nanuriBlack1: UIColor {
        // rgba(54, 55, 59, 1)
        return UIColor(red: 54.0 / 255.0, green: 55.0 / 255.0, blue: 59.0 / 255.0, alpha: 1)
    }
}

extension UIView {
    func statusbarView(rootView: UIView) {
        if #available(iOS 13.0, *) {
            let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = .white
            rootView.addSubview(statusbarView)
            rootView.bringSubviewToFront(statusbarView)
            
            statusbarView.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
                make.height.equalTo(statusBarHeight)
            }
          
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = .white
        }
    }
}

extension UITextField {
    func addPadding(width: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
        self.rightView = paddingView
        self.rightViewMode = ViewMode.always
    }
    
    func toStyledTextField(_ textField: UITextField) {
        textField.borderStyle = .line
        textField.clipsToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.nanuriGray2.cgColor
        textField.layer.cornerRadius = 4
    }
}

enum NanuriFontType {
    // nanumSquareRound
    case NSRBold
    case NSRExtrabold
    
    // Pretendard
    case PRegular
    case PMedium
    case PSemibold
    case PBold
}


extension NSAttributedString {
    class func attributeFont(font: NanuriFontType, size: CGFloat, text: String, lineHeight: CGFloat) -> NSAttributedString {
        
        let attrString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        
        if #available(iOS 14.0, *) {
            paragraphStyle.lineBreakStrategy = .hangulWordPriority
        } else {
            paragraphStyle.lineBreakStrategy = .pushOut
        }
        
        var setFont = UIFont()
        switch font {
        case .NSRBold:
            setFont = UIFont(name: "NanumSquareRoundB", size: size)!
        case .NSRExtrabold:
            setFont = UIFont(name: "NanumSquareRoundEB", size: size)!
        case .PRegular:
            setFont = UIFont(name: "Pretendard-Regular", size: size)!
        case .PMedium:
            setFont = UIFont(name: "Pretendard-Medium", size: size)!
        case .PSemibold:
            setFont = UIFont(name: "Pretendard-SemiBold", size: size)!
        case .PBold:
            setFont = UIFont(name: "Pretendard-Bold", size: size)!
        }
        
        paragraphStyle.lineSpacing = lineHeight - setFont.lineHeight
        
        attrString.addAttributes([
                    NSAttributedString.Key.paragraphStyle : paragraphStyle,
                    .font : setFont
                ], range: NSMakeRange(0, attrString.length))
        
        return attrString
    }
}

extension NSAttributedString {
    class func attributeFontStyle(font: NanuriFontType, size: CGFloat, text: String, lineHeight: CGFloat) -> NSAttributedString {
        
        let attrString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        
        if #available(iOS 14.0, *) {
            paragraphStyle.lineBreakStrategy = .hangulWordPriority
        } else {
            paragraphStyle.lineBreakStrategy = .pushOut
        }
        
        var setFont = UIFont()
        switch font {
        case .NSRBold:
            setFont = UIFont(name: "NanumSquareRoundB", size: size)!
        case .NSRExtrabold:
            setFont = UIFont(name: "NanumSquareRoundEB", size: size)!
        case .PRegular:
            setFont = UIFont(name: "Pretendard-Regular", size: size)!
        case .PMedium:
            setFont = UIFont(name: "Pretendard-Medium", size: size)!
        case .PSemibold:
            setFont = UIFont(name: "Pretendard-SemiBold", size: size)!
        case .PBold:
            setFont = UIFont(name: "Pretendard-Bold", size: size)!
        }
        
        paragraphStyle.lineSpacing = lineHeight - setFont.lineHeight
        
        attrString.addAttributes([
                    NSAttributedString.Key.paragraphStyle : paragraphStyle,
                    .font : setFont,
                    NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
                ], range: NSMakeRange(0, attrString.length))
        
        return attrString
    }
}

extension Int {
    func toCategoryName() -> String {
        switch self {
        case 0:
            return "SUPPLIES"
        case 1:
            return "FOOD"
        case 2:
            return "KITCHEN"
        case 3:
            return "BATH"
        case 4:
            return "STATIONERY"
        case 5:
            return "ETC"
        default:
            return "ETC"
        }
    }
    
    func toTradeTypeName() -> String {
        switch self {
        case 0:
            return "PARCEL"
        case 1:
            return "DIRECT"
        default:
            return ""
        }
    }
    
    func toPriceNumberFormmat() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(for: self)!
        
        return result
    }
}

enum FormatType: String {
    case dotAndDay = "yyyy.MM.dd (E)"
    case dahsed = "yyyy-MM-dd"
    case dot = "yyyy.MM.dd"
}

// 날짜 형식
extension DateFormatter {

    func changeDateFormat(_ date: Date, format: FormatType) -> String {
        self.locale = Locale(identifier: "ko")
        self.timeZone = TimeZone(abbreviation: "KST")
        self.dateFormat = format.rawValue
        
        return self.string(from: date)
    }
    
    func changeStringToDate(_ string: String, format: FormatType) -> Date {
        self.locale = Locale(identifier: "ko")
        self.timeZone = TimeZone(abbreviation: "KST")
        self.dateFormat = format.rawValue
        guard let date = self.date(from: string) else { return Date() }
        
        return date
    }
}

extension String {
    func replaceImageUrl() -> String {
        let index = self.firstIndex(of: "?") ?? self.endIndex
        let url = self[..<index]
        return String(url)
    }
    
    func slicePostUuid() -> String {
        let index = self.firstIndex(of: "-") ?? self.endIndex
        let uuid = self[..<index]
        return String(uuid)
    }
    
    func dDaycalculator() -> String {
        let date = DateFormatter().changeStringToDate(self, format: .dahsed)
        guard let dDay = Calendar.current.dateComponents([.day], from: Date(), to: date).day else { return "" }
        return "\(dDay + 1)"
    }
    
    func currentLocation(userInfo: UserInfo, completion: @escaping (String) -> ()) {
        let location = splitLocation(location: userInfo.location)
        let myLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        geocoder.reverseGeocodeLocation(myLocation, preferredLocale: locale) { (place, error) in
            guard let placemark = place?.last,
                  let administrativeArea = placemark.administrativeArea,
                  let subLocality = placemark.subLocality
            else { return }
            let currentLocation = "\(administrativeArea) \(subLocality)"
            completion(currentLocation)
        }
    }
}

extension UIImageView {
    func imageUpload(url: String) {
        self.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder.png"))
    }
}

extension UIButton {
    func alignTextBelow(spacing: CGFloat = 7.0) {
        guard let image = self.imageView?.image else {
            return
        }

        guard let titleLabel = self.titleLabel else {
            return
        }

        guard let titleText = titleLabel.text else {
            return
        }

        let titleSize = titleText.size(withAttributes: [
            NSAttributedString.Key.font: titleLabel.font as Any
        ])

        titleEdgeInsets = UIEdgeInsets(top: spacing, left: -image.size.width, bottom: -image.size.height, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
    }
    
    func imageWithText(image: UIImage?, text: String) {
        let buttonImage = UIImageView()
        buttonImage.image = image
        self.addSubview(buttonImage)
        buttonImage.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.height.equalTo(18)
        }
        
        let buttonText = UILabel()
        buttonText.attributedText = .attributeFont(font: .PMedium, size: 15, text: text, lineHeight: 18)
        self.addSubview(buttonText)
        buttonText.snp.makeConstraints { make in
            make.left.equalTo(buttonImage.snp.right).inset(-16)
        }
    }
}
