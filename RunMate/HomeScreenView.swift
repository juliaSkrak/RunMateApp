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
    var quoteLabel: UILabel
    
    override init(frame: CGRect) {
 
        startRunButton = UIButton.init(type: UIButtonType.RoundedRect) as UIButton
        startRunButton.frame = CGRect (x:20, y:frame.height/2, width: 300, height: 30)
        startRunButton.setTitle("go for a run!!", forState: UIControlState.Normal)
        
        quoteLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 200))
        quoteLabel.font = quoteLabel.font.fontWithSize(35)
        
        quoteLabel.text = "hey guys!!!!!"
            
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(startRunButton)
        self.addSubview(quoteLabel)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
