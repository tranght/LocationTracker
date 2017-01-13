//
//  EditProfileViewController.swift
//  LocationTracker
//
//  Created by Hoang Thu Trang on 8/31/16.
//  Copyright © 2016 Hoang Thu Trang. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class EditProfileViewController: UIViewController {
    

    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillProfile()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fillProfile()  {
        txtUserName.text = AppController.sharedProfile.name
        txtEmail.text = AppController.sharedProfile.email
        txtPhone.text = AppController.sharedProfile.phoneNum
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnSavePressed(sender: AnyObject) {
        let withDeviceId = Utils.getDeviceId()
        
        Alamofire.request(.POST, "http://localhost:3000/api/user/update/", parameters: [ "username": txtUserName.text!, "email": txtEmail.text!, "phonenumber": txtPhone.text!, "deviceid": withDeviceId])
            .responseJSON { response in
                //statusCode = (response.response?.statusCode)! //Gets HTTP status code, useful for debugging
                if let value: AnyObject = response.result.value as? [String: AnyObject] {
                    //Handle the results as JSON
                    let post = JSON(value)
                    let results = post["status"].stringValue
                    if results == "success"{
                        AppController.sharedProfile.name = self.txtUserName.text!
                        AppController.sharedProfile.email = self.txtEmail.text!
                        AppController.sharedProfile.phoneNum = self.txtPhone.text!
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
