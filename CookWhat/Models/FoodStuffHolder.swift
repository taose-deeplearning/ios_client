//
//  FoodStuffHolder.swift
//  CookWhat
//
//  Created by tsugita on 2017/01/18.
//  Copyright © 2017年 taose-deeplearning. All rights reserved.
//

import UIKit

class FoodStuffHolder: NSObject {

    var keywords = [String]()
    
    func getFoodKeywords(image: UIImage) {
        FoodRecognitionApiClient.sharedInstance.recognizeImage(image: image, completion: { json in
            if let foodsJson = json["foods"].array {
                for foodJson in foodsJson {
                    self.add(keyword: foodJson["name"].stringValue)
                }
            }
        })
    }
    
    func add(keyword: String) {
        guard !keywords.contains(keyword) else {
            return
        }
        
        keywords.append(keyword)
    }
 
    func toQueryValue() -> String {
        return keywords.joined(separator: ",")
    }
    
}
