//
//  CreateGroupTableViewCell.swift
//  LocationTracker
//
//  Created by Hoang Thu Trang on 11/13/16.
//  Copyright © 2016 Hoang Thu Trang. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class CreateGroupViewController: UIViewController {
    
    @IBOutlet weak var txtGroupName: UITextField!
    @IBOutlet weak var txtGroupDescription: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     @IBOutlet weak var btnAddPress: UIButton!
     */
    @IBAction func btnAddPress(sender: AnyObject) {
        let withDeviceId = Utils.getDeviceId()
        Alamofire.request(.POST, "http://localhost:3000/api/group", parameters: [ "groupname": txtGroupName.text!, "description": txtGroupDescription.text!, "usercreate": withDeviceId])
            .responseJSON { response in
                let statusCode = (response.response?.statusCode)! //Gets HTTP status code, useful for debugging
                print(statusCode)
                if let value: AnyObject = response.result.value as? [String: AnyObject] {
                    //Handle the results as JSON
                    let post = JSON(value)
                    let results = post["status"].stringValue
                    if results == "success"{
                        let alertController = UIAlertController(title: "Notice", message:
                            "Edit success!", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }
                    return
                }
        }
        
    }
    
}

