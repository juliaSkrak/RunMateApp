//
//  goalAdditionView.swift
//  RunMate
//
//  Created by Julia Skrak on 2/15/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit


//var ageLabel: UILabel

protocol GoalAdditonDelegate {
    func closeSuggestion()
    func addSuggestion(distanceInteger: NSNumber, distanceFractional: NSNumber, time:NSNumber)
}


class GoalAdditionView: UIView {

    var title: UILabel
    var distanceLabel: UILabel
    var periodLabel: UILabel
    var distanceWholeTextField: UITextField
    var distanceFractionTextField:UITextField
    //var inchTextField: UITextField
    
    var timeLabel:UILabel
    var timeTextField: UITextField

    var acceptButton: UIButton
    var rejectButton: UIButton
    
   // var testText: UITextField
    

    var goalAdditonDelegate : GoalAdditonDelegate?
    
    override init(frame: CGRect) {

        
//        testText = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        testText.backgroundColor = UIColor.orangeColor()
//        testText.textColor = UIColor.blueColor()
        
//        var testButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        testButton.backgroundColor = UIColor.orangeColor()
//        testButton.setTitle("hello world", forState: UIControlState.Normal)
       // testButton.actionsForTarget(<#T##target: AnyObject?##AnyObject?#>, forControlEvent: <#T##UIControlEvents#>)
     
        
        var buttonFrame = CGRect(x:20, y:frame.height/2, width: 300, height: 30)
 
        var titleHeight = 100.0 as CGFloat
        
        var labelEdges = CGRect(x:20, y:20, width: 300, height: 30)
        title = UILabel.init(frame: labelEdges)
        title.text = "Create Your Own Goal"
        title.font = title.font?.fontWithSize(40)
        
        
        labelEdges = CGRect(x:20, y:labelEdges.origin.y + titleHeight, width: 100, height: 30)
        distanceLabel = UILabel.init(frame: labelEdges)
        distanceLabel.text = "Distance : "
        distanceLabel.font = distanceLabel.font?.fontWithSize(28)
        distanceLabel.textColor = UIColor.redColor()
        
        periodLabel = UILabel.init(frame: CGRect(x:230, y:labelEdges.origin.y, width: 10, height: 30))
        periodLabel.text = "."
        periodLabel.font = distanceLabel.font?.fontWithSize(28)
        periodLabel.textColor = UIColor.redColor()
        
        
        labelEdges = CGRect(x: labelEdges.origin.x + 110, y: labelEdges.origin.y , width: 90 , height: labelEdges.size.height)
        distanceWholeTextField = UITextField.init(frame: labelEdges)
        distanceWholeTextField.backgroundColor = UIColor.whiteColor()
        distanceWholeTextField.placeholder = "miles"
        distanceWholeTextField.layer.cornerRadius = 5
        distanceWholeTextField.font = distanceWholeTextField.font?.fontWithSize(28)
        
        //labelEdges = CGRect(x: labelEdges.origin.x + 130, y: labelEdges.origin.y , width: 90 , height: labelEdges.size.height)
        distanceFractionTextField = UITextField.init(frame: CGRect(x: labelEdges.origin.x + 120, y: labelEdges.origin.y , width: 90 , height: labelEdges.size.height))
        distanceFractionTextField.backgroundColor = UIColor.whiteColor()
        distanceFractionTextField.placeholder = "miles"
        distanceFractionTextField.layer.cornerRadius = 5
        distanceFractionTextField.font = distanceFractionTextField.font?.fontWithSize(28)

        labelEdges = CGRect(x: 20, y: labelEdges.origin.y + 50, width: 120, height: 30)
        timeLabel = UILabel(frame: labelEdges)
        timeLabel.textColor = UIColor.redColor()
        timeLabel.text = "Total Time : "
        timeLabel.font = timeLabel.font?.fontWithSize(28)
        
        labelEdges = CGRect(x: 140, y: labelEdges.origin.y, width: 120, height: 30)
        timeTextField = UITextField(frame: labelEdges)
        timeTextField.placeholder = "in minutes"
        timeTextField.backgroundColor = UIColor.whiteColor()
        timeTextField.layer.cornerRadius = 5
        timeTextField.font = timeTextField.font?.fontWithSize(28)
        
        labelEdges = CGRect(x: 20, y: labelEdges.origin.y + 50, width: 100, height: 30)
        acceptButton = UIButton(frame: labelEdges)
        acceptButton.setTitle("accept", forState: UIControlState.Normal)
        
        labelEdges = CGRect(x: 30 + labelEdges.size.width, y: labelEdges.origin.y, width: 100, height: labelEdges.size.height)
        rejectButton = UIButton(frame: labelEdges)
        rejectButton.setTitle("reject", forState: UIControlState.Normal)
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.purpleColor()
        
        self.addSubview(distanceLabel)
        self.addSubview(periodLabel)
        self.addSubview(distanceWholeTextField)
        self.addSubview(distanceFractionTextField)
        self.addSubview(rejectButton)
        self.addSubview(timeLabel)
        self.addSubview(timeTextField)
        self.addSubview(acceptButton)
        self.addSubview(title)
        rejectButton.addTarget(self, action: "rejectSuggestion:", forControlEvents: UIControlEvents.TouchUpInside)
        acceptButton.addTarget(self, action: "acceptSelection:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func rejectSuggestion(sender: AnyObject){
        goalAdditonDelegate!.closeSuggestion()
    }
    
    func acceptSelection(sender: AnyObject){
        
        var distanceInt = 0
        var distanceFractional:Double = 0.0
        
        
        if let distInt = Int(distanceWholeTextField.text!){
            distanceInt = distInt
        }
        
        if let distFractional = Double(distanceFractionTextField.text!){
           // var countString: String = distanceFractionTextField.text!
            distanceFractional = pow(10, -Double(distanceFractionTextField.text!.characters.count)) * distFractional
        }
        
        let timeText = timeTextField.text!
        if let number = Int(timeText) {
            let myNumber = NSNumber(integer:number)
            goalAdditonDelegate!.addSuggestion(distanceInt, distanceFractional:distanceFractional, time: myNumber)
        } else {
            print("'\(timeTextField.text!)' did not convert to an Int")
        }
        
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
