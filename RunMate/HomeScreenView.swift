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
        startRunButton.backgroundColor = UIColor.whiteColor()//UIColor(red: 0/255, green: 100/255, blue: 0/255, alpha: 1)
        startRunButton.layer.cornerRadius = 10
        startRunButton.titleLabel!.font = startRunButton.titleLabel!.font.fontWithSize(20)
        startRunButton.setTitle("🏃 go for a run!! 🏃", forState: UIControlState.Normal)
        startRunButton.titleLabel!.font = startRunButton.titleLabel!.font.fontWithSize(30)
        
        quoteLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 400))
        quoteLabel.font = quoteLabel.font.fontWithSize(35)
        quoteLabel.numberOfLines = 0
        quoteLabel.textAlignment = .Center
        quoteLabel.textColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        
        
            
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 254/255, green: 122/255, blue: 107/255, alpha: 1)//UIColor.whiteColor()//(red: 0xFE, green: 0x7A, blue: 0x6B, alpha: 1)
        self.addSubview(startRunButton)
        self.addSubview(quoteLabel)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
