//
//  CommunityViewController.swift
//  RunMate
//
//  Created by Julia Skrak on 2/6/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

struct FriendStruct {
    var userObjectId : String
    var facebookId : String
    var accepted : Bool
}


class CommunityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FriendTableViewCellDelegate {
    
    var communityTableView : UITableView
    var friendArray : [Friend]
    var friendUserArray: [PFUser]
    var pendingRequestsUserArrary : [PFUser]
    var pendingRequests : [Friend]
    var communityDictionary : [String: [Friend]]
    var timeoutTimer : NSTimer
    var acceptanceCheckTimer : NSTimer
    var countdownTimer : NSTimer
    var runCountdownView : CountDownView
    var pendingRunOptional: PendingRun?

    
    required init(coder aDecoder: NSCoder!) {
        friendArray = [Friend]()
        pendingRequests = [Friend]()
        communityTableView = UITableView.init()
        communityDictionary = [:]
        friendUserArray = [PFUser]()
        pendingRequestsUserArrary = [PFUser]()
        
        timeoutTimer = NSTimer.init()
        acceptanceCheckTimer = NSTimer.init()
        countdownTimer = NSTimer.init()
        runCountdownView = CountDownView()
        
        super.init(coder: aDecoder)!

        communityTableView = UITableView.init(frame:self.view.frame)
        self.communityTableView.registerClass(FriendTableViewCell.self, forCellReuseIdentifier: "communityCell")
        self.communityTableView.registerClass(GenericTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "headerView")//move to own method so there arnt two of all this
        communityTableView.delegate = self
        communityTableView.dataSource = self
       // communityTableView.reloadData()
           self.view.addSubview(communityTableView)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {  //TODO: PLZ MAKE CONVIENCE INITS HERE where you init the friend tableviewcell
        friendArray = [Friend]()
        pendingRequests = [Friend]()
        communityTableView = UITableView.init()
        communityDictionary = [:]
        friendUserArray = [PFUser]()
        pendingRequestsUserArrary = [PFUser]()
    
        timeoutTimer = NSTimer.init()
        acceptanceCheckTimer = NSTimer.init()
        
        countdownTimer = NSTimer.init()
        runCountdownView = CountDownView()
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      
        communityTableView = UITableView.init(frame:self.view.frame)
           self.communityTableView.registerClass(FriendTableViewCell.self, forCellReuseIdentifier: "communityCell")  // I THINK THIS WILL BREAK TODO: FIX THIS/MOVE TO VIEWWILLAPPEAR
        self.communityTableView.registerClass(GenericTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "headerView")
        communityTableView.delegate = self
        communityTableView.dataSource = self
        //communityTableView.reloadData()
        
        self.view.addSubview(communityTableView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("achooo")
        if let currentUser = PFUser.currentUser() {
            self.loadFriends(currentUser)
        }
        communityTableView.delegate = self
        communityTableView.dataSource = self
        self.communityTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.communityTableView.backgroundColor = UIColor.purpleColor()
        self.view.opaque = true
        communityTableView.delegate = self
        communityTableView.dataSource = self
        if let currentUser = PFUser.currentUser() {
            self.loadFriends(currentUser)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
            case 0:
                return (self.pendingRequestsUserArrary.isEmpty) ? self.friendUserArray.count : self.pendingRequestsUserArrary.count
            case 1:
                return self.friendUserArray.count
            default:
                return 0
        }
        return 0//self.friendArray.count
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var pending = (self.pendingRequestsUserArrary.isEmpty) ? 0 : 1
        var friends = (self.friendUserArray.isEmpty) ? 0 : 1
        print("number of sections")
        print(pending + friends)
        return pending + friends
    }
        
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        print(communityTableView.frame)
        return CGFloat(60.0)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:FriendTableViewCell = self.communityTableView.dequeueReusableCellWithIdentifier("communityCell")! as! FriendTableViewCell
        cell.delegate = self
        if(!self.friendUserArray.isEmpty || !self.pendingRequestsUserArrary.isEmpty){
            var friendshipConnection : PFUser?
            var acceptedd: Bool = true
            cell.backgroundColor = UIColor.purpleColor()
            switch(indexPath.section){
            case 0:
                if(self.pendingRequestsUserArrary.isEmpty){
                    friendshipConnection = friendUserArray[indexPath.row]
                } else {
                    friendshipConnection = self.pendingRequestsUserArrary[indexPath.row]
                    acceptedd = false
                }
            case 1:
                print("beeep beep")
                friendshipConnection = self.friendUserArray[indexPath.row]
            default:
                break
            }
             cell.setCellFriendship(friendshipConnection!, accepted: acceptedd)

        }
        return cell
    }
    
   
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = self.communityTableView.dequeueReusableHeaderFooterViewWithIdentifier("headerView")
        var header = cell as! GenericTableViewHeaderFooterView
        switch(section){
        case 0:
            if(self.pendingRequestsUserArrary.isEmpty){
                header.titleLabel.text = "Friends"
            } else {
                header.titleLabel.text = "Pending Friend Requests"
            }
        case 1:
            header.titleLabel.text = "Friends"
        default:
            break
        }
    
        header.setNeedsLayout()
        return header
    }
    
