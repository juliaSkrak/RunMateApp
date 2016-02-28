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
        print("in test method a ")
        if let currentUser = PFUser.currentUser() {
            currentUser["weight"] = 100
            currentUser["facebookIdPublic"] = FBSDKAccessToken.currentAccessToken().userID
            currentUser.saveInBackground()
           // self.navigationController!.popViewControllerAnimated(true)
            self.dismissViewControllerAnimated(true, completion: nil)
            }
    /*    } else {
            print("error, no user is available")
        } */
        //print(testString)
    }
    
    func testMethodB(testString: NSString, testInt:NSNumber){
        print("in test method b ")
        print(testString)
        print("with a number ")
        print(testInt)
        
        let permissions = ["email","user_birthday", "public_profile", "user_friends", "user_birthday", ]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                if user.isNew {
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

    
    
}
