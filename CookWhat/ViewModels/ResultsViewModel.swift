//
//  ResultsViewModel.swift
//  CookWhat
//
//  Created by tsugita on 2017/01/15.
//  Copyright © 2017年 taose-deeplearning. All rights reserved.
//

import UIKit

class ResultsViewModel: NSObject, UITableViewDataSource {

    let cellIdentifier = "ResultsViewCell"
    let recipeHolder: RecipeHolder
    
    init(recipeHolder: RecipeHolder) {
        self.recipeHolder = recipeHolder
        
        super.init()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeHolder.recipes.value.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = recipeHolder.recipes.value[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ResultsTableViewCell
        cell.assignRecipeAttributes(recipe: recipe)
        return cell
    }
    
}
