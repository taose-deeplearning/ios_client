//
//  Style.swift
//  CookWhat
//
//  Created by tsugita on 2017/01/16.
//  Copyright © 2017年 taose-deeplearning. All rights reserved.
//

import UIKit

class Style: NSObject {

    static let themeOrange = UIColor(red: 255 / 255, green: 147 / 255, blue: 42 / 255, alpha: 1)
    static let backgroundOrange = UIColor(red: 248 / 255, green: 243 / 255, blue: 232 / 255, alpha: 1)
    
    static func setDefaultAppearance() {
        let navigationBar = UINavigationBar.appearance()
        navigationBar.backIndicatorImage = UIImage(named: "nav_back_button")
        navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "nav_back_button")
        
        navigationBar.tintColor = .white
        navigationBar.barTintColor = themeOrange
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        let barButtonItem = UIBarButtonItem.appearance()
        barButtonItem.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -100, vertical: -100), for: .default)
    }
        
}
