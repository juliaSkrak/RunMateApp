//
//  GoalAdditionViewController.swift
//  RunMate
//
//  Created by Julia Skrak on 2/16/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

class GoalAdditionViewController: UIViewController, GoalAdditonDelegate {
    
    var userGoalAdditionView: GoalAdditionView
    
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
        newGoal.totalTime = time
        print(newGoal)
       // newGoal.totalTime = time
    }
    
    func closeSuggestion(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
