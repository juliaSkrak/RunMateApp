//
//  RunScreenViewController.swift
//  RunMate
//
//  Created by Julia Skrak on 2/5/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit
import MapKit

//TODO: TURN OFF TIMER WHEN RUN IS  FINISHED

class RunScreenViewController: UIViewController, CLLocationManagerDelegate, runScreenViewDelegate, runStatsDelegate {
    
    var runScreenView: RunScreenView
    var runHash: NSNumber
    var locationManager:CLLocationManager!
    var distance: CLLocationDistance
    var last: RunLocation
    var startTime: NSTimeInterval
    var timerClock: NSTimer
    var timerCoord: NSTimer
    var timerRunWithFriend: NSTimer
    var timer: NSTimer
    var runWithFriendId : String
    var runStatsView: RunStatsView

    required init(coder aDecoder: NSCoder) {
        runScreenView = RunScreenView()
        runHash = 0
        distance = -2
        last = RunLocation()
        last.distance = -2
        startTime = NSTimeInterval.init()
        timer = NSTimer.init()
        timerClock = NSTimer.init()
        timerCoord = NSTimer.init()
        timerRunWithFriend = NSTimer.init()
        runWithFriendId = ""
        runStatsView = RunStatsView.init()
        super.init(coder: aDecoder)!
    
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        runScreenView = RunScreenView()
        runHash = 0
        distance = 0
        last = RunLocation()
        startTime = NSTimeInterval.init()
        timer = NSTimer.init()
        timerClock = NSTimer.init()
        timerCoord = NSTimer.init()
        timerRunWithFriend = NSTimer.init()
        runWithFriendId = ""
        runStatsView = RunStatsView.init()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(friendObj friend : PFUser){
        self.init(nibName: nil, bundle:nil)
        runWithFriendId = friend.objectId!
    }
    
    convenience init(friend friendId : String){
        self.init(nibName: nil, bundle:nil)
        runWithFriendId = friendId
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
        
        timerClock = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updateTime", userInfo: nil, repeats: true)
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "updateRunStats", userInfo: nil, repeats: true)
        timerCoord = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "updateMapCoords", userInfo: nil, repeats: true)

