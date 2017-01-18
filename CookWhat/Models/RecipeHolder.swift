//
//  RecipeHolder.swift
//  CookWhat
//
//  Created by tsugita on 2017/01/15.
//  Copyright © 2017年 taose-deeplearning. All rights reserved.
//

import UIKit
import Bond

class RecipeHolder: NSObject {

    let foodStuffHolder: FoodStuffHolder
    let recipes = Observable<[Recipe]>([])
    
    var currentPage = 1
    let perPage = 30
    
    let isUpdating = Observable<Bool>(false)
    
    init(foodStuffHolder: FoodStuffHolder) {
        self.foodStuffHolder = foodStuffHolder
        
        super.init()
    }
    
    func fetch() {
        guard !isUpdating.value else { return }
        
        isUpdating.value = true
        
        let query = [
            "query": foodStuffHolder.toQueryValue(),
            "page": String(currentPage),
            "per": String(perPage)
        ]
        
        RecipeAPIClient.sharedInstance.getRecipes(query: query) { [weak self] json in
            self?.recipes.value += json.arrayValue.map { Recipe(json: $0) }
            self?.currentPage += 1
            self?.isUpdating.value = false
        }
    }
    
}
