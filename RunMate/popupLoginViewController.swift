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
   /*     let screenRect = UIScreen.mainScreen().bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        if(popView.frame.size == CGSize(width: 0, height: 0)){
            popView = popupView.init(frame:  CGRect(x: 30, y: 30, width: screenWidth-60, height: screenHeight-60))

            self.view.addSubview(popView)
            //popView.test()
            print(self.view.subviews)
        } */
        
    }
    
    func testMethodA(testString: NSString){
        if let currentUser = PFUser.currentUser() {
            var newUser = currentUser
            newUser.setObject((Int(popView.wightTextField.text!)!), forKey: "weight")//["goalWeight"] = 134  //setObject(Int(popView.wightTextField.text!)!, forKey: "weight")
            newUser.setObject((Int(popView.goalWeightTextField.text!)!), forKey: "goalWeight")
            var heightInches = Int(popView.feetTextField.text!)! * Int(popView.inchTextField.text!)!
            newUser.setObject(heightInches, forKey: "height")
            print("my new user is:::: \(newUser)")
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
                            user["milePerHourTime"] = "0:00"
                            user["runNum"] = 0
                            if let val =  result["email"] {
                                if(val != nil){
                                    user["email"] = val
                                }
                            }
                            user.saveInBackground()
                        }
                    })

                    
                    
                    print("User signed up and logged in through Facebook!")
                   // let popupLogin:popupLoginViewController = popupLoginViewController()
                    //self.presentViewController(popupLogin, animated: true, completion: nil)
                    //var myView = self.view.subviews[0] as! popupView
                    //print(myView)
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
