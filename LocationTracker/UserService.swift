//
//  UserService.swift
//  LocationTracker
//
//  Created by Hoang Thu Trang on 8/13/16.
//  Copyright © 2016 Hoang Thu Trang. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class UserService {
    func login(withDeviceId deviceId : String, completionHandler completion: (result: JSON, error: NSError?) -> Void) {
        
        Alamofire.request(.POST, "http://localhost:3000/api/user/", parameters: ["deviceid": deviceId])
            .responseJSON { response in
                //statusCode = (response.response?.statusCode)! //Gets HTTP status code, useful for debugging
                if let value: AnyObject = response.result.value as? [String: AnyObject] {
                    //Handle the results as JSON
                    let post = JSON(value)
                    let results = post["data"]
                    //let userid = results["userid"]
                    //print(userid)
                    //print(results)
                    completion(result: results,error: nil)
                    return
                }
        }
        
    }
}