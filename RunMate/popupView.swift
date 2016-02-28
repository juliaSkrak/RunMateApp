//
//  popupView.swift
//  RunMate
//
//  Created by Julia Skrak on 1/28/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit


protocol testDelegate {
    func testMethodA(testString: NSString)
    func testMethodB(testString: NSString, testInt:NSNumber)
}


class popupView: UIView {
    
    var facebookLogin: UIButton
    
    var title: UILabel
    var heightLabel: UILabel
    var feetTextField: UITextField
    var inchTextField: UITextField
    
    var weightLabel:UILabel
    var wightTextField: UITextField
    
    var goalWeightLabel: UILabel
    var goalWeightTextField: UITextField
    
    var acceptButton: UIButton
    
    var delegate:testDelegate?
 
    //var ageLabel: UILabel
    
    override init(frame: CGRect) {
        
        var buttonFrame = CGRect(x:20, y:frame.height/2, width: 300, height: 30)
        facebookLogin = UIButton.init(type: UIButtonType.RoundedRect) as UIButton
        facebookLogin.frame = buttonFrame
        facebookLogin.setTitle("login with facebook", forState: UIControlState.Normal)
        
        var titleHeight = 100.0 as CGFloat
        
        var labelEdges = CGRect(x:20, y:20, width: 300, height: 30)
        title = UILabel.init(frame: labelEdges)
        title.text = "Join Us!!"
        title.font = title.font?.fontWithSize(40)
        
        
        labelEdges = CGRect(x:20, y:labelEdges.origin.y + titleHeight, width: 100, height: 30)
        heightLabel = UILabel.init(frame: labelEdges)
        heightLabel.text = "Height : "
        heightLabel.font = heightLabel.font?.fontWithSize(28)
        heightLabel.textColor = UIColor.redColor()
        
        labelEdges = CGRect(x: labelEdges.origin.x + 110, y: labelEdges.origin.y , width: 60 , height: labelEdges.size.height)
        feetTextField = UITextField.init(frame: labelEdges)
        feetTextField.backgroundColor = UIColor.whiteColor()
        feetTextField.placeholder = "feet"
        feetTextField.layer.cornerRadius = 5
        feetTextField.font = feetTextField.font?.fontWithSize(28)
        
        labelEdges = CGRect(x: labelEdges.origin.x + 70, y: labelEdges.origin.y, width: labelEdges.size.width+30 , height: labelEdges.size.height)
        inchTextField = UITextField.init(frame: labelEdges)
        inchTextField.backgroundColor = UIColor.whiteColor()
        inchTextField.placeholder = "inches"
        inchTextField.layer.cornerRadius = 5
        inchTextField.font = inchTextField.font?.fontWithSize(28)
        
        
        labelEdges = CGRect(x: 20, y: labelEdges.origin.y + 50, width: 120, height: 30)
        weightLabel = UILabel(frame: labelEdges)
        weightLabel.textColor = UIColor.redColor()
        weightLabel.text = "Weight : "
        weightLabel.font = weightLabel.font?.fontWithSize(28)
        
        
        labelEdges = CGRect(x: 140, y: labelEdges.origin.y, width: 120, height: 30)
        wightTextField = UITextField(frame: labelEdges)
        wightTextField.placeholder = "pounds"
        wightTextField.backgroundColor = UIColor.whiteColor()
        wightTextField.layer.cornerRadius = 5
        wightTextField.font = wightTextField.font?.fontWithSize(28)
        
        labelEdges = CGRect(x: 20, y: labelEdges.origin.y + 50, width: 170, height: 30)
        goalWeightLabel = UILabel.init(frame: labelEdges)
        goalWeightLabel.text = "Goal weight : "
        goalWeightLabel.font = goalWeightLabel.font?.fontWithSize(28)
        goalWeightLabel.textColor = UIColor.redColor()
        
        labelEdges = CGRect(x: 200, y: labelEdges.origin.y, width: 100, height: 30)
        goalWeightTextField = UITextField.init(frame: labelEdges)
        goalWeightTextField.backgroundColor = UIColor.whiteColor()
        goalWeightTextField.placeholder = "pounds"
        goalWeightTextField.layer.cornerRadius = 5
        goalWeightTextField.font = goalWeightTextField.font?.fontWithSize(28)
        
        labelEdges = CGRect(x: 20, y: labelEdges.origin.y + 50, width: 100, height: 30)
        acceptButton = UIButton(frame: labelEdges)
        acceptButton.setTitle("hello world", forState: UIControlState.Normal)

        
        super.init(frame: frame)
        self.backgroundColor = UIColor.orangeColor()
        
        //self.opaque = false
        
        self.addSubview(heightLabel)
        self.addSubview(feetTextField)
        self.addSubview(inchTextField)
        self.addSubview(weightLabel)
        self.addSubview(wightTextField)
        self.addSubview(goalWeightLabel)
        self.addSubview(goalWeightTextField)
        self.addSubview(acceptButton)
        self.addSubview(title)
        self.addSubview(facebookLogin)
        
        self.setAppearance()
        
        acceptButton.addTarget(self, action: "eatMe:", forControlEvents: UIControlEvents.TouchUpInside)
        facebookLogin.addTarget(self, action: "biteMe:", forControlEvents: UIControlEvents.TouchUpInside)
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
    
    func eatMe(sender: AnyObject){
        let string:NSString = "hello world"
        self.delegate?.testMethodA(string)
    }
    
    
    func biteMe(sender: AnyObject){
        let string:NSString = "hello world"
        self.delegate?.testMethodB(string, testInt: 18)
    }


    func setAppearance(){
        var isInputHidden = true
        var isFacebookHidden = false
        if(heightLabel.hidden){
            isInputHidden = false
            isFacebookHidden = true
        }
        heightLabel.hidden = isInputHidden
        feetTextField.hidden = isInputHidden
        inchTextField.hidden = isInputHidden
        weightLabel.hidden = isInputHidden
        wightTextField.hidden = isInputHidden
        goalWeightLabel.hidden = isInputHidden
        goalWeightTextField.hidden = isInputHidden
        acceptButton.hidden = isInputHidden
        title.hidden = isInputHidden
        facebookLogin.hidden = isFacebookHidden
        
    }
    
    
}


