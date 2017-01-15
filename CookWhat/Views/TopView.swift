//
//  TopView.swift
//  CookWhat
//
//  Created by tsugita on 2017/01/16.
//  Copyright © 2017年 taose-deeplearning. All rights reserved.
//

import UIKit

class TopView: UIView {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var effectView: UIVisualEffectView!
    var layerView: UIView!
    
    override func awakeFromNib() {
        setImage()
    }

    fileprivate func setImage() {
        backgroundImageView.image = UIImage(named: "cooking4.jpg")
        backgroundImageView.contentMode = .scaleAspectFill
        
        let blur = UIBlurEffect(style: .regular)
        effectView = UIVisualEffectView(effect: blur)
        effectView.alpha = 0.6
        
        layerView = UIView()
        layerView.backgroundColor = .black
        layerView.alpha = 0.2
        backgroundImageView.addSubview(effectView)
        backgroundImageView.addSubview(layerView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundImageView.frame = bounds
        effectView.frame = bounds
        layerView.frame = bounds
    }
    
}
