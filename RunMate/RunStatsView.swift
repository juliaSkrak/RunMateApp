//
//  RunStatsView.swift
//  RunMate
//
//  Created by Julia Skrak on 2/5/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit


protocol runStatsDelegate {
    func closeWindow(testString: NSString)
}

class RunStatsView: UIView { //can be used as a popup over runview or in a scrollview with a lot of them as liek a total run history
    
    var locationView: UILabel
    var exitButton:UIButton
    var delegate: runStatsDelegate?
    
    override init(frame: CGRect) {
        locationView = UILabel.init(frame: frame)
    
        exitButton = UIButton.init(type: UIButtonType.RoundedRect)
        exitButton.frame = CGRect(x: frame.origin.x + 10, y: frame.size.height/2 - 20, width: frame.size.width-20, height: 30)
        exitButton.setTitle("close window", forState: UIControlState.Normal)
        exitButton.backgroundColor = UIColor.blackColor()
        //
        
        super.init(frame: frame)
        
        self.addSubview(locationView)
        self.backgroundColor = UIColor.orangeColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, setButton:Bool){
        print("convienient!!")
        self.init(frame: frame)
        if setButton {
            self.addSubview(exitButton)
            exitButton.addTarget(self, action: "closeStatsWindow:", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    func closeStatsWindow(sender:AnyObject){
        delegate?.closeWindow("heyooo")
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
