//
//  FoodRecognitionApiClient.swift
//  CookWhat
//
//  Created by tsugita on 2017/01/17.
//  Copyright © 2017年 taose-deeplearning. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FoodRecognitionApiClient: NSObject {

    static let sharedInstance = FoodRecognitionApiClient()
    
    let baseUrl = "https://predict-food-2017.herokuapp.com"
    let searchEndpoint = "/predictor/upload/"
    
    func recognizeImage(image: UIImage, completion: @escaping (JSON) -> ()) {
        let url = URL(string: baseUrl + searchEndpoint)!

        let imageData = UIImagePNGRepresentation(image)!
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "image_file")
            },
            to: url,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                    upload.responseJSON { res in
                        switch res.result {
                        case .success(let value):
                            guard let statusCode = res.response?.statusCode else {
                                print("error at \(#function) \(#line)")
                                return
                            }
                            
                            if (statusCode - 200) < 100 {
                                let json = JSON(value)
                                completion(json)
                            } else {
                                print("error at \(#function) \(#line)")
                            }
                            
                        case .failure(let error):
                            print("error at \(#function) \(#line)")
                            print(error)
                        }
                    }
                case .failure(let error):
                    print("error at \(#function) \(#line)")
                    print(error)
                    // TODO: add error handling with encoding
                }
            }
        )
    }

}
