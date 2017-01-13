//
//  Utils.swift
//  LocationTracker
//
//  Created by Hoang Thu Trang on 8/13/16.
//  Copyright © 2016 Hoang Thu Trang. All rights reserved.
//

import Foundation
import UIKit
import Locksmith
import Alamofire


class Utils {
    static func getDeviceId() -> String {
        let appName = NSBundle.mainBundle().infoDictionary![String(kCFBundleNameKey)] as! String
        var strAppUUID : String?
        if let data = Locksmith.loadDataForUserAccount("tranght", inService: appName) {
            strAppUUID = data["deviceId"] as? String
        }
        if strAppUUID == nil {
            strAppUUID = UIDevice.currentDevice().identifierForVendor?.UUIDString
            
            //try Locksmith.saveData(["some key": "some value"], forUserAccount: "myUserAccount")
            do {
                try Locksmith.saveData(["deviceId" : strAppUUID!], forUserAccount: "tranght", inService: appName)
             } catch {
                print("error in get deviceID: \(error)")
            }
        }
        //print(strAppUUID)
        return strAppUUID!
    }
    
    
}