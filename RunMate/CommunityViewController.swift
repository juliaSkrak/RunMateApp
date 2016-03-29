//
//  CommunityViewController.swift
//  RunMate
//
//  Created by Julia Skrak on 2/6/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

struct Friend {
    var userObjectId : String
    var facebookId : String
    var accepted : Bool
}


class CommunityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FriendTableViewCellDelegate {
    
    var communityTableView : UITableView
    var friendArray : [CommunityRelationships]
    var pendingRequests : [CommunityRelationships]
    var sentRequests : [CommunityRelationships]
    var communityDictionary : [String: [CommunityRelationships]]
    
    
    required init(coder aDecoder: NSCoder!) {
        friendArray = [CommunityRelationships]()
        pendingRequests = [CommunityRelationships]()
        sentRequests = [CommunityRelationships]()
        communityTableView = UITableView.init()
        communityDictionary = [:]
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
        friendArray = [CommunityRelationships]()
        pendingRequests = [CommunityRelationships]()
        sentRequests = [CommunityRelationships]()
        communityTableView = UITableView.init()
        communityDictionary = [:]
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      
        communityTableView = UITableView.init(frame:self.view.frame)
           self.communityTableView.registerClass(FriendTableViewCell.self, forCellReuseIdentifier: "communityCell")  // I THINK THIS WILL BREAK TODO: FIX THIS/MOVE TO VIEWWILLAPPEAR
        self.communityTableView.registerClass(GenericTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "headerView")
        communityTableView.delegate = self
        communityTableView.dataSource = self
        //communityTableView.reloadData()
        
        self.view.addSubview(communityTableView)
    }
    

   // func setDictionary
    
/*
    override init(frame: CGRect) {
      //  CommunityView = CommunityView()
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

*/
    

