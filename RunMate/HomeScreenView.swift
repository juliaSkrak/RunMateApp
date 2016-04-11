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
        startRunButton.frame = CGRect (x:20, y:frame.height*2/3, width: frame.width - 40, height: 150)
        startRunButton.backgroundColor = UIColor.greenColor()
        startRunButton.layer.cornerRadius = 10
        startRunButton.titleLabel!.font = startRunButton.titleLabel!.font.fontWithSize(20)
        startRunButton.setTitle("go for a run!!", forState: UIControlState.Normal)
        
        quoteLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 400))
        quoteLabel.font = quoteLabel.font.fontWithSize(35)
        quoteLabel.numberOfLines = 0
        quoteLabel.textAlignment = .Center
        
        
            
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(startRunButton)
        self.addSubview(quoteLabel)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
