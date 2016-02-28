//
//  RunScreenView.swift
//  RunMate
//
//  Created by Julia Skrak on 2/5/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

protocol runScreenViewDelegate {
    func stopRun(testString: NSString)
}

class RunScreenView: UIView {
    var speedLabel: UILabel
    var finishRunButton: UIButton
    var delegate: runScreenViewDelegate?
    
    override init(frame: CGRect) {
        
        speedLabel = UILabel.init(frame: CGRect(origin: CGPoint(x: 20, y: 200), size: CGSize(width: 200, height: 30)))
        
        finishRunButton = UIButton.init(type: UIButtonType.RoundedRect)
        finishRunButton.frame = CGRect(origin: CGPoint(x:20, y:300), size: CGSize(width: 200, height: 30))
        finishRunButton.setTitle("finish run", forState: UIControlState.Normal)
        
        super.init(frame: frame)
        
        finishRunButton.addTarget(self, action: "stopRun:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.addSubview(finishRunButton)
        self.addSubview(speedLabel)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func stopRun(sender:AnyObject){
        print("run stopping")
        delegate?.stopRun("just stawwwp")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
