//
//  CurrentRunStatsView.swift
//  RunMate
//
//  Created by Julia Skrak on 3/23/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

class CurrentRunStatsView: UIView {//because i want to reuse this method im gonna use
    
    var userSpeed : RunMetricView
    var userDistance : RunMetricView
    var userAltitude: RunMetricView
    var userTime: UILabel
    var userCalories : UILabel
    var barA: UILabel
    var barB: UILabel
    
    override init(frame: CGRect) {
        userSpeed = RunMetricView.init()
        userSpeed.translatesAutoresizingMaskIntoConstraints = false
    
        
        userCalories = UILabel.init()
        userCalories.translatesAutoresizingMaskIntoConstraints = false
        userCalories.font = userCalories.font.fontWithSize(24)
        
        userDistance = RunMetricView.init()
        userDistance.translatesAutoresizingMaskIntoConstraints = false
        
        userAltitude = RunMetricView.init()
        userAltitude.translatesAutoresizingMaskIntoConstraints = false
       // userAltitude.text = "userAltitude"
        
        
        barA = UILabel.init()
        barA.translatesAutoresizingMaskIntoConstraints = false
        barA.backgroundColor =  UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        barA.text = "\t"
        
        barB = UILabel.init()
        barB.translatesAutoresizingMaskIntoConstraints = false
        barB.backgroundColor =  UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        barB.text = "\t"
        
        userTime = UILabel.init()
        userTime.translatesAutoresizingMaskIntoConstraints = false
        userTime.backgroundColor = UIColor.whiteColor()
        userTime.textAlignment = .Center
        userTime.font = userTime.font.fontWithSize(30)
        
        
        super.init(frame: frame)
        
        self.addSubview(userSpeed)
        self.addSubview(userDistance)
        self.addSubview(userAltitude)
        self.addSubview(barA)
        self.addSubview(barB)
        self.addSubview(userTime)
        self.addSubview(userCalories)
        
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func displayTimeText(minutes minutes: String, seconds: String){
        userTime.text = "⏳  \(minutes) : \(seconds)  ⏳"
    }
    
    func displayRunStats(location: RunLocation){
        userDistance.setLabels(location.distance, discription: "distance")
        userAltitude.setLabels(location.altitude, discription: "altitude")
        userSpeed.setLabels(location.speed, discription: "speed")
        userCalories.text = "Calories:" +  String(Int(Double(round(100.0 * Double(150 * 0.63 * location.distance!.doubleValue) / 100.0))))
    }
    
    func setConstraints(){
        var viewsDictionary = ["userSpeed": self.userSpeed, "userDistance": self.userDistance, "userAltitude": self.userAltitude, "barA": self.barA, "barB": self.barB, "userTime": self.userTime, "userCalories": self.userCalories]

        let horizontialLayoutOfUserStats = NSLayoutConstraint.constraintsWithVisualFormat("H:|[userSpeed][barA][userDistance][barB][userAltitude]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let setWidthConstraintEqualA = NSLayoutConstraint(item: self.userSpeed, attribute: NSLayoutAttribute.Width, relatedBy: .Equal, toItem: self.userDistance, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0)
        let setWidthConstraintEqualB = NSLayoutConstraint(item: self.userSpeed, attribute: NSLayoutAttribute.Width, relatedBy: .Equal, toItem: self.userAltitude, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0)
        let setWidthConstraintBarB = NSLayoutConstraint(item: self.barB, attribute: NSLayoutAttribute.Width, relatedBy: .Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 0, constant: 5)
        let setWidthConstraintBarA = NSLayoutConstraint(item: self.barA, attribute: NSLayoutAttribute.Width, relatedBy: .Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 0, constant: 5)
        
        
        let verticalUserSpeedConstraints = NSLayoutConstraint(item: self.userSpeed, attribute: NSLayoutAttribute.Height, relatedBy: .Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 0.5, constant: 0)
        let verticalUserDistanceConstraints = NSLayoutConstraint(item: self.userDistance, attribute: NSLayoutAttribute.Height, relatedBy: .Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 0.5, constant: 0)
        let verticaluserAltitudeConstraints = NSLayoutConstraint(item: self.userAltitude, attribute: NSLayoutAttribute.Height, relatedBy: .Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 0.5, constant: 0)
        //let verticaluserTimeConstraints = NSLayoutConstraint(item: self.userTime, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: self.userTime, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        
        
        
        let hieghtUserSpeedConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[userSpeed]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let heightlUserDistanceConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[userDistance]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let heightUserAltitudeConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[userAltitude]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let bottomUserTimeConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[userTime(100)][userCalories(50)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let widthUserTimeConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[userTime]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let widthCalorieConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[userCalories]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)

        let verticaluserBarAConstraints = NSLayoutConstraint(item: self.barA, attribute: NSLayoutAttribute.Height, relatedBy: .Equal, toItem: self.userDistance, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0)
        let verticaluserBarBConstraints = NSLayoutConstraint(item: self.barB, attribute: NSLayoutAttribute.Height, relatedBy: .Equal, toItem: self.userAltitude, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0)
        let originUserBarAConstraints = NSLayoutConstraint(item: self.barA, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: self.userDistance, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        let originUserBarBConstraints = NSLayoutConstraint(item: self.barB, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: self.userAltitude, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)

        self.addConstraint(setWidthConstraintBarB)
        self.addConstraint(setWidthConstraintBarA)
        self.addConstraints(horizontialLayoutOfUserStats)
        self.addConstraints(bottomUserTimeConstraints)
        self.addConstraints(widthUserTimeConstraints)
        self.addConstraints(hieghtUserSpeedConstraints)
        self.addConstraints(heightlUserDistanceConstraints)
        self.addConstraint(verticalUserSpeedConstraints)
        self.addConstraint(verticalUserDistanceConstraints)
        self.addConstraint(verticaluserAltitudeConstraints)
        self.addConstraints(heightUserAltitudeConstraints)
        self.addConstraint(setWidthConstraintEqualB)
        self.addConstraint(setWidthConstraintEqualA)
        self.addConstraint(verticaluserBarAConstraints)
        self.addConstraint(verticaluserBarBConstraints)
        self.addConstraint(originUserBarAConstraints)
        self.addConstraints(widthCalorieConstraints)
        self.addConstraint(originUserBarBConstraints)
    }
    

}
