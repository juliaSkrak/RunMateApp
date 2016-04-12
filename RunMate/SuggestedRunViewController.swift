//
//  SuggestedRunViewController.swift
//  RunMate
//
//  Created by Julia Skrak on 3/18/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

class SuggestedRunViewController: UIViewController {
    
    var titleLabel : UILabel
    var goalWeightLabel: UILabel
    var goalWeeksLabel: UILabel
    var goalWieghtTextField: UITextField
    var goalWeeksTextField: UITextField
    var weightTextField: UITextField
    var weightLabel: UILabel
    var acceptButton: UIButton
    var rejectButon: UIButton
    var spaceingPoints : CGFloat = 20.0
    var labelWidth : CGFloat = 120.0
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        titleLabel = UILabel.init()
        goalWieghtTextField = UITextField.init()
        goalWeeksTextField = UITextField.init()
        goalWeightLabel = UILabel.init()
        goalWeeksLabel = UILabel.init()
        weightTextField = UITextField.init()
        weightLabel = UILabel.init()
        acceptButton = UIButton.init()
        rejectButon = UIButton.init()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view.backgroundColor = UIColor.purpleColor()
        var viewFrame = CGRect(x: spaceingPoints, y: spaceingPoints + 50, width: self.view.frame.width - spaceingPoints * 2, height: 100)
        titleLabel.frame = viewFrame
        titleLabel.text = "get suggested run"
        
        viewFrame = CGRect(x: spaceingPoints, y: viewFrame.origin.y + spaceingPoints +  viewFrame.size.height, width: labelWidth, height: spaceingPoints * 2)
        goalWeightLabel.frame = viewFrame
        goalWeightLabel.backgroundColor = UIColor.blueColor()
        goalWeightLabel.text = "Goal Weight :"
        
        viewFrame = CGRect(x : spaceingPoints + 10.0 + labelWidth, y: viewFrame.origin.y, width: self.view.frame.width - spaceingPoints * 2 - labelWidth - 10.0, height: viewFrame.size.height)
        goalWieghtTextField.frame = viewFrame
        goalWieghtTextField.backgroundColor = UIColor.blueColor()
        
        viewFrame = CGRect(x: spaceingPoints, y: viewFrame.origin.y + spaceingPoints +  viewFrame.size.height, width: labelWidth, height: spaceingPoints * 2)
        goalWeeksLabel.frame = viewFrame
        goalWeeksLabel.backgroundColor = UIColor.blueColor()
        goalWeeksLabel.text = "Goal Weeks :"
        
        viewFrame = CGRect(x: spaceingPoints + 10.0 + labelWidth, y: viewFrame.origin.y, width: self.view.frame.width - spaceingPoints * 2 - labelWidth - 10.0, height: viewFrame.size.height)
        goalWeeksTextField.frame = viewFrame
        goalWeeksTextField.backgroundColor = UIColor.blueColor()
        
        viewFrame = CGRect(x: spaceingPoints, y: viewFrame.origin.y + spaceingPoints +  viewFrame.size.height, width: labelWidth, height: spaceingPoints * 2)
        weightLabel.frame = viewFrame
        weightLabel.backgroundColor = UIColor.blueColor()
        weightLabel.text = "Start Weight :"
        
        viewFrame = CGRect(x: spaceingPoints + 10.0 + labelWidth, y:  viewFrame.origin.y, width: self.view.frame.width - spaceingPoints * 2 - labelWidth - 10.0, height: viewFrame.size.height)
        weightTextField.frame = viewFrame
        weightTextField.backgroundColor = UIColor.blueColor()
        
        viewFrame = CGRect(x: spaceingPoints * 2, y: viewFrame.origin.y + spaceingPoints * 2 + viewFrame.size.height, width: (self.view.frame.width - spaceingPoints * 6) / 2, height: 2 * spaceingPoints)
        rejectButon.frame = viewFrame
        rejectButon.backgroundColor = UIColor.blueColor()
        rejectButon.setTitle("Go Back", forState: .Normal)
        
        viewFrame = CGRect(x: (self.view.frame.width - spaceingPoints * 6) / 2 + spaceingPoints * 4, y: viewFrame.origin.y, width: (self.view.frame.width - spaceingPoints * 6) / 2, height: spaceingPoints * 2)
        acceptButton.frame = viewFrame
        acceptButton.backgroundColor = UIColor.blueColor()
        acceptButton.setTitle("Get Goal", forState: .Normal)
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(goalWeightLabel)
        self.view.addSubview(goalWieghtTextField)
        self.view.addSubview(goalWeeksLabel)
        self.view.addSubview(goalWeeksTextField)
        self.view.addSubview(weightLabel)
        self.view.addSubview(weightTextField)
        self.view.addSubview(rejectButon)
        self.view.addSubview(acceptButton)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        acceptButton.addTarget(self, action: "acceptButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        rejectButon.addTarget(self, action: "rejectButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func acceptButtonTapped(sender: AnyObject?){
        let urlPath: String = "https://sleepy-brook-69357.herokuapp.com/buddies/" + PFUser.currentUser()!.objectId!
        print(urlPath)
        var url: NSURL = NSURL(string: urlPath)!
        var request1: NSURLRequest = NSURLRequest(URL: url)
        let queue:NSOperationQueue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler:{ (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            var err: NSError
        do {
            let object:AnyObject? = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
            print(object)
        } catch let caught as ErrorType {
           // completeWith(nil, response, caught)
            }
        })
    }
    
    func rejectButtonTapped(sender: AnyObject?){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
