//
//  Recipe.swift
//  CookWhat
//
//  Created by tsugita on 2017/01/15.
//  Copyright © 2017年 taose-deeplearning. All rights reserved.
//

import UIKit
import SwiftyJSON

class Recipe: NSObject {

    let title: String
    let url: String
    let mediumImageUrl: String
    let recipeDescription: String

    let indication: String
    let cost: String
    
    init(json: JSON) {
        self.title = json["title"].stringValue
        self.url = json["url"].stringValue
        self.mediumImageUrl = json["medium_image_url"].stringValue
        self.recipeDescription = json["description"].stringValue

        self.indication = json["indication"].stringValue
        self.cost = json["cost"].stringValue
        
        super.init()
    }
    
}