    func loadFriends(currentUser: PFUser){
        var query = PFQuery(className: "Friend")
        query.includeKey("sentBy")
        query.includeKey("sentTo")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil{
                self.friendArray = (objects as? [Friend])!
                self.friendUserArray = self.friendArray.map{ if let myFriend : Friend = $0 {
                    if (myFriend.objectForKey("accepted")! as! Bool){
                        if(myFriend.objectForKey("sentTo")! as! PFUser == currentUser){
                            return myFriend.objectForKey("sentBy")! as! PFUser
                            
                        } else {
                            return myFriend.objectForKey("sentTo")! as! PFUser
                        }
                    }
                    }
                    return currentUser
                }
                
                self.pendingRequestsUserArrary = self.friendArray.map{
                    if let myFriend : Friend = $0{
                        let accepted = myFriend.objectForKey("accepted")! as! Bool
                        if (!accepted && (myFriend.objectForKey("sentTo")! as! PFUser == currentUser)){
                        return (myFriend.objectForKey("sentBy")! as! PFUser)
                        }
                    }
                    return currentUser
                }
                print("pendingfriendUserArray issss \(self.pendingRequestsUserArrary)")
                self.friendUserArray = self.friendUserArray.filter{$0 != currentUser}
                self.pendingRequestsUserArrary = self.pendingRequestsUserArrary.filter{$0 != currentUser}
                    
                print("pendingfriendUserArray issss \(self.pendingRequestsUserArrary)")
                self.communityTableView.reloadData()
            } else {
                print("ERROR: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func requestRun(user : PFUser){
        let pendingRun = PendingRun.init()
        pendingRun["accepted"] = 0
        pendingRun["sentBy"] = PFUser.currentUser() //sentBy = PFUser.currentUser()
        pendingRun["sentTo"] = user
        pendingRun["test"] = "this is a test"
        pendingRun.saveInBackgroundWithBlock{
            (success: Bool, error: NSError?) -> Void in
            if  success {
                self.timeoutTimer = NSTimer.scheduledTimerWithTimeInterval(300, target:self, selector: "requestTimout", userInfo: nil, repeats: false)
                self.acceptanceCheckTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "checkAccepted", userInfo: nil, repeats: true)
            } else {
                print("\(error)")
            }
        }
                
        let userQuery = PFUser.query()
        userQuery?.whereKey("objectId", equalTo: user.objectId!)
                // Find devices associated with these users
        let pushQuery: PFQuery = PFInstallation.query()!
        pushQuery.whereKey("user", matchesQuery: userQuery!)
        let data  = [
            "alertType" : 1,
            "objectId" :  (PFUser.currentUser()?.objectId!)!,
            "name" : (PFUser.currentUser()?.objectForKey("name")!)!
        ] as [String: AnyObject]
        let push = PFPush()
        push.setQuery(pushQuery)
        push.setData(data)
        push.sendPushInBackground()
        print(push)
    }
    
    
    func acceptFriendRequest(userObjId: String){
        print(userObjId)
        for friend : Friend in self.friendArray{
            if(userObjId == friend.objectForKey("sentBy")!.objectId!! as! String){
                friend["accepted"] = true as Bool
                friend.saveInBackground()
                self.friendUserArray.append(friend.objectForKey("sentBy") as! PFUser)
            }
        }
        print( self.pendingRequestsUserArrary)
        self.pendingRequestsUserArrary = self.pendingRequestsUserArrary.filter{$0.objectId! != userObjId}
        print(self.pendingRequestsUserArrary)
        self.communityTableView.reloadData()
    }
    
    func deleteFriendRequest(userObjId: String){
        print(userObjId)
        for friend : Friend in self.friendArray{
            if(userObjId == friend.objectForKey("sentBy")!.objectId!! as! String){
                friend.deleteInBackground()
            }
        }
        print(self.pendingRequestsUserArrary)
        self.pendingRequestsUserArrary = self.pendingRequestsUserArrary.filter{$0.objectId! != userObjId}
        print(self.pendingRequestsUserArrary)
        self.communityTableView.reloadData()
    }
    
    func segueToUserProfile(userObj: PFUser){
        var friendProfileViewController: ProfileViewController
        friendProfileViewController = ProfileViewController.init(userObj: userObj, isCurrentUser:false)
        self.navigationController?.pushViewController(friendProfileViewController, animated: true)
    }
    
    func requestTimout(){
        self.acceptanceCheckTimer.invalidate()
        let userQuery = PFUser.query()
        userQuery?.whereKey("objectId", equalTo: PFUser.currentUser()!.objectId!)

        let query = PFQuery(className: "PendingRun")
        query.whereKey("sentBy", matchesQuery: userQuery!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil{
                objects?.first?.deleteInBackground()
            }
        }
    }
    
    func checkAccepted(){
        let query = PFQuery(className: "PendingRun")
        query.whereKey("sentBy", equalTo: PFUser.currentUser()!)
        query.includeKey("sentTo")
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if (error == nil && !objects!.isEmpty){
                if let pendingRun = objects?.first as! PendingRun? {
                   print("\(pendingRun)")
                    switch (pendingRun["accepted"] as? Int!) {
                        case .Some(0):
                            break
                        case .Some(1):
                            self.runAccepted(pendingRun)
                            break
                        case .Some(2):
                            self.runRejected(pendingRun)
                            break
                        default:
                            break
                    }
                }
            }
        }
    }
    
