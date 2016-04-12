//
//  TrophyInformationView.swift
//  RunMate
//
//  Created by Julia Skrak on 3/10/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

protocol TrophyInformationViewControllerDelegate {
    // func testMethodA(testString: NSString)
    func closeWindow()
    func deleteGoal(trophInfo: TrophyInformation)
}


class TrophyInformationView: UIView {//can be reused!!
    //gonna try this with autolayout to see how it works
    var titleLabel: UILabel
    var subtitleLabel: UILabel
    var closeWindowButton: UIButton
    var deleteTrophyButton: UIButton
    var trophyImageView: UIImageView
    var delegate: TrophyInformationViewControllerDelegate?
    var trophyInfo: TrophyInformation?
    var interactiveFrame: UIView
    var interactiveFrameRect: CGRect?
    
    
    convenience init(frame: CGRect, interactiveFrame: CGRect, trophyinfo: TrophyInformation) {
        
        self.init(frame: frame)
        trophyInfo = trophyinfo
        print(trophyinfo.completed)
        self.buildConstraints(trophyinfo)
    }
    
    override init(frame: CGRect) {

        let centerPoint = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        interactiveFrame = UIView.init(frame: CGRect(x:Double(centerPoint.x)-150, y:Double(centerPoint.y)-150, width: 300.0, height:300.0))
        interactiveFrame.backgroundColor = UIColor.whiteColor()
        interactiveFrame.layer.cornerRadius = 10
        interactiveFrame.layer.borderColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1).CGColor
        interactiveFrame.layer.borderWidth = 3
        interactiveFrame.clipsToBounds = true
        
        titleLabel = UILabel.init()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .Center
        titleLabel.numberOfLines = 0
        
        subtitleLabel = UILabel.init()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.textAlignment = .Center
        subtitleLabel.numberOfLines = 0
        
        closeWindowButton = UIButton.init()
        closeWindowButton.translatesAutoresizingMaskIntoConstraints = false
        closeWindowButton.setTitle("close Window", forState: .Normal)
        closeWindowButton.setTitleColor( UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1), forState: .Normal)
        
        deleteTrophyButton = UIButton.init()
        deleteTrophyButton.translatesAutoresizingMaskIntoConstraints = false
        deleteTrophyButton.setTitle("delete goal", forState: .Normal)
        deleteTrophyButton.opaque = false
        deleteTrophyButton.setTitleColor( UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1), forState: .Normal)
        
        
        trophyImageView = UIImageView.init()
        trophyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        super.init(frame: frame)
        
        self.opaque = false
        
        self.addSubview(interactiveFrame)
        interactiveFrame.addSubview(titleLabel)
        interactiveFrame.addSubview(closeWindowButton)
        interactiveFrame.addSubview(deleteTrophyButton)
        interactiveFrame.addSubview(subtitleLabel)
        interactiveFrame.addSubview(trophyImageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpView(trophInfo: TrophyInformation){
        closeWindowButton.addTarget(self, action: "closeWindow:", forControlEvents: .TouchUpInside)
        if let currentUser = PFUser.currentUser() {
            if(trophInfo.userObjectID == currentUser.objectId && trophInfo.completed == 0){
                deleteTrophyButton.addTarget(self, action: "deleteWindow:", forControlEvents: .TouchUpInside)
            }
        }
        //print(trophInfo.completed)
       // deleteTrophyButton.opaque = trophInfo.completed == 1 ? false : true

        trophyImageView.image = UIImage.init(named: trophInfo.imageName)

        titleLabel.text = "Your goal to run \(trophInfo.distance) miles in \(trophInfo.minutes) minutes."
      // subtitleLabel.text =
        if(trophInfo.completed == 1){
            subtitleLabel.text = "You have completed your goal!!!  Congrats!!"
        } else {
            subtitleLabel.text = "You are so close to completing your goal!!"
        }
        
    }
    
    
    func buildConstraints(trophInfo:TrophyInformation){
        let viewsDictionary = ["titleLabel" : self.titleLabel, "closeWindowButton": self.closeWindowButton, "deleteTrophyButton":self.deleteTrophyButton, "trophyImageView": self.trophyImageView, "subtitleLabel": self.subtitleLabel]
        let titleLabelViewConstraintHorizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|[titleLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let trophyImageViewConstraintHorizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:[trophyImageView(100)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)

        let subtitleLabelImageViewConstraintHorizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|[subtitleLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        
        let verticalStackViewConstraintVertical = NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[trophyImageView(100)]-10-[titleLabel]-10-[subtitleLabel]-[closeWindowButton]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
   
        let imageViewCenterConstraint = NSLayoutConstraint(item: self.trophyImageView, attribute: .CenterX, relatedBy: .Equal, toItem: interactiveFrame, attribute: .CenterX, multiplier: 1, constant: 0)

        
        interactiveFrame.addConstraint(imageViewCenterConstraint)

        interactiveFrame.addConstraints(titleLabelViewConstraintHorizontal)
        interactiveFrame.addConstraints(verticalStackViewConstraintVertical)
        interactiveFrame.addConstraints(trophyImageViewConstraintHorizontal)

        self.addConstraints(subtitleLabelImageViewConstraintHorizontal)
        
        if let currentUser = PFUser.currentUser() {
            print("current user is trophy user is \(trophInfo.userObjectID == currentUser.objectId)")
            if(trophInfo.userObjectID == currentUser.objectId && trophInfo.completed! != 1){
                let buttonViewCenterConstraint = NSLayoutConstraint(item: self.closeWindowButton, attribute: .CenterY, relatedBy: .Equal, toItem: self.deleteTrophyButton, attribute: .CenterY, multiplier: 1, constant: 0)
                self.addConstraint(buttonViewCenterConstraint)
                
                let buttonViewConstraintHorizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[closeWindowButton]-20-[deleteTrophyButton]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
                interactiveFrame.addConstraints(buttonViewConstraintHorizontal)
            } else{
                let buttonViewConstraintHorizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[closeWindowButton]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
                interactiveFrame.addConstraints(buttonViewConstraintHorizontal)
            }
        }
        
    }

    
    func closeWindow(sender: AnyObject){
        delegate?.closeWindow()
    }
    
    func deleteWindow(sender: AnyObject){
        delegate?.deleteGoal(trophyInfo!)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
