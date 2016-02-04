//
//  ViewController.swift
//  RunMate
//
//  Created by Julia Skrak on 1/19/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import ParseFacebookUtilsV4
import FBSDKLoginKit
//import FB

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //var username = username from UI or key store
        if let currentUser = PFUser.currentUser() {
            print("current user is \(currentUser.username)")
            
            print("facebook user is \(FBSDKAccessToken.currentAccessToken())")
            //let username = currentUser.username
            print(currentUser)
            FBSDKGraphRequest.init(graphPath: "me", parameters:["fields": "email, friends, birthday"]).startWithCompletionHandler {
                (connection:FBSDKGraphRequestConnection!,  result:AnyObject!, error:NSError!) -> Void in
                print(result)
                var resultdict = result as? NSDictionary
                print(resultdict)
                var friends = resultdict?.valueForKey("friends") as? NSDictionary
                print(friends)
                var data = friends?.valueForKey("data") as? NSArray
                
                print(data)
                for friend in data! {
                    
                    var query = PFQuery(className:"User")
                    query.whereKey("facebookIdPublic", equalTo: 10153440960432831)

                    query.findObjectsInBackgroundWithBlock {
                        (objects: [PFObject]?, error: NSError?) -> Void in
                        
                        if error == nil {
                            // The find succeeded.
                            // Do something with the found objects
                            print("printing my names \(objects)")
                            if let objects = objects {
                                for object in objects {
                                    print(object.objectId)
                                }
                            }
                        } else {
                            // Log details of the failure
                            print("Error: \(error!) \(error!.userInfo)")
                        }
                    }
                }
            }
            
        } else {
            let btn = UIButton(type: UIButtonType.System) as UIButton
            btn.frame = CGRectMake(100, 100, 200, 100)
            btn.center = self.view.center
            
            btn.setTitle("hello world", forState: UIControlState.Normal)
            btn.addTarget(self, action: "eatMe:", forControlEvents: UIControlEvents.TouchUpInside)
            //btn.hidden = true
            self.view.addSubview(btn)
        }
    }
    
    
    
    override func viewDidAppear(animated: Bool) {

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    let permissions = ["email","user_birthday", "public_profile", "user_friends", "user_birthday"]
    
    func eatMe(sender: AnyObject) {
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                if user.isNew {
                    print("User signed up and logged in through Facebook!")
                    let popupLogin:popupLoginViewController = popupLoginViewController()
                    self.presentViewController(popupLogin, animated: true, completion: nil)
                    
                    
                    
                } else {
                    print("User logged in through Facebook! \(user)")

                    
                    
                    
                }
            } else {
                print("Uh oh. The user cancelled the Facebook login.")
            }
        }
    }
    
    
}

