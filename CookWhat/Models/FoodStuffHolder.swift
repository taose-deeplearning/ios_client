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
    let progress = Observable<Float>(0)
    var imageForProgress: UIImage?
    
    func getFoodKeywords(image: UIImage) {
        self.imageForProgress = image
        
        FoodRecognitionApiClient.sharedInstance.recognizeImage(image: image, completion: { json in
            if let foodsJson = json["foods"].array {
                let keywords = foodsJson.map { $0["name"].stringValue }
                self.add(keywordAttributes: keywords)
            }
            
            if self.imageForProgress == image {
                self.progress.value = 0
            }
        }, progressCallback: { p in
            if self.imageForProgress == image {
                self.progress.value = p
            }
        }, fail: {
            if self.imageForProgress == image {
                self.progress.value = 0
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
