//
//  ViewController.swift
//  CookWhat
//
//  Created by tsugita on 2017/01/14.
//  Copyright © 2017年 taose-deeplearning. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {

    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindEvents()
    }
    
    // MARK: -  Initialize
    
    fileprivate func bindEvents() {
        let view = self.view as! TopView
        view.startButton.addTarget(self, action: #selector(TopViewController.didClickStartButton), for: .touchUpInside)
    }
    
    // MARK: - Callbacks
    
    func didClickStartButton() {
        let storyboard = UIStoryboard(name: "CameraViewController", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()!
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
}

