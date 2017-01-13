//
//  AppController.swift
//  LocationTracker
//
//  Created by Hoang Thu Trang on 8/31/16.
//  Copyright © 2016 Hoang Thu Trang. All rights reserved.
//

import UIKit

class AppController{
    var name : String = ""
    var email : String = ""
    var phoneNum : String = ""
    class var sharedProfile: AppController {
        struct Static {
            static let instance = AppController()
        }
        return Static.instance
    }
    //static let sharedProfile = AppController()
    
    private init() {}
}

