//
//  FriendTableViewCell.swift
//  RunMate
//
//  Created by Julia Skrak on 2/27/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    var nameLabel:UIButton
    var buttonTwo:UIButton
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        nameLabel = UIButton.init()
        buttonTwo = UIButton.init()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenWidth = screenSize.width
        
        nameLabel.frame = CGRect(x: 0,y: 0,width: screenWidth - 120, height: 60)
        buttonTwo.frame = CGRect(x: screenWidth - 120 , y: 0, width: 120, height: 60)
        
        self.nameLabel.setTitleColor(UIColor.redColor(), forState: .Normal)
        
     //   nameLabel.textColor = UIColor.blueColor()
        nameLabel.backgroundColor = UIColor.whiteColor()
        self.backgroundColor = UIColor.redColor()
        nameLabel.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center//NSTextAlignment.Center
        buttonTwo.backgroundColor = UIColor.blackColor()
        
       // self.opaque =  true
        
        print(nameLabel.frame.width)
        print(self.frame.width)
        
        
        self.addSubview(nameLabel)
        self.addSubview(buttonTwo)
       
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellFriendship(communityRelationship: CommunityRelationships){
        //var request = FBSDKGraphRequest.init(graphPath: "/me", parameters: nil
        let pictureRequest = FBSDKGraphRequest(graphPath: "102142236840216", parameters: nil)
        pictureRequest.startWithCompletionHandler({
        (connection, result, error: NSError!) -> Void in
            if error == nil {
                print("result is: \(result)")
                var resultdict = result as? NSDictionary
                let resultText = resultdict?.valueForKey("name") as! String
                print("my result isss")
                print(resultText)
                print("this")
                self.nameLabel.setTitle(resultText, forState: .Normal)
                //self.nameLabel.setNeedsDisplay()
                
                print(communityRelationship.accepted)
                if(communityRelationship.accepted == true){
                    self.buttonTwo.setTitle("request run", forState: .Normal)

                } else {
                    self.buttonTwo.setTitle("accept friend", forState: .Normal)
                 
                }
                
            } else {
                print("\(error)")
            }
        })
    }

}
