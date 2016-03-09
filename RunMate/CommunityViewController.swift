//
//  CommunityViewController.swift
//  RunMate
//
//  Created by Julia Skrak on 2/6/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

class CommunityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var communityTableView : UITableView
    var friendArray : [CommunityRelationships]
    
    
    required init(coder aDecoder: NSCoder!) {
        friendArray = [CommunityRelationships]()
        communityTableView = UITableView.init()
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
        communityTableView = UITableView.init()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      
        communityTableView = UITableView.init(frame:self.view.frame)
           self.communityTableView.registerClass(FriendTableViewCell.self, forCellReuseIdentifier: "communityCell")
        self.communityTableView.registerClass(GenericTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "headerView")
        communityTableView.delegate = self
        communityTableView.dataSource = self
        //communityTableView.reloadData()
        
        self.view.addSubview(communityTableView)
    }
    

    
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
        if(communityTableView.frame.size.height == 0){
            return 0
        }
        return self.friendArray.count
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
       // (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
        
        
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        print(communityTableView.frame)
        return CGFloat(60.0)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       // let arraycount = self.friendArray as Array
        var cell:FriendTableViewCell = self.communityTableView.dequeueReusableCellWithIdentifier("communityCell")! as! FriendTableViewCell
        if(!self.friendArray.isEmpty){
            cell.backgroundColor = UIColor.redColor()
            // cell.textLabel?.text = self.items[indexPath.row]
            cell.setCellFriendship(self.friendArray[indexPath.row])
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
        var query = PFQuery(className: "CommunityRelationships")
        query.whereKey("Friended", equalTo:currentUser.objectId!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil{
                print("communities found")
                //print(objects)
                //bothLoaded = bothLoaded + 1
                let friendedArray = (objects as? [CommunityRelationships])!
                self.friendArray = friendedArray + self.friendArray
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
                self.friendArray = self.friendArray + frienderArray
                print(self.friendArray)
                if(bothLoaded){
                    print("oh hi i found u babee")
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
}
