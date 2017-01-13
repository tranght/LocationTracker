//
//  SideMenuTableView.swift
//  LocationTracker
//
//  Created by Hoang Thu Trang on 8/29/16.
//  Copyright © 2016 Hoang Thu Trang. All rights reserved.
//

import Foundation
import SideMenu

class SideMenuTableView: UITableViewController {
    
    let PROFILE_CELL_IDENDIFIER = "PROFILE_CELL_IDENDIFIER"
    
    lazy var leftMenu = [Menu]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "ProfileTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: PROFILE_CELL_IDENDIFIER)
        
        // Load the sample data.
        loadLeftMenu()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // this will be non-nil if a blur effect is applied
        guard tableView.backgroundView == nil else {
            return
        }

    }
    
    func loadLeftMenu() {
        let menu1 = Menu(name: "Edit your profile")!
        
        //let photo2 = UIImage(named: "meal2")!
        let menu2 = Menu(name: "Create group")!

        let menu3 = Menu(name: "Chat messages")!
        let menu4 = Menu(name: "Settings")!
        
        leftMenu += [menu1, menu2, menu3, menu4]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leftMenu.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(PROFILE_CELL_IDENDIFIER) as! ProfileTableViewCell
            
            return cell
        }

        // Table view cells are reused and should be dequeued using a cell identifier.
        let cell = tableView.dequeueReusableCellWithIdentifier("SideMenuTableViewCell", forIndexPath: indexPath) as! SideMenuTableViewCell
        
        // Fetches the appropriate meal for the data source layout.
        let menu = leftMenu[indexPath.row - 1]

        
            cell.nameLabel.text = menu.name
            return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 138.0
        }
        
        return 44.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 1 {
            self.performSegueWithIdentifier("showEditProfile", sender: nil)
        }
        if indexPath.row == 2 {
            self.performSegueWithIdentifier("createGroup", sender: nil)
        }
    }

}
