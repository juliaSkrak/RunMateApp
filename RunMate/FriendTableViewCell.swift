//
//  FriendTableViewCell.swift
//  RunMate
//
//  Created by Julia Skrak on 2/27/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

protocol FriendTableViewCellDelegate{
    func requestRun(userObjectId : String)
    func acceptFriendRequest(communityRelationship: CommunityRelationships)
    func segueToUserProfile(communityRelationship: CommunityRelationships)
}

class FriendTableViewCell: UITableViewCell {

    var nameLabel:UIButton?
    var rightButton:UIButton?
    var leftButton:UIButton?
    var delegate: FriendTableViewCellDelegate?
    var relationship: CommunityRelationships?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
      //  nameLabel = nil//UIButton.init()
      //  rightButton = nil//UIButton.init()
      //  leftButton = nil//UIButton.init()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        nameLabel = UIButton.init(frame: CGRect(x: 0,y: 0,width: screenWidth - 120, height: 60))

        
        rightButton = UIButton.init(frame : CGRect(x: screenWidth - 60 , y: 0, width: 60, height: 60))
        rightButton?.titleLabel?.numberOfLines = 0
        
        leftButton = UIButton.init(frame: CGRect(x: screenWidth - 120 , y: 0, width: 60, height: 60))
        leftButton?.titleLabel?.numberOfLines = 0
        
        
     //   nameLabel.textColor = UIColor.blueColor()
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
    
    func setCellFriendship(communityRelationship: CommunityRelationships){
        relationship = communityRelationship
        //var request = FBSDKGraphRequest.init(graphPath: "/me", parameters: nil
        let pictureRequest = FBSDKGraphRequest(graphPath: "102142236840216", parameters: nil)
        pictureRequest.startWithCompletionHandler({
        (connection, result, error: NSError!) -> Void in
            if error == nil {
                print("result is: \(result)")
                var resultdict = result as? NSDictionary
                let resultText = resultdict?.valueForKey("name") as! String
                self.nameLabel?.setTitle(resultText, forState: .Normal)
                self.nameLabel?.addTarget(self, action: "segueToUserProfile:", forControlEvents: .TouchUpInside)
                
                print(communityRelationship.accepted)
                if(communityRelationship.accepted == true){
                    self.rightButton?.setTitle("request run", forState: .Normal)
                    self.leftButton?.removeFromSuperview()
                    

                } else {
                    self.rightButton?.setTitle("accept friend", forState: .Normal)
                    self.leftButton?.setTitle("deny friend", forState: .Normal)
                }
                
            } else {
                print("\(error)")
            }
        })
    }
    
    func segueToUserProfile(sender: AnyObject?){
        delegate?.segueToUserProfile(relationship!)
    }

}
