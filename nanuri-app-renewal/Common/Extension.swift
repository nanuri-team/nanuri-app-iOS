//
//  Extension.swift
//  nanuri-app-renewal
//
//  Created by minimani on 2022/04/04.
//

import Foundation
import UIKit

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
  func addPadding() {
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
      self.leftView = paddingView
      self.leftViewMode = ViewMode.always
      self.rightView = paddingView
      self.rightViewMode = ViewMode.always
  }
}
