//
//  ViewController.swift
//  LocationTracker
//
//  Created by Hoang Thu Trang on 8/13/16.
//  Copyright © 2016 Hoang Thu Trang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SideMenu
import CoreLocation
import GoogleMaps

class ViewController: UIViewController,  CLLocationManagerDelegate {
    
    lazy var service : UserService = UserService()
    let profile = Profile()
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var groupsTableview: UITableView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        self.locationManager.delegate = self
        //self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        // Set a movement threshold for new events.
        locationManager.distanceFilter = 50; // meters
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view, typically from a nib.
        // check user exist of not
        // check aceess_token exist -> yes: fetch user info, no: login
        // TODO: check access_token -> yes
        service.login(withDeviceId: Utils.getDeviceId()) { (result, error) in
            if (error == nil) {
                self.fetchUserInfo(result)
            } else {
                //TODO: handle error
            }
        }
        
        
    }
    
    func  locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let withDeviceId = Utils.getDeviceId()
        
        let camera = GMSCameraPosition.cameraWithLatitude(location!.coordinate.latitude, longitude: location!.coordinate.longitude, zoom: 15)
        self.mapView.camera = camera
        self.mapView.myLocationEnabled = true
        print(location!.coordinate.latitude, location!.coordinate.longitude)
        Alamofire.request(.POST, "http://localhost:3000/api/user/location/", parameters: [ "lat": location!.coordinate.latitude, "lon": location!.coordinate.longitude, "deviceid": withDeviceId])
            .responseJSON { response in
                //statusCode = (response.response?.statusCode)! //Gets HTTP status code, useful for debugging
                if let value: AnyObject = response.result.value as? [String: AnyObject] {
                    //Handle the results as JSON
                    let post = JSON(value)
                    let results = post["status"].stringValue
                    if results == "success"{
                        //success
                    }
                    return
                }
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors:" + error.localizedDescription)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func fetchUserInfo(result: JSON) {
        // TODO: call api to get user info
        self.profile.name = result["username"].stringValue
        self.profile.email = result["email"].stringValue
        self.profile.phoneNum = result["phone"].stringValue
        AppController.sharedProfile.name = self.profile.name
        AppController.sharedProfile.email = self.profile.email
        AppController.sharedProfile.phoneNum = self.profile.phoneNum
    }
    
    
    
    private func setupSideMenu() {
        
        let menuLeftNavigationController = UISideMenuNavigationController()
        menuLeftNavigationController.leftSide = true
        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration of it here like setting its viewControllers.
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        }
    
}

extension ViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10; // Temporary value
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell();
    }
}

extension ViewController : UITableViewDelegate {

}

