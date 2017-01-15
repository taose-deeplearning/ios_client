//
//  CameraView.swift
//  CookWhat
//
//  Created by tsugita on 2017/01/15.
//  Copyright © 2017年 taose-deeplearning. All rights reserved.
//

import UIKit
import CMPopTipView

class CameraView: UIView {

    var captureButton: UIButton!
    var backButton: UIButton!
    var searchButton: UIButton!
    var previewView: UIView!
    var footerView: UIView!
    
    var captureTipView: CMPopTipView?
    var searchTipView: CMPopTipView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupViews()
        setupTipViews()
    }
    
    fileprivate func setupViews() {
        self.backgroundColor = UIColor.black

        self.previewView = UIView(frame: frame)
        
        self.captureButton = UIButton()
        self.captureButton.layer.masksToBounds = true
        self.captureButton.setBackgroundImage(UIImage(named: "icon_camera_button")!, for: .normal)
        
        self.backButton = UIButton()
        self.backButton.layer.masksToBounds = true
        self.backButton.setBackgroundImage(UIImage(named: "back_button")!, for: .normal)
        
        self.searchButton = UIButton()
        self.searchButton.layer.masksToBounds = true
        self.searchButton.setBackgroundImage(UIImage(named: "search_button")!, for: .normal)
        
        self.footerView = UIView(frame: frame)
        self.footerView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        self.addSubview(self.previewView)
        self.footerView.addSubview(self.captureButton)
        self.footerView.addSubview(self.backButton)
        self.footerView.addSubview(self.searchButton)
        self.addSubview(self.footerView)
        
    }
    
    fileprivate func setupTipViews() {
        self.captureTipView = CMPopTipView(message: "複数枚撮影できます")
        self.captureTipView!.backgroundColor = Style.themeOrange
        self.captureTipView!.textColor = .white
        self.captureTipView!.preferredPointDirection = .down
        self.captureTipView!.hasGradientBackground = false
        self.captureTipView!.has3DStyle = false
        self.captureTipView!.borderWidth = 0

        self.searchTipView = CMPopTipView(message: "撮影が終わったら検索")
        self.searchTipView!.backgroundColor = Style.themeOrange
        self.searchTipView!.textColor = .white
        self.searchTipView!.preferredPointDirection = .down
        self.searchTipView!.hasGradientBackground = false
        self.searchTipView!.has3DStyle = false
        self.searchTipView!.borderWidth = 0

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let footerHeight: CGFloat = 80
        self.footerView.frame = CGRect(x: 0, y: self.frame.height - footerHeight, width: self.frame.width, height: footerHeight)
        
        self.backButton.frame.size = CGSize(width: 30, height: 30)
        self.backButton.center = CGPoint(x: 30, y: self.footerView.bounds.midY)

        self.searchButton.frame.size = CGSize(width: 35, height: 35)
        self.searchButton.center = CGPoint(x: self.footerView.bounds.width - 35, y: self.footerView.bounds.midY)

        self.captureButton.frame.size = CGSize(width: 60, height: 60)
        self.captureButton.center = CGPoint(x: self.footerView.bounds.midX, y: self.footerView.bounds.midY)
        
        self.previewView.frame = self.frame
    }
    

}
