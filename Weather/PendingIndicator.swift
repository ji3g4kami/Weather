//
//  PendingIndicator.swift
//  Think
//
//  Created by udn on 2018/10/12.
//  Copyright © 2018 dengli. All rights reserved.
//

import UIKit

public final class PendingIndicator {
    
    static let container: UIView = UIView()
    static let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    
    public static func showActivityIndicatory(uiView: UIView) {
        DispatchQueue.main.async {
            container.frame = uiView.frame
            container.center = uiView.center
            container.backgroundColor = UIColorFromHex(0x000000, alpha: 0.3)
            
            let loadingView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            loadingView.center = uiView.center
            loadingView.backgroundColor = UIColorFromHex(0x444444, alpha: 0.7)
            loadingView.clipsToBounds = true
            loadingView.layer.cornerRadius = 10
            
            
            actInd.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            actInd.style =
                UIActivityIndicatorView.Style.whiteLarge
            actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
            loadingView.addSubview(actInd)
            container.addSubview(loadingView)
            uiView.addSubview(container)
            actInd.startAnimating()
        }
    }
    
    public static func hideActivityIndicator() {
        DispatchQueue.main.async {
            PendingIndicator.actInd.stopAnimating()
            PendingIndicator.container.removeFromSuperview()
        }
    }
    
    private static func UIColorFromHex(_ rgbValue: UInt32, alpha: Double = 1.0) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red: red, green: green, blue: blue, alpha: CGFloat(alpha))
    }
  
}
