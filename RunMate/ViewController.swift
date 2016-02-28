
//
//  ViewController.swift
//  RunMate
//
//  Created by Julia Skrak on 1/19/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import ParseFacebookUtilsV4
import FBSDKLoginKit


class ViewController: UIViewController {
    
    var homeScreenView : HomeScreenView
    var runMode:Bool = false


    required init(coder aDecoder: NSCoder!) {
        homeScreenView = HomeScreenView()
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        homeScreenView = HomeScreenView()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
  /*  convenience override init() {
        self.init(nibName: nil, bundle: nil)
    } */
    

    func setApperance(){
        homeScreenView = HomeScreenView.init(frame: self.view.frame)
        //homeScreenView.frame = self.view.frame
        print(self.view.subviews)
        self.view.addSubview(homeScreenView)
        homeScreenView.startRunButton.addTarget(self, action: "runInitiated:", forControlEvents: UIControlEvents.TouchUpInside)
        homeScreenView.friendsButton.addTarget(self, action: "friendslist:", forControlEvents: UIControlEvents.TouchUpInside)
        homeScreenView.profileButton.addTarget(self, action: "viewProfile:", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setApperance()
   
        //var username = username from UI or key store
        if let currentUser = PFUser.currentUser() {
            print("current user is \(currentUser.username)")
            print("facebook user is \(FBSDKAccessToken.currentAccessToken())")
            createSomeTrophies()
            //let username = currentUser.username
            print(currentUser)
  /*          FBSDKGraphRequest.init(graphPath: "me", parameters:["fields": "email, friends, birthday"]).startWithCompletionHandler {
                (connection:FBSDKGraphRequestConnection!,  result:AnyObject!, error:NSError!) -> Void in
                print("result")
                var resultdict = result as? NSDictionary
                print(resultdict)
                resultdict = resultdict?["friends"] as? NSDictionary
                print("next level: \(resultdict)")
                var mydata = resultdict?["data"]!
                //mydata = mydata
                print("next next level: \(mydata![0] as! NSDictionary)")
                var myDictionary = mydata![0] as! NSDictionary
                print("next next next level: \(myDictionary["id"]!)")
                //print(mydata.type)
                //var friends = resultdict?.valueForKey("friends") as? NSDictionary
                //var data = friends?.valueForKey("data") as? NSArray
                //for friend in data! {
                    var query:PFQuery = PFUser.query()!
                   // print("my frined is")
                    //print(friend)
                 var mystring = myDictionary["id"] as! String
                    query.whereKey("facebookIdPublic", equalTo: mystring)
                    //query.getObjectInBackgroundWithId(mystring) {
                    query.findObjectsInBackgroundWithBlock {
                        (objects: [PFObject]?, error: NSError?) -> Void in
                        if error == nil {
                            print("printing my names \(objects)")
                            if let objects = objects {
                                for object in objects {
                                    print(object.objectId)
                                }
                            }
                        } else {
                            // Log details of the failure
                            print("Error: \(error!) \(error!.userInfo)")
                        }
                    }
                //}
            }  */
        } else {
            //let btn = UIButton(type: UIButtonType.System) as UIButton
            //btn.frame = CGRectMake(100, 100, 200, 100)
            //btn.center = self.view.center
            
            //btn.setTitle("hello world", forState: UIControlState.Normal)
            //btn.addTarget(self, action: "eatMe:", forControlEvents: UIControlEvents.TouchUpInside)
            //btn.hidden = true
            //self.view.addSubview(btn)
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        if let currentUser = PFUser.currentUser() {
            print("current user is \(currentUser.username)")
        } else {
            let screenRect = UIScreen.mainScreen().bounds
            let screenWidth = screenRect.size.width
            let screenHeight = screenRect.size.height
            let popupLogin:popupLoginViewController = popupLoginViewController()
            let popView = popupView.init(frame:  CGRect(x: 30, y: 30, width: screenWidth-60, height: screenHeight-60))
            popupLogin.popView = popView
            popupLogin.view.addSubview(popView)
            popupLogin.popView.opaque = false
            popupLogin.popView.layer.cornerRadius = 15;
            popupLogin.view.backgroundColor = UIColor.whiteColor()
            //popView.alpha = 0.5
            popView.delegate = popupLogin
            self.presentViewController(popupLogin, animated: true, completion: nil)
            print(self.view.subviews)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func runInitiated(sender: AnyObject){
        //print("run initiated!")
        //var query = PFUser.query()
        var query:PFQuery = PFUser.query()!
        query.whereKey("objectId", equalTo:PFUser.currentUser()!.objectId!)
        //query!.whereKey("weight", equalTo:100)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil && (objects!.count == 1){
                // The find succeeded.
                let runScreen:RunScreenViewController = RunScreenViewController()
                self.presentViewController(runScreen, animated: true, completion: nil)

                // Do something with the found objects
                runScreen.runHash = (objects![0].objectForKey("runNum") as? NSNumber)!
                runScreen.runHash = NSNumber(integer: runScreen.runHash.integerValue + 1)
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }

    func friendslist(sender: AnyObject){
        FBSDKGraphRequest.init(graphPath: "me", parameters:["fields": "email, friends, birthday"]).startWithCompletionHandler {
            (connection:FBSDKGraphRequestConnection!,  result:AnyObject!, error:NSError!) -> Void in
            print("result")
            var resultdict = result as? NSDictionary
            print(resultdict)
            resultdict = resultdict?["friends"] as? NSDictionary
            print("next level: \(resultdict)")
            var mydata = resultdict?["data"]!
            //mydata = mydata
            print("next next level: \(mydata![0] as! NSDictionary)")
            var myDictionary = mydata![0] as! NSDictionary
            print("next next next level: \(myDictionary["id"]!)")
            var query:PFQuery = PFUser.query()!
            var mystring = myDictionary["id"] as! String
            query.whereKey("facebookIdPublic", equalTo: mystring)
            //query.getObjectInBackgroundWithId(mystring) {
            query.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                if error == nil {
                    print("printing my names \(objects)")
                    if let objects = objects {
                        for object in objects {
                            print(object.objectId)
                        }
                    }
                } else {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
            }
        }
        
       // FBSDKGraphRequest.init(graphPath: "10153440960432831/picture", parameters:
  /*      let pictureRequest = FBSDKGraphRequest(graphPath: "10153440960432831/picture?type=large&redirect=false", parameters: nil)
        pictureRequest.startWithCompletionHandler({
            (connection, result, error: NSError!) -> Void in
            if error == nil {
                print("\(result)")
                var resultdict = result as? NSDictionary
                var mydata = resultdict?["data"]!
                var myURL = mydata!["url"] as! String
                let url = NSURL(string: myURL as! String)
                let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
                self.homeScreenView.yourProfPic.image = UIImage(data: data!)
                
            } else {
                print("\(error)")
            }
        }) */
        
        addProfilePicture(self.homeScreenView.yourProfPic)
        
    }
    
    func addProfilePicture(imageView:UIImageView){
       /* let pictureRequest = FBSDKGraphRequest(graphPath: "10153440960432831/picture?type=large&redirect=false", parameters: nil)
        pictureRequest.startWithCompletionHandler({
            (connection, result, error: NSError!) -> Void in
            if error == nil {
                print("\(result)")
                var resultdict = result as? NSDictionary
                var mydata = resultdict?["data"]!
                var myURL = mydata!["url"] as! String
                let url = NSURL(string: myURL as! String)
                let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
                imageView.image = UIImage(data: data!)
                
            } else {
                print("\(error)")
            }
        }) */
       var testImage = UIImage.init(named: "lilcatpic")
        imageView.image = testImage
    }
    
    func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    func viewProfile(sender:AnyObject){
        let profileViewController:ProfileViewController = ProfileViewController()
        self.presentViewController(profileViewController, animated: true, completion: nil)
    }
    
    func createSomeTrophies(){//this is a test method, im adding to create some trophies so i can display them.  DO NOT KEEP
        var trophyInformation = TrophyInformation()
        trophyInformation.userObjectId = PFUser.currentUser()!.objectId!
        trophyInformation.completed = true
        trophyInformation.runNum = 4
        trophyInformation.timestamp = 1454962000.155431
        trophyInformation.definitionOfTrophy = "test 6"
        trophyInformation.distance = 4
        trophyInformation.totalTime = 16
        
       // trophyInformation.saveInBackground()
        
    }
    
}