        if(!runWithFriendId.isEmpty){
            timerRunWithFriend = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "updateFriendSpeed", userInfo: nil, repeats: true)
        }
        
        startTime = NSDate.timeIntervalSinceReferenceDate()
        
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
                            savedLocation.distance = distance / 1609.344
                        } else {
                            distance = 0
                            savedLocation.distance = distance
                        }
                        if(last.longitude != nil){
                            drawMyLine(location.coordinate)
                        }
                        self.runScreenView.speedLabel.text = String(location.speed)
                        let convertedSpeed = location.speed *  3600 / 1609.344
                        savedLocation.speed = convertedSpeed//location.speed
                        savedLocation.userObjId = PFUser.currentUser()?.objectId
                        savedLocation.facebookUserId = FBSDKAccessToken.currentAccessToken().userID
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
        timerClock.invalidate()
        timer.invalidate()
        timerCoord.invalidate()
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
                user["totalDistance"] = user["totalDistance"] as! Double + (self.distance / 1609.34)
                var currentTime = NSDate.timeIntervalSinceReferenceDate()
                var elapsedTime = currentTime - self.startTime
                let minutes = UInt8(elapsedTime / 60.0)
                user["mph"] = (self.distance / 1609.34) / (elapsedTime / 3600)
                user.saveInBackground()
            }
        }
        
        var locationArray = [RunLocation]()
        let localQuery = PFQuery(className: "RunLocation")
        localQuery.fromPinWithName("currentRun")
        localQuery.findObjectsInBackground().continueWithBlock ({
            (task: BFTask!) -> AnyObject! in
            locationArray = (task.result as? [RunLocation])!
            PFObject.saveAllInBackground(locationArray, block: { (Bool, error: NSError?) -> Void in
                self.createRunObject(locationArray)
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.displayData(locationArray)
                }
            
            })
            return PFObject.unpinAllObjectsInBackgroundWithName("currentRun")
        })
    }

    
    func createRunObject(locations: [RunLocation]){
        var run = Run.init()
        run.user = locations.first?.userObjId
      var formatter = NSDateFormatter()
        //run.runlocations = [String].init()
        run.ACL = PFACL(user: PFUser.currentUser()!)
        run.distance = distance / 1609.34
        var runLocations = [String]()
        for location: RunLocation in locations {
            runLocations.append(location.objectId!)
        }
        run.runlocations = runLocations
        run.saveInBackgroundWithBlock {
            (success: Bool?, error: NSError?) -> Void in
            if (success != nil) {
                let urlPath: String = "https://sleepy-brook-69357.herokuapp.com/checkTrophies?userId=" + PFUser.currentUser()!.objectId! + "&runId=" + run.objectId!
                print(urlPath)
                var url: NSURL = NSURL(string: urlPath)!
                var request1: NSURLRequest = NSURLRequest(URL: url)
                let queue:NSOperationQueue = NSOperationQueue()
                NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                    var err: NSError
                    do {
                        let object:AnyObject? = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                        if let dictionaryObject = object!["error"]{
                            dispatch_async(dispatch_get_main_queue()) {
                                self.updateTrophies("Awe shucks no trophies earned on this run!")
                            }
                        } else {
                            self.updateTrophies("Check your trophy case for updated trophies!!")
                        }
                    } catch let caught as ErrorType {
                    }
                })
            } else {
                print(error)
            }
        }
    }
    
    func displayData(locationArray: [RunLocation]){
        let screenRect = UIScreen.mainScreen().bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        runStatsView = RunStatsView.init(frame:  CGRect(x: 30, y: 30, width: screenWidth-60, height: screenHeight-60), setButton:true)
        runStatsView.opaque = false
        runStatsView.layer.cornerRadius = 15;
        self.view.backgroundColor = UIColor.whiteColor()
        runStatsView.delegate = self
        runStatsView.setStats(locationArray, runNum: runHash, distance: distance)
        self.view.addSubview(runStatsView)
    }
    
    func updateTrophies(text: String){
        runStatsView.trophyList.text = text
    }
    
    func closeWindow(testString: NSString){
        print(testString)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    func drawMyLine(pointB: CLLocationCoordinate2D){
        let pointA = CLLocationCoordinate2D(latitude: last.latitude.doubleValue, longitude: last.longitude.doubleValue)
        print("printing last for fun \(pointA)")
        var lineBetween = [MKMapPointForCoordinate(pointA), MKMapPointForCoordinate(pointB)]
        // var myPoint = UnsafeMutablePointer<MKMapPoint>()
        //myPoint = &lineBetween.first
        let segment = MKPolyline(points: &lineBetween, count: 2)
        runScreenView.userRouteMapView.addOverlays([segment])
    }
    
    func updateTime(){
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
       
        var elapsedTime = currentTime - startTime
         print(elapsedTime)
        let minutes = floor(elapsedTime / 60.0)
        elapsedTime = round(elapsedTime - minutes * 60.0)
        let seconds = Int(round(elapsedTime))
        self.runScreenView.currentRunStatsView.displayTimeText(minutes : String(Int(minutes)), seconds: String(seconds))
        
    }
    
    func updateRunStats(){
        self.runScreenView.currentRunStatsView.displayRunStats(last)
    }
    
    func updateMapCoords(){
        if(last.latitude != nil && last.longitude != nil){
            var coord = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: Double(last.latitude),
                    longitude: Double(last.longitude)),
                span: MKCoordinateSpan(latitudeDelta: 0.0001,
                    longitudeDelta: 0.0001))
            self.runScreenView.setMapCoordinates(coord)
        }
    }
    
    func updateFriendSpeed(){
    /*    var query:PFQuery = PFUser.query()!
        query.getObjectInBackgroundWithId(runWithFriendId) {
            (user: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let user = user {
                print(user)
            }
        } */
        //print(runWithFriendId)
    }

}
