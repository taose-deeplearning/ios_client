//
//  ResultsViewController.swift
//  CookWhat
//
//  Created by tsugita on 2017/01/15.
//  Copyright © 2017年 taose-deeplearning. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var model: ResultsViewModel!
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
        setBind()
        model.recipeHolder.fetch()
    }

    // MARK: - Initialize
    
    fileprivate func setTableView() {
        tableView.delegate = self
        tableView.dataSource = model
        tableView.register(UINib(nibName: ResultsTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: model.cellIdentifier)
        tableView.tableFooterView = UIView() // To remove needless border lins
    }
    
    fileprivate func setBind() {
        _ = model.recipeHolder.recipes.observeNext { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = model.recipeHolder.recipes.value[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
