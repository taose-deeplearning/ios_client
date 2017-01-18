//
//  FoodStuffHolder.swift
//  CookWhat
//
//  Created by tsugita on 2017/01/18.
//  Copyright © 2017年 taose-deeplearning. All rights reserved.
//

import UIKit
import Bond

class FoodStuffHolder: NSObject {

    let keywords = Observable<[String]>([])
    
    func getFoodKeywords(image: UIImage) {
        FoodRecognitionApiClient.sharedInstance.recognizeImage(image: image, completion: { json in
            if let foodsJson = json["foods"].array {
                let keywords = foodsJson.map { $0["name"].stringValue }
                self.add(keywordAttributes: keywords)
            }
        })
    }
    
    func add(keywordAttributes: [String]) {
        let newKeywords = keywordAttributes.filter { keyword in
            !keywords.value.contains(keyword)
        }
        
        keywords.value += newKeywords
    }
 
    func toQueryValue() -> String {
        return keywords.value.joined(separator: ",")
    }
    
}
