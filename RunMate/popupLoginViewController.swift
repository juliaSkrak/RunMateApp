//
//  popupLoginViewController.swift
//  RunMate
//
//  Created by Julia Skrak on 1/28/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//


import UIKit
import Parse
import FBSDKCoreKit
import ParseFacebookUtilsV4
import FBSDKLoginKit

class popupLoginViewController: UIViewController, testDelegate {
    
    var popView : popupView
    
    required init(coder aDecoder: NSCoder!) {
        popView = popupView()
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        popView = popupView()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func testMethodA(testString: NSString){
        if let currentUser = PFUser.currentUser() {
            var newUser = currentUser
            let weight: Int = Int(popView.wightTextField.text!) ?? -1
            let goalWeight: Int = Int(popView.goalWeightTextField.text!) ?? -1
            let foot: Int = Int(popView.feetTextField.text!) ?? 0
            let inches: Int = Int(popView.inchTextField.text!) ?? 0
            var height = (foot * 12 + inches == 0) ? -1 : foot * 12 + inches
            let age:Int = Int(self.popView.ageTextField.text!) ?? -1
            newUser.setObject(weight, forKey: "weight")
            newUser.setObject(goalWeight, forKey: "goalWeight")
            newUser.setObject(height, forKey: "height")
            newUser.setObject(String(age), forKey: "age")
            newUser.saveInBackground()
            self.dismissViewControllerAnimated(true, completion: nil)
            }
    }
    
    func testMethodB(testString: NSString, testInt:NSNumber){
        
        let permissions = ["email","user_birthday", "public_profile", "user_friends", "user_birthday", ]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                if user.isNew {
                     let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: FBSDKAccessToken.currentAccessToken().userID, parameters: ["fields":"email , name"])
                    graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                        if ((error) != nil) {
                            print("Error: \(error)")
                        }  else  {
                            user["speed"] = -1
                            user["facebookIdPublic"] = FBSDKAccessToken.currentAccessToken().userID
                            user["name"] = result["name"]
                            user["totalDistance"] = 0
                            user["runNum"] = 0
                            user["age"] = String(-1)
                            user["weight"] = -1
                            user["goalWeight"] = -1
                            user["goalWeeks"] = -1
                            user["height"]  = -1
                            user["mph"] = 0
                            if let val =  result["email"] {
                                if(val != nil){
                                    user["email"] = val
                                } else {
                                    user["email"] = ""
                                }
                            }
                            user.saveInBackground()
                            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                            print(appDelegate)
                            appDelegate.saveInstalation()
                            //UIApplication.sharedApplication().saveInstalation()
                        }
                    })

                    
                    
                    print("User signed up and logged in through Facebook!")
      
                    self.popView.setAppearance()
                    
                } else {
                    print("User logged in through Facebook! \(user)")
                    var myView = self.view.subviews[0] as! popupView
                   // print(myView)
                    self.dismissViewControllerAnimated(true, completion: nil)
        
                }

            } else {
                print("Uh oh. The user cancelled the Facebook login.")
                
            }
        }
    }
    
    func rejectButtonTapped(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
