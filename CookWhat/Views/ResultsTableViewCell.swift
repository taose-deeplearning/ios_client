//
//  ResultsTableViewCell.swift
//  CookWhat
//
//  Created by tsugita on 2017/01/15.
//  Copyright © 2017年 taose-deeplearning. All rights reserved.
//

import UIKit
import SDWebImage

class ResultsTableViewCell: UITableViewCell {

    static let nibName = "ResultsTableViewCell"
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
    }

    fileprivate func setupViews() {

    }
    
    func assignRecipeAttributes(recipe: Recipe) {
        recipeImageView.sd_setImage(with: URL(string: recipe.mediumImageUrl))
        titleLabel.text = recipe.title
        descriptionLabel.text = recipe.recipeDescription
    }

}
