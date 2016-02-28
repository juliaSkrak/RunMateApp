//
//  HomeScreenView.swift
//  RunMate
//
//  Created by Julia Skrak on 2/5/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

class HomeScreenView: UIView {

    var startRunButton: UIButton
    var friendsButton: UIButton
    var yourProfPic: UIImageView
    var profileButton:UIButton
    
    override init(frame: CGRect) {
        
        
        startRunButton = UIButton.init(type: UIButtonType.RoundedRect) as UIButton
        startRunButton.frame = CGRect (x:20, y:frame.height/2, width: 300, height: 30)
        startRunButton.setTitle("go for a run!!", forState: UIControlState.Normal)
        
        friendsButton = UIButton.init(type: UIButtonType.RoundedRect) as UIButton
        friendsButton.frame = CGRect (x:20, y:frame.height/4, width: 300, height: 30)
        friendsButton.setTitle("go add ur friends!!", forState: UIControlState.Normal)
        
        yourProfPic = UIImageView.init(frame: CGRect (x:20, y:3*frame.height/4, width: 200, height: 200))
        yourProfPic.backgroundColor = UIColor(red: 59/255.0, green: 89/255.0, blue: 152/255.0, alpha: 1) // = CGSize(width: 200, height: 200)
     
        
        profileButton = UIButton.init(type: UIButtonType.RoundedRect) as UIButton
        profileButton.frame = CGRect(x:20, y:50, width: 300, height: 30)
        profileButton.setTitle(":-)", forState: UIControlState.Normal)
        
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.redColor()
        self.addSubview(startRunButton)
        self.addSubview(friendsButton)
        self.addSubview(yourProfPic)
        self.addSubview(profileButton)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
