//
//  GoalAdditionViewController.swift
//  RunMate
//
//  Created by Julia Skrak on 2/16/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

protocol GoalAdditionViewControllerDelegate{
    func addNewGoal(newGoal: TrophyInformation)
}

class GoalAdditionViewController: UIViewController, GoalAdditonDelegate {
    
    var userGoalAdditionView: GoalAdditionView
    var delegate: GoalAdditionViewControllerDelegate?
    
    required init(coder aDecoder: NSCoder!) {
        userGoalAdditionView = GoalAdditionView()
        super.init(coder: aDecoder)!
      
        self.view.opaque = true
        userGoalAdditionView = GoalAdditionView.init(frame: self.view.frame)
        self.view.addSubview(userGoalAdditionView)
       
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        userGoalAdditionView = GoalAdditionView()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.view.opaque = true
        userGoalAdditionView = GoalAdditionView.init(frame: self.view.frame)
        self.view.addSubview(userGoalAdditionView)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.purpleColor()
        view.opaque = true
        view.bringSubviewToFront(userGoalAdditionView)
        userGoalAdditionView.goalAdditonDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func addSuggestion(distanceInteger: NSNumber, distanceFractional: NSNumber, time:NSNumber){
        var newGoal = TrophyInformation()
        newGoal.completed = false
        newGoal.distance = Double(distanceInteger) + Double(distanceFractional)
        newGoal.minutes = time
        newGoal.imageName = "trophyImg" + String(arc4random_uniform(10) + 1)
        if let currentUser = PFUser.currentUser() {
            newGoal.userObjectID = currentUser.objectId
        } else {
            print("error, user logged out")
        }
        newGoal.completed = false
       // print(newGoal)
        newGoal.saveInBackground()
        delegate!.addNewGoal(newGoal)
        self.dismissViewControllerAnimated(true, completion: nil)
       // newGoal.totalTime = time
    }
    
    func closeSuggestion(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
