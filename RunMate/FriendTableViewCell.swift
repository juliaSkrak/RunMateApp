//
//  FriendTableViewCell.swift
//  RunMate
//
//  Created by Julia Skrak on 2/27/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

protocol FriendTableViewCellDelegate{
    func requestRun(user : PFUser)
    func acceptFriendRequest(userObjectId: String)
    func segueToUserProfile(userObj: PFUser)
    func deleteFriendRequest(userObjId: String)
}

class FriendTableViewCell: UITableViewCell {

    var nameLabel:UIButton?
    var rightButton:UIButton?
    var leftButton:UIButton?
    var delegate: FriendTableViewCellDelegate?
    var relationship: CommunityRelationships?
    var cellFriend : FriendStruct?
    var user: PFUser?
    var acceptedRequest : Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        nameLabel = UIButton.init(frame: CGRect(x: 0,y: 0,width: screenWidth - 120, height: 60))

        
        rightButton = UIButton.init(frame : CGRect(x: screenWidth - 60 , y: 0, width: 60, height: 60))
        rightButton?.titleLabel?.numberOfLines = 0
        
        leftButton = UIButton.init(frame: CGRect(x: screenWidth - 120 , y: 0, width: 60, height: 60))
        leftButton?.titleLabel?.numberOfLines = 0
        
        
        self.backgroundColor = UIColor.whiteColor()

        nameLabel!.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center//NSTextAlignment.Center
        rightButton!.backgroundColor = UIColor.blackColor()
        nameLabel?.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        self.addSubview(nameLabel!)
        self.addSubview(rightButton!)
        self.addSubview(leftButton!)
       
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellFriendship(friend: PFUser, accepted : Bool){
        acceptedRequest = accepted
        user = friend
        
        rightButton?.removeTarget(nil, action: nil, forControlEvents: .AllEvents)
        leftButton?.removeTarget(nil, action: nil, forControlEvents: .AllEvents)
       
        
        print(user)
        let pictureRequest = FBSDKGraphRequest(graphPath: user!.objectForKey("facebookIdPublic") as! String, parameters: nil)
        pictureRequest.startWithCompletionHandler({
        (connection, result, error: NSError!) -> Void in
            if error == nil {
                print("result is: \(result)")
                var resultdict = result as? NSDictionary
                let resultText = resultdict?.valueForKey("name") as! String
                self.nameLabel?.setTitle(resultText, forState: .Normal)
                self.nameLabel?.addTarget(self, action: "segueToUserProfile:", forControlEvents: .TouchUpInside)
                
                print(accepted)
                if(accepted == true){
                    self.rightButton?.setTitle("request run", forState: .Normal)
                    
                    self.leftButton?.alpha = 0
                    self.rightButton?.addTarget(self, action: "requestRun:", forControlEvents: .TouchUpInside)
                 
                } else {
                    self.rightButton?.setTitle("accept friend", forState: .Normal)
                    self.leftButton?.setTitle("deny friend", forState: .Normal)
                    self.leftButton?.alpha = 1
                    self.rightButton?.addTarget(self, action: "acceptFriend:", forControlEvents: .TouchUpInside)
                    self.leftButton?.addTarget(self, action: "rejectFriend:", forControlEvents: .TouchUpInside)
                }
                
            } else {
                print("\(error)")
            }
        })
    }
    
    func requestRun(sender:AnyObject?){
        self.delegate!.requestRun(user!)
    }
    
    func acceptFriend(sender: AnyObject?){
        print("feel acceptance")
        self.delegate!.acceptFriendRequest(user!.objectId!)
    }
    
    func rejectFriend(sender: AnyObject?){
        print("mehhh")
        delegate!.deleteFriendRequest(user!.objectId!)
    }
    
    func segueToUserProfile(sender: AnyObject?){
        delegate?.segueToUserProfile(user!)
    }

}