    func updateRunCountdownAlert(){
        let message = Int(runCountdownView.timerLabel.text!)! - 1
        if (message == 0){
            timeoutTimer.invalidate()   
            runCountdownView.removeFromSuperview()
            print("second second \(pendingRunOptional)")
            var runScreenViewController = RunScreenViewController.init(friendObj: pendingRunOptional!["sentTo"]! as! PFUser)
            self.presentViewController(runScreenViewController, animated: true, completion: nil)
        } else {
            runCountdownView.timerLabel.text = String(message)
        }
    }
    
    
    func runAccepted(pendingRun: PendingRun){
        acceptanceCheckTimer.invalidate()
        
        if let startRun = pendingRun["beginRunTime"] as! Double! {
            let timeNow = NSDate().timeIntervalSince1970
            let timeLeft = startRun - timeNow
            print(timeLeft)
            if(timeLeft > 0){
                self.pendingRunOptional = pendingRun
                print("hello time left is \(pendingRunOptional!["sentTo"]!)")
                runCountdownView = CountDownView.init(frame: self.view.frame)
                self.view.addSubview(runCountdownView)
                runCountdownView.timerLabel.text = String(Int(timeLeft))
                self.timeoutTimer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: "updateRunCountdownAlert", userInfo: nil, repeats: true)
            }
            pendingRun.deleteInBackground()
            
        }
    }
    
    func runRejected(pendingRun: PendingRun){
        self.acceptanceCheckTimer.invalidate()
        pendingRun.deleteInBackground()
    }
}