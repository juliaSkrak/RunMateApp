//
//  ProfileView.swift
//  RunMate
//
//  Created by Julia Skrak on 2/7/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

class ProfileView: UIScrollView {
    
    var profilePictureImageView: UIImageView
    var nameLabel: UILabel
    var overviewLabel: UILabel
    var suggestTrophyButton: UIButton
    var createTrophyButton: UIButton
    var trophyLabel: UILabel
    var trophyCaseContainerView: UIView
    var seeRunHistory:UIButton

    
    
    override init(frame: CGRect) {
        print(frame)
        
        profilePictureImageView = UIImageView.init(frame: CGRect(x:frame.size.width/2-100, y: frame.origin.y + 30, width: 200, height: 200))
        profilePictureImageView.backgroundColor = UIColor(red: 59/255.0, green: 89/255.0, blue: 152/255.0, alpha: 1)
        
        nameLabel = UILabel.init(frame: CGRect(x:frame.origin.x, y: frame.origin.y + 240, width: frame.size.width, height: 40))
        nameLabel.backgroundColor = UIColor.grayColor()
        nameLabel.font = nameLabel.font.fontWithSize(28)
        nameLabel.textAlignment = .Center
        
        
        
        overviewLabel = UILabel.init(frame: CGRect(x:frame.origin.x + 10, y: frame.origin.y + 290, width: frame.size.width - 20, height: 80))
        overviewLabel.backgroundColor = UIColor.purpleColor()
        
        trophyLabel = UILabel.init(frame: CGRect(x:frame.origin.x + 10, y:  frame.origin.y + 380, width: frame.size.width - 20, height: 40))
        trophyLabel.textAlignment = .Center

        trophyCaseContainerView = UIView.init(frame: CGRect(x:frame.origin.x + 10, y:frame.origin.y + 450,  width: frame.width - 20, height:frame.width - 20))
        print("containerviewedd \(trophyCaseContainerView.frame)")
        trophyCaseContainerView.backgroundColor = UIColor.purpleColor()
        
        var personalInfoHeight = frame.origin.y + 460 + frame.width - 20
        suggestTrophyButton = UIButton.init(frame: CGRect(x: frame.origin.x + 10, y: personalInfoHeight, width: (frame.width - 25)/2, height: 40))
        suggestTrophyButton.backgroundColor = UIColor.blueColor()
        suggestTrophyButton.setTitle("get suggested goal", forState: UIControlState.Normal)
        suggestTrophyButton.layer.cornerRadius = 10
        
        createTrophyButton = UIButton.init(frame: CGRect(x: frame.origin.x + 15 + (frame.width - 25)/2 , y: personalInfoHeight, width: (frame.width - 25)/2, height: 40))
        createTrophyButton.layer.cornerRadius = 10
        createTrophyButton.backgroundColor = UIColor.blueColor()
        createTrophyButton.setTitle("make your own goal", forState: UIControlState.Normal)
        
        seeRunHistory = UIButton.init(frame: CGRect(x: frame.origin.x + 15 + (frame.width - 25)/2 , y: personalInfoHeight + 60, width: (frame.width - 25)/2, height: 40))
        seeRunHistory.setTitle("see your own run history", forState: UIControlState.Normal)//this should only be viewable from the current user's profile
        seeRunHistory.backgroundColor = UIColor.purpleColor()
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        self.addSubview(profilePictureImageView)
        self.addSubview(nameLabel)
        self.addSubview(overviewLabel)
        self.addSubview(trophyCaseContainerView)
        self.addSubview(suggestTrophyButton)
        self.addSubview(createTrophyButton)
        self.addSubview(trophyLabel)
        self.addSubview(seeRunHistory)
        
        
        self.autoresizingMask = UIViewAutoresizing.FlexibleWidth.union(UIViewAutoresizing.FlexibleHeight)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
