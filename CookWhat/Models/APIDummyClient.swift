//
//  APIDummyClient.swift
//  CookWhat
//
//  Created by tsugita on 2017/01/15.
//  Copyright © 2017年 taose-deeplearning. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

// Dummy class to test this app can show recipes correctly.
// in production, this app posts images and get recipes, so doesn't call this endpoint directly.
class APIDummyClient: NSObject {

    static let sharedInstance = APIDummyClient()
    
    let baseUrl = "http://54.238.208.56"
    let searchEndpoint = "/search"
    let querySample = ["query": "たまねぎ"]
    
    func getRecipes() {
        let url = URL(string: baseUrl + searchEndpoint)!
        
        Alamofire.request(url, method: HTTPMethod.get, parameters: querySample, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch (response.result) {
            case .success(let value):
                let json = JSON(value)
                print(json)
            case .failure(let error):
                // TODO: error handling
                print(error)
            }
        }
    }
    
}
