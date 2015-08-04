//
//  FeedTableViewController.swift
//  crumbs
//
//  Created by Colin Kohli on 7/22/15.
//  Copyright (c) 2015 Colin Kohli. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData



class FeedTableViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    var hardData = HardCodedData()
    let locationManager = CLLocationManager()
    
  
    @IBOutlet weak var composeButton: UIBarButtonItem!
    var currentLocation:CLLocation? = CLLocation()
    
    
    
    var feedData: NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.sectionIndexColor = UIColor.blueColor()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        currentLocation = locationManager.location
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { ( placemarks, error) -> Void in
            if error != nil {
                println("Error" + error.localizedDescription)
                return
            }
            if placemarks.count > 0{
                let pm = placemarks[0] as! CLPlacemark
                self.displayLocationInfo(pm)
            }
            
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark){
        
        self.locationManager.stopUpdatingLocation()
        currentLocation = placemark.location
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error: " + error.localizedDescription)
        
    }
    
    let loginAlert = usernameSelect()
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        
        if PFUser.currentUser() == nil{
            
            self.presentViewController(loginAlert!, animated: true, completion: nil)
            
            composeButton.enabled = false
        }
        else{
            composeButton.enabled = true
        }
        
        
        
        
        self.getNearbyPosts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        
        return feedData.count
        
        
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("Feed Cell", forIndexPath: indexPath) as! UITableViewCell
            let post = self.feedData.objectAtIndex(indexPath.row) as! PFObject
            var postArr = post.objectForKey("text") as! [String]
            var text = postArr[0]
            cell.textLabel?.text = text
            var userArr = post.objectForKey("user") as! [String]
            var user = userArr[0]
            cell.detailTextLabel?.text = user
            
            return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "showPost"){
            //add latt and long data to post
            
            let vc = segue.destinationViewController as! ShownPostViewController
            let cell = sender as! UITableViewCell
            vc.receivedPostString = cell.textLabel!.text!
            vc.receivedUserString = cell.detailTextLabel!.text!
            
            
        }
        
        if (segue.identifier == "compose"){
            //add latt and long data to post
            let vc = segue.destinationViewController as! ComposerViewController
            vc.currentLocation = currentLocation
        }
        
        
    }
    
    func getNearbyPosts() {
        
        feedData.removeAllObjects()
        
        var feedDataGrab: PFQuery = PFQuery(className: "crumbPost")
        
        feedDataGrab.findObjectsInBackgroundWithBlock(
            { (objects: [AnyObject]?, error: NSError?) -> Void in
                if (error == nil){
                    if let objects = objects as? [PFObject]{
                        for object in objects{
                            self.feedData.addObject(object)
                            
                        }
                        
                        let myArray:NSArray = self.feedData.reverseObjectEnumerator().allObjects
                        self.feedData = NSMutableArray(array: myArray)
                        
                        if self.currentLocation != nil{
                            self.localizeFeedData()
                            self.tableView.reloadData()
                            return
                        }
                        else{
                            self.getNearbyPosts()
                        }
                        
                        
                        
                    }
                }})
        
    }
    
    func localizeFeedData(){
        var array: NSMutableArray = []
        if feedData.count == 0{
            return
        }
        for index in 0...(feedData.count-1){
            var lat = feedData[index].objectForKey("latitude")! as! [CLLocationDegrees]
            var long = feedData[index].objectForKey("longitude")! as! [CLLocationDegrees]
            println(lat[0])
            println(long[0])
            
            var location = CLLocation(latitude: lat[0], longitude: long[0])
            
            println(location.distanceFromLocation(currentLocation!))
            
            if location.distanceFromLocation(currentLocation!) < 10{
                array.addObject(feedData[index])
            }
        }
        feedData = array
        
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
