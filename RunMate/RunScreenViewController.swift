//
//  RunScreenViewController.swift
//  RunMate
//
//  Created by Julia Skrak on 2/5/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

class RunScreenViewController: UIViewController, CLLocationManagerDelegate, runScreenViewDelegate, runStatsDelegate {
    
    var runScreenView: RunScreenView
    var runHash: NSNumber
    var locationManager:CLLocationManager!
    var distance: CLLocationDistance
    var last: RunLocation
    
    
    required init(coder aDecoder: NSCoder) {
        runScreenView = RunScreenView()
        runHash = 0
        distance = -2
        last = RunLocation()
        last.distance = -2
        super.init(coder: aDecoder)!
    
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        runScreenView = RunScreenView()
        runHash = 0
        distance = 0
        last = RunLocation()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    

    func setApperance(){
        runScreenView = RunScreenView.init(frame: self.view.frame) //idk how to fix
        runScreenView.delegate = self
        self.view.addSubview(runScreenView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        print("distance isss \(distance)")
        //last.longitude = 0
        //last.latitude = 0
        print("last run location isss \(last.longitude), \(last.latitude)")
        last.distance = -2 //set it at -2, then it goes to -1 then it starts
        distance = -2
        setApperance()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]){
            for location in locations {
                if (location.horizontalAccuracy < 20) {
                    let savedLocation = RunLocation()
                    if(distance >= -1){
                        if(distance >= 0){
                            distance += location.distanceFromLocation(CLLocation(latitude: Double(last.latitude), longitude: Double(last.longitude)))
                        //print("distance isss \(distance) with \(Double(last.latitude)) as lat and \(Double(last.longitude)) as long  and a raw value of \(last.latitude) and \(last.longitude)")
                            savedLocation.distance = distance
                        } else {
                            distance = 0
                            savedLocation.distance = distance
                        }
                        self.runScreenView.speedLabel.text = String(location.speed)
                        savedLocation.speed = location.speed
                        savedLocation.userObjId = PFUser.currentUser()?.objectId
                        savedLocation.facebookUserId = FBSDKAccessToken.currentAccessToken().userID //not sure i need this but oh well
                        savedLocation.runHash = self.runHash
                        savedLocation.altitude = location.altitude
                        savedLocation.latitude = location.coordinate.latitude
                        savedLocation.longitude = location.coordinate.longitude
                        savedLocation.timestamp = location.timestamp.timeIntervalSince1970 //let date = NSDate(timeIntervalSince1970:timeStamp)
                        savedLocation.pinInBackgroundWithName("currentRun")
                    
                        last = savedLocation
                        
                        var query:PFQuery = PFUser.query()!
                        query.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId)!) {
                            (user: PFObject?, error: NSError?) -> Void in
                            if error != nil {
                                print(error)
                            } else if let user = user {
                                user["speed"] = location.speed
                                user.saveInBackground()
                            }
                        
                        }
                    } else {
                        distance = -1
                    }
                
                }
            }
    }
    
    func stopRun(testString: NSString){
        print(testString)
        finishRun()
    }
    
    func finishRun(){
        locationManager.stopUpdatingLocation()
        var query:PFQuery = PFUser.query()!
        query.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId)!) {
            (user: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let user = user {
                user["runNum"] = self.runHash
                user["speed"] = -1
                user.saveInBackground()
            }
        }
        
        var locationArray = [RunLocation]()
        
        let localQuery = PFQuery(className: "RunLocation")
        localQuery.fromPinWithName("currentRun")
        localQuery.findObjectsInBackground().continueWithBlock ({
            (task: BFTask!) -> AnyObject! in
            locationArray = (task.result as? [RunLocation])!
            PFObject.saveAllInBackground(locationArray)
            print("location array is: \(locationArray)")
            dispatch_async(dispatch_get_main_queue()) {
                self.displayData(locationArray)
            }
            return PFObject.unpinAllObjectsInBackgroundWithName("currentRun")
        })
    }

    
    func displayData(locationArray: [RunLocation]){
        let screenRect = UIScreen.mainScreen().bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        var runStatsView = RunStatsView.init(frame:  CGRect(x: 30, y: 30, width: screenWidth-60, height: screenHeight-60), setButton:true)
        runStatsView.opaque = false
        runStatsView.layer.cornerRadius = 15;
        self.view.backgroundColor = UIColor.whiteColor()
        runStatsView.delegate = self
        runStatsView.setStats(locationArray, runNum: runHash, distance: distance)
        self.view.addSubview(runStatsView)
    }
    
    func closeWindow(testString: NSString){
        print(testString)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
