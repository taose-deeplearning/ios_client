//
//  ResultsTableHeaderView.swift
//  CookWhat
//
//  Created by tsugita on 2017/01/16.
//  Copyright © 2017年 taose-deeplearning. All rights reserved.
//

import UIKit

class ResultsTableHeaderView: UIView {

    static let nibName = "ResultsTableHeaderView"
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        descriptionLabel.textColor = Style.accentBrown
    }
    
    func setDescription(foodStuffs: [String]) {
        descriptionLabel.text = "ある食材: \(foodStuffs.joined(separator: (", ")))"
    }
    
}