    override func viewDidLoad() {

        super.viewDidLoad()
        self.communityTableView.backgroundColor = UIColor.purpleColor()
        self.view.opaque = true
        communityTableView.delegate = self
        communityTableView.dataSource = self
        if let currentUser = PFUser.currentUser() {
            self.loadFriends(currentUser)
        }
        // communityTableView.reloadData()
        // Do any additional setup after loading the view.
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
            case 0:
                return (self.pendingRequests.isEmpty) ? self.friendArray.count : self.pendingRequests.count
            case 1:
                return self.friendArray.count
            default:
                return 0
        }
        return 0//self.friendArray.count
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var pending = (self.pendingRequests.isEmpty) ? 0 : 1
        var friends = (self.friendArray.isEmpty) ? 0 : 1
        print("number of sections")
        print(pending + friends)
        return pending + friends
    }
       // (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
        
        
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        print(communityTableView.frame)
        return CGFloat(60.0)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       // let arraycount = self.friendArray as Array
        var cell:FriendTableViewCell = self.communityTableView.dequeueReusableCellWithIdentifier("communityCell")! as! FriendTableViewCell
        cell.delegate = self
        if(!self.friendArray.isEmpty || !self.pendingRequests.isEmpty){
            var friendshipConnection : CommunityRelationships?
            cell.backgroundColor = UIColor.purpleColor()
            
            switch(indexPath.section){
            case 0:
                if(self.pendingRequests.isEmpty){
                    friendshipConnection = friendArray[indexPath.row]
                } else {
                    friendshipConnection = self.pendingRequests[indexPath.row]
                }
            case 1:
                print("beeep beep")
                friendshipConnection = self.friendArray[indexPath.row]
            default:
                break
            }
            if let currentUser = PFUser.currentUser(){
                if(friendshipConnection!.Friended == currentUser.objectId){
                    cell.setCellFriendship(friendshipConnection!, friend : Friend(userObjectId: friendshipConnection!.Friender, facebookId: friendshipConnection!.FrienderFacebookID, accepted: (friendshipConnection!.accepted != 0)))
                } else {
                    cell.setCellFriendship(friendshipConnection!, friend : Friend(userObjectId: friendshipConnection!.Friended, facebookId: friendshipConnection!.FriendedFacebookID, accepted: (friendshipConnection!.accepted != 0)))
                }
            }

        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = self.communityTableView.dequeueReusableHeaderFooterViewWithIdentifier("headerView")
        var header = cell as! GenericTableViewHeaderFooterView
       // header!.contentView.backgroundColor = UIColor.whiteColor()
        header.setNeedsLayout()
        return header
    }
    
    func loadFriends(currentUser: PFUser){
        var bothLoaded = false
        
        let sort : (UnsafeMutablePointer<[CommunityRelationships]>) -> (CommunityRelationships) -> () = {(cRArray: UnsafeMutablePointer<[CommunityRelationships]>) in
            var returnFunction = { (cR:CommunityRelationships) -> () in
                print("printing a cr)")
                print(cR)
                switch(cR.accepted){
                case 1:
                    //self.friendArray.append(Friend(userObjectId: cR.Friender, facebookId: cR.FrienderFacebookID, accepted: true))
                    //self.friendArray.append(Friend(userObjectId: cR.Friended, facebookId: cR.FriendedFacebookID, accepted: true))
                    self.friendArray.append(cR)
                    return
                case 0:
                   // cRArray.memory.append(Friend(userObjectId: cR.Friender, facebookId: cR.FrienderFacebookID, accepted: false))
                    //cRArray.memory.append(Friend(userObjectId: cR.Friended, facebookId: cR.FriendedFacebookID, accepted: false))
                    cRArray.memory.append(cR)
                 /*   print("self.pendingRequests")
                    print(self.pendingRequests)
                    print("cRArray::")
                    print(cRArray.memory) */
                 //   print(cRArray == self.pendingRequests)
                    return
                default:
                 //   cRArray.memory.append(cR)
                    return
                }
            }
            return returnFunction
        }
        
  
        var query = PFQuery(className: "CommunityRelationships")
        query.whereKey("Friended", equalTo:currentUser.objectId!)
        
        
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil{
                print("communities found")
                let friendedArray = (objects as? [CommunityRelationships])!
                friendedArray.map(sort(&self.pendingRequests))
                print("hot dayum you just curried, printing requests")
                print(self.pendingRequests)
                //self.friendArray = friendedArray + self.friendArray
                if(bothLoaded){
                    self.communityTableView.reloadData()
                } else {
                    bothLoaded = true
                }
            } else {
                print("ERROR: \(error!) \(error!.userInfo)")
            }
        }
        
        
        query = PFQuery(className: "CommunityRelationships")
        query.whereKey("Friender", equalTo:currentUser.objectId!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil{
                print("communities found")
                //print(objects)
                let frienderArray = (objects as? [CommunityRelationships])!
                //self.friendArray = self.friendArray + frienderArray
                frienderArray.map(sort(&self.sentRequests))
                print("hot dayum you just curried, printing requested")
                print(self.sentRequests)
                //print(self.friendArray)
                if(bothLoaded){
                    self.communityTableView.reloadData()
                } else {
                    print("not")
                    print(objects)
                    bothLoaded = true
                }
            } else {
                print("ERROR: \(error!) \(error!.userInfo)")
            }
        }
    }
    
    func requestRun(userObjectId : String){
        print("requesting run with \(userObjectId)")
    }
    
    func acceptFriendRequest(communityRelationship: CommunityRelationships){
        communityRelationship.accepted = true
        communityRelationship.saveInBackground()
    }
    
    func segueToUserProfile(communityRelationship: CommunityRelationships){
        var friendProfileViewController: ProfileViewController
        if(PFUser.currentUser()?.objectId == communityRelationship.Friended){
            friendProfileViewController = ProfileViewController.init(userObjId:communityRelationship.Friender, isCurrentUser:false)
        } else {
           friendProfileViewController = ProfileViewController.init(userObjId:communityRelationship.Friended, isCurrentUser:false)
        }
        self.navigationController?.pushViewController(friendProfileViewController, animated: true)
        
    }
    
}
