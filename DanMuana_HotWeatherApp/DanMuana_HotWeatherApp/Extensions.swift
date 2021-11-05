//
//  Extensions.swift
//  DanMuana_HotWeatherApp
//
//  Created by Dan Muana on 11/3/21.
//

import Foundation
import UIKit

extension UIColor {
    class func darkBlue() -> UIColor {
        return UIColor(red: 0.116, green: 0.122, blue: 0.589, alpha: 0.9)
    }
    
    class func darkRed() -> UIColor {
        return UIColor(red: 0.2, green: 0.002, blue: 0.002, alpha: 0.9)
    }
}

extension UILabel {
    // TAGS - 34404 | "ERROR Label tag" - 
    class func initLabelAtPosition(x: Int, y: Int) -> UILabel {
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: 320, height: 20))
        label.textColor = .darkRed()
        label.center = CGPoint(x: x, y: y)
        label.textAlignment = .center
        
        label.tag = 34404
        return label
    }
}
