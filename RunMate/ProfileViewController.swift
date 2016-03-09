
//
//  ProfileViewController.swift
//  RunMate
//
//  Created by Julia Skrak on 2/7/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController , UIScrollViewDelegate {
    
    var scrollView: UIScrollView
    var profileView: ProfileView //profile pic is being stretched!!! oh no no
    var trophyCaseViewController : TrophyCaseViewController
    
    required init(coder aDecoder: NSCoder) {
        scrollView = UIScrollView()
        profileView = ProfileView()
        trophyCaseViewController = TrophyCaseViewController.init()
        super.init(coder: aDecoder)!
        self.setUpView()
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        profileView = ProfileView()
        scrollView = UIScrollView()
        trophyCaseViewController = TrophyCaseViewController.init()
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setUpView()
    }
    

    func setUpView(){ //must be called after super.init
        profileView = ProfileView.init(frame: CGRect(origin: self.view.frame.origin, size: CGSize(width: self.view.frame.width, height: self.view.frame.height + 3000)))
        profileView.nameLabel.textColor = UIColor.blackColor()
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = profileView.bounds.size
        //scrollView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        trophyCaseViewController = TrophyCaseViewController.init(profileViewFrame: self.profileView.trophyCaseContainerView.frame)
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(profileView)
        
        self.profileView.trophyCaseContainerView.addSubview(self.trophyCaseViewController.view)
        self.addChildViewController(self.trophyCaseViewController)
        trophyCaseViewController.didMoveToParentViewController(self)
        
        self.profileView.suggestTrophyButton.addTarget(self, action: "suggestTrophy:", forControlEvents: UIControlEvents.TouchUpInside)
        self.profileView.createTrophyButton.addTarget(self, action: "addTrophyManually:", forControlEvents: UIControlEvents.TouchUpInside)
        self.profileView.seeRunHistory.addTarget(self, action: "goToHistory:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
      /*   var query = PFQuery(className: "TrophyInformation")
        query.whereKey("userId", equalTo:PFUser.currentUser()!.objectId!)

        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil{
               print(objects)
            } else {
                print("ERROR: \(error!) \(error!.userInfo)")
            }
        } */
    }

    override func viewDidAppear(animated: Bool) {
        var query:PFQuery = PFUser.query()!
        query.whereKey("objectId", equalTo:PFUser.currentUser()!.objectId!)
        //query!.whereKey("weight", equalTo:100)
        query.getFirstObjectInBackgroundWithBlock{
            (object: PFObject?, error: NSError?) -> Void in
            if error == nil {
                self.setLabelInformationForUser(object)
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func suggestTrophy(sender: AnyObject){
        print("hey choloe's server")
    }
    
    func addTrophyManually(sender: AnyObject){
        print("manual addition")
        let screenRect = UIScreen.mainScreen().bounds
        //var userGoalAdditonView = goalAdditionView.init(frame:screenRect)

        //userGoalAdditonView.opaque = false
        //popView.layer.cornerRadius = 15;
//        userGoalAdditionViewController.view.backgroundColor = UIColor.whiteColor()
//        userGoalAdditionViewController.view.opaque = true
        
        
        //var testText: UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        //testText.backgroundColor = UIColor.whiteColor()
        
        //userGoalAdditonView.addSubview(testText)
        var userGoalAdditionViewController = GoalAdditionViewController.init()
       // userGoalAdditionViewController.userGoalAdditionView = userGoalAdditonView
    
        userGoalAdditionViewController.userGoalAdditionView.goalAdditonDelegate = userGoalAdditionViewController
        self.presentViewController(userGoalAdditionViewController, animated: true, completion: nil)//(userGoalAdditionViewController, animated: true)
       // print("is it editable?? \(userGoalAdditonView.testText.enabled)")
        
    }
    
    func setLabelInformationForUser(object: PFObject?){
        if let currentUser = PFUser.currentUser(){
            print("current user is \(currentUser.username)")
            print("then in facebook user is \(FBSDKAccessToken.currentAccessToken().userID)")
    
            var profilePictureGraphPath = FBSDKAccessToken.currentAccessToken().userID + "/picture?type=large&redirect=false"
            let pictureRequest = FBSDKGraphRequest(graphPath: profilePictureGraphPath, parameters: nil)
            pictureRequest.startWithCompletionHandler({
                (connection, result, error: NSError!) -> Void in
                if error == nil {
                    var resultdict = result as? NSDictionary
                    var mydata = resultdict?["data"]!
                    var myURL = mydata!["url"] as! String
                    let url = NSURL(string: myURL as! String)
                    let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
                    self.profileView.profilePictureImageView.image = UIImage(data: data!)
                    
                } else {
                    print("\(error)")
                }
          
            })
            
            self.profileView.overviewLabel.numberOfLines = 0
            
            dispatch_async(dispatch_get_main_queue()) {
                var mph = (currentUser.objectForKey("milePerHourTime") as? String)!.componentsSeparatedByString(":")
                self.profileView.nameLabel.text = (currentUser.objectForKey("name") as? String)!
                var overviewLabelText = (currentUser.objectForKey("name") as? String)! + " has been on " + String((currentUser.objectForKey("runNum") as? Int)!) + " runs for a total of "
                overviewLabelText =   overviewLabelText +   String((currentUser.objectForKey("totalDistance") as? Int)!) + " miles with a last mph of " + (mph[0] as? String)! + " minutes and " + (mph[1] as? String)! + " seconds"
                self.profileView.overviewLabel.text = overviewLabelText//currentUser.weight //mehhh :(
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: (currentUser.objectForKey("name") as? String)! + "'s Trophies")
                attributeString.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
                attributeString.addAttribute(NSFontAttributeName, value:  UIFont(name: "Helvetica", size: 24.0)!, range: NSMakeRange(0, attributeString.length))
                self.profileView.trophyLabel.attributedText = attributeString
                self.profileView.trophyLabel.font.fontWithSize(24)
            }
        }
    }
    
    func goToHistory(sender: AnyObject){
        var runHistoryViewController = RunHistoryViewController.init()
        self.presentViewController(runHistoryViewController, animated: true, completion: nil)
    }
}
