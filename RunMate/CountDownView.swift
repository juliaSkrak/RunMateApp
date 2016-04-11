//
//  CountDownView.swift
//  RunMate
//
//  Created by Julia Skrak on 4/10/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

class CountDownView: UIView {
    var timerLabel: UILabel
    var subLabel: UILabel

    override init(frame: CGRect) {
        timerLabel = UILabel.init(frame: CGRect(x: frame.width/2 - 100.0, y: frame.height/2 - 100.0, width: 200, height: 100))
        timerLabel.textAlignment = .Center
        subLabel = UILabel.init(frame: CGRect(x: frame.width/2 - 100.0, y: frame.height/2, width: 200, height: 100))
        subLabel.textAlignment = .Center
        subLabel.text = "seconds until run starts"
        super.init(frame: frame)
        self.addSubview(timerLabel)
        self.addSubview(subLabel)
        self.backgroundColor = UIColor.blueColor()
        timerLabel.backgroundColor = UIColor.greenColor()
        subLabel.backgroundColor = UIColor.redColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
