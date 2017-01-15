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

    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var indicationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViews()
    }

    fileprivate func setupViews() {
        backgroundColor = Style.backgroundOrange
        
        wrapperView.layer.cornerRadius = 6
        recipeImageView.layer.cornerRadius = 6
        recipeImageView.clipsToBounds = true
        
        wrapperView.layer.shadowOffset = CGSize(width: 0, height: 1)
        wrapperView.layer.shadowRadius = 1
        wrapperView.layer.shadowOpacity = 0.2
    }
    
    func assignRecipeAttributes(recipe: Recipe) {
        recipeImageView.sd_setImage(with: URL(string: recipe.mediumImageUrl)) { [weak self] image, error, cacheType, imageUrl in
            if cacheType == SDImageCacheType.none {
                self?.recipeImageView.alpha = 0
                UIView.animate(withDuration: 0.3, animations: {
                    self?.recipeImageView.alpha = 1
                })
            } else {
                self?.recipeImageView.alpha = 1
            }
        }
        
        titleLabel.text = recipe.title
        descriptionLabel.text = recipe.recipeDescription
        indicationLabel.text = recipe.indication
        costLabel.text = recipe.cost
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let opacityAnimation = CABasicAnimation(keyPath: "shadowOpacity")
        let radiusAnimation = CABasicAnimation(keyPath: "shadowRadius")
        opacityAnimation.duration = 0.1
        radiusAnimation.duration = 0.1

        if (highlighted) {
            opacityAnimation.fromValue = 0.2
            opacityAnimation.toValue = 0.4
            wrapperView.layer.add(opacityAnimation, forKey: "shadowOpacity")
            wrapperView.layer.shadowOpacity = 0.4
            
            radiusAnimation.fromValue = 1
            radiusAnimation.toValue = 1.2
            wrapperView.layer.add(radiusAnimation, forKey: "shadowRadius")
            wrapperView.layer.shadowRadius = 1.2
        } else {
            opacityAnimation.fromValue = 0.4
            opacityAnimation.toValue = 0.2
            wrapperView.layer.add(opacityAnimation, forKey: "shadowOpacity")
            wrapperView.layer.shadowOpacity = 0.2
            
            radiusAnimation.fromValue = 1.2
            radiusAnimation.toValue = 1
            wrapperView.layer.add(radiusAnimation, forKey: "shadowRadius")
            wrapperView.layer.shadowRadius = 1
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        // do nothing
    }
    
}
