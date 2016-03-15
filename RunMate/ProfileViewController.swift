
//
//  ProfileViewController.swift
//  RunMate
//
//  Created by Julia Skrak on 2/7/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController , UIScrollViewDelegate, TrophyCaseViewControllerDelegate, TrophyInformationViewControllerDelegate, GoalAdditionViewControllerDelegate {
    
    var scrollView: UIScrollView
    var profileView: ProfileView //profile pic is being stretched!!! oh no no
    var trophyCaseViewController : TrophyCaseViewController
    var popupView : TrophyInformationView?
    var userObjectId: String?
    var currentUser: Bool?
    
    required init(coder aDecoder: NSCoder) {
        scrollView = UIScrollView() //TODO: stop this, ur father and i are very sad
        profileView = ProfileView()
        trophyCaseViewController = TrophyCaseViewController.init()
        super.init(coder: aDecoder)!
        self.setUpView()
    }
    
    convenience init(userObjId: String?, isCurrentUser:Bool){//ONLY USE THIS CONVIENCE, might need two
        self.init(nibName: nil, bundle: nil)
        if(!isCurrentUser){
            userObjectId = userObjId
        }
        self.currentUser = isCurrentUser
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
      //  print("nibName \(nibNameOrNil) and bundle \(nibBundleOrNil)")
        profileView = ProfileView()
        scrollView = UIScrollView()
        popupView = TrophyInformationView()
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
        trophyCaseViewController.delegate = self
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
    }

    override func viewDidAppear(animated: Bool) {
        if(self.currentUser!){
            if let currentUser = PFUser.currentUser() {
                self.userObjectId = currentUser.objectId
            }
        }
        var query:PFQuery = PFUser.query()!
        query.whereKey("objectId", equalTo:self.userObjectId!)
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
        userGoalAdditionViewController.delegate = self
       // userGoalAdditionViewController.userGoalAdditionView = userGoalAdditonView
    
        userGoalAdditionViewController.userGoalAdditionView.goalAdditonDelegate = userGoalAdditionViewController
        self.presentViewController(userGoalAdditionViewController, animated: true, completion: nil)//(userGoalAdditionViewController, animated: true)
       // print("is it editable?? \(userGoalAdditonView.testText.enabled)")
        
    }
    
    func setLabelInformationForUser(userObject: PFObject?){
     //   if let currentUser = PFUser.currentUser() {
           // print("current user is \(currentUser.username)")
     //   print("current user is \(currentUser.username)")
        print("then in facebook user is \(FBSDKAccessToken.currentAccessToken().userID)")
        print("the facebook user for the object is \(userObject!.objectForKey("facebookIdPublic"))")
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
            var mph = (userObject!.objectForKey("milePerHourTime") as? String)!.componentsSeparatedByString(":")
            self.profileView.nameLabel.text = (userObject!.objectForKey("name") as? String)!
            var overviewLabelText = (userObject!.objectForKey("name") as? String)! + " has been on " + String((userObject!.objectForKey("runNum") as? Int)!) + " runs for a total of "
            overviewLabelText =   overviewLabelText +   String((userObject!.objectForKey("totalDistance") as? Int)!) + " miles with a last mph of " + (mph[0] as? String)! + " minutes and " + (mph[1] as? String)! + " seconds"
            self.profileView.overviewLabel.text = overviewLabelText//currentUser.weight //mehhh :(
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: (userObject!.objectForKey("name") as? String)! + "'s Trophies")
            attributeString.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
            attributeString.addAttribute(NSFontAttributeName, value:  UIFont(name: "Helvetica", size: 24.0)!, range: NSMakeRange(0, attributeString.length))
            self.profileView.trophyLabel.attributedText = attributeString
            self.profileView.trophyLabel.font.fontWithSize(24)
        }
//        }
    }
    
    func goToHistory(sender: AnyObject){
        var runHistoryViewController = RunHistoryViewController.init()
        runHistoryViewController.navigationItem.title = "run history"
        self.navigationController?.pushViewController(runHistoryViewController, animated: true) // need to remember to do this every time!!
        
        //self.presentViewController(runHistoryViewController, animated: true, completion: nil)
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
    func openWindow(trophInfo: TrophyInformation) -> String {//TODO:make this for other ppl viewing this profile as well
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let contentInView: CGRect = CGRect(origin: scrollView.contentOffset, size: screenSize.size)
        let centerPoint = CGPoint(x: contentInView.size.width/2, y: contentInView.size.height/2)
        popupView = TrophyInformationView.init(frame: UIScreen.mainScreen().bounds, interactiveFrame: CGRect(x:Double(centerPoint.x)-150, y:Double(centerPoint.y)-150, width: 300.0, height:300.0), trophyinfo: trophInfo)
        popupView!.layer.cornerRadius = 10
      //  popupView!.backgroundColor = UIColor.purpleColor()
       self.view.addSubview(popupView!)
        popupView!.setUpView(trophInfo)
        popupView!.delegate = self
        return "alkfjd;lsfj"
    }
    
    
    func closeWindow(){
        popupView!.removeFromSuperview()
    }
    
    func deleteGoal(trophInfo: TrophyInformation){
       /* if let currentUser = PFUser.currentUser() {
            if(trophInfo.userObjectID == currentUser.objectId && trophInfo.completed! != 1){
                let query = PFQuery(className: "TrophyInformation")
                query.getObjectInBackgroundWithId(trophInfo.objectId!)
                query.getFirstObjectInBackgroundWithBlock{
                    (trophy: PFObject?, error: NSError?) -> Void in
                    if error == nil && trophy != nil { */
                        trophInfo.deleteInBackground()
                        closeWindow()
                        //trophyCaseViewController.co
               /*     } else {
                        print(error)
                    }
                }
            } else{
                print("error!!!!")
            
            }
        } */
        trophyCaseViewController.trophyArray.removeAtIndex(trophyCaseViewController.trophyCaseCollectionView.indexPathsForSelectedItems()!.first!.row)
     //   trophyCaseViewController.trophyCaseCollectionView.reloadDataSource()
        trophyCaseViewController.trophyCaseCollectionView.reloadData()
      //  print("the path is \(trophyCaseViewController.trophyCaseCollectionView.indexPathsForSelectedItems()!.first!.row)")
    }
    
    func addNewGoal(newGoal: TrophyInformation){
        trophyCaseViewController.trophyArray.append(newGoal)
        //   trophyCaseViewController.trophyCaseCollectionView.reloadDataSource()
        trophyCaseViewController.trophyCaseCollectionView.reloadData()
    }
}
