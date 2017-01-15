//
//  RecipeAPIClient.swift
//  CookWhat
//
//  Created by tsugita on 2017/01/15.
//  Copyright © 2017年 taose-deeplearning. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RecipeAPIClient: NSObject {

    static let sharedInstance = RecipeAPIClient()
    
    let baseUrl = "http://54.238.208.56"
    let searchEndpoint = "/search"
    
    func getRecipes(query: [String:String], completion: @escaping (JSON) -> ()) {
        let url = URL(string: baseUrl + searchEndpoint)!
        
        Alamofire.request(url, method: HTTPMethod.get, parameters: query, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch (response.result) {
            case .success(let value):
                let json = JSON(value)
                completion(json)
            case .failure(let error):
                // TODO: error handling
                print(error)
            }
        }
    }
    
}
