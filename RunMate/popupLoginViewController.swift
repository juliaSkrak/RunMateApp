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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let screenRect = UIScreen.mainScreen().bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        
        let popView : popupView = popupView.init(frame:  CGRect(x: 30, y: 30, width: screenWidth-60, height: screenHeight-60))
        popView.opaque = false
        popView.layer.cornerRadius = 15;
        self.view.backgroundColor = UIColor.whiteColor()
        //popView.alpha = 0.5
        popView.delegate = self
        self.view.addSubview(popView)
        //popView.test()
        print("hahi")
    }
    
    func testMethodA(testString: NSString){
        print("in test method a ")
        if let currentUser = PFUser.currentUser() {
       /*     var query = PFQuery(className:"User")
            query.getObjectInBackgroundWithId(currentUser.objectId!){
                (user: PFObject?, error: NSError?) -> Void in
                if error != nil {
                    print(error)
                } else if let user = user {
                    
                } */
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
    }

    
    
}
