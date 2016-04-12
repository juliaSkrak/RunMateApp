//
//  RunMetricView.swift
//  RunMate
//
//  Created by Julia Skrak on 4/11/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

class RunMetricView: UIView {
    var metricLabel: UILabel
    var discriptionLabel: UILabel
    
    override init(frame: CGRect) {
        metricLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width:121 , height: 50))
        metricLabel.font = metricLabel.font.fontWithSize(24)
        metricLabel.textAlignment = .Center
        discriptionLabel = UILabel.init(frame: CGRect(x: 0, y: 50, width: 121, height: 15))
        discriptionLabel.textColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        discriptionLabel.textAlignment = .Center
        super.init(frame: frame)
        
        self.addSubview(metricLabel)
        self.addSubview(discriptionLabel)
        self.backgroundColor = UIColor(red: 254/255, green: 122/255, blue: 107/255, alpha: 1)
        print(frame)
    }
    
    func setLabels(metricText:NSNumber?, discription descriptionText: String){
        if let metric = metricText as! NSNumber!{
            metricLabel.text = String(Double(round(100.0 * Double(metric))/100.0))
        } else {
            metricLabel.text = "0.0"
        }
        discriptionLabel.text = descriptionText
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
