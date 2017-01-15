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

        setNavigationBar()
        setTableView()
        setBind()
        model.recipeHolder.fetch()
    }

    // MARK: - Initialize
    
    fileprivate func setNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "レシピ"
        titleLabel.font = UIFont(name: "HiraKakuProN-W6", size: 15)
        titleLabel.textColor = .white
        titleLabel.sizeToFit()

        navigationItem.titleView = titleLabel
    }
    
    fileprivate func setTableView() {
        tableView.delegate = self
        tableView.dataSource = model
        tableView.register(UINib(nibName: ResultsTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: model.cellIdentifier)
        tableView.tableFooterView = UIView() // To remove needless border lines
        tableView.backgroundColor = Style.backgroundOrange
        tableView.separatorColor = .clear
    }
    
    fileprivate func setBind() {
        _ = model.recipeHolder.recipes.observeNext { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = model.recipeHolder.recipes.value[indexPath.row]
        let webVC = WebViewController(navigationTitle: recipe.title, urlString: recipe.url)
        navigationController!.pushViewController(webVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
    
}
