//
//  AppDelegate.swift
//  RunMate
//
//  Created by Julia Skrak on 1/19/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit
import CoreData
import Parse
import Bolts
import FBSDKCoreKit
import ParseFacebookUtilsV4


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appDeviceToken: NSData?
    var runCountDownView: CountDownView?
    var countdownTimer : NSTimer?
    var sentBy: PFUser? //forgive me father for i have sinned


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("dX9JzxUVmJXzIqKh3keU7GCHTRwzqqp3dmI9TuRu",
            clientKey: "IvXSKVzB08BiTTeZA9VV0q7iRsGlgBY8ojbTlAh3")
        
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        // Override point for customization after application launch.
        
     
      FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
          PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        Friend.registerSubclass() //this is a parse bug fix.  you touch this, you die.
        
        var testImage = UIImage.init(named: "running_man")
        testImage = testImage?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        var homeViewTabBarItem  = UITabBarItem(title: "Run", image: testImage, selectedImage: testImage)
        

        var testImage2 = UIImage.init(named: "profile_pic")
        var profileViewTabBarItem = UITabBarItem.init(title: "Profile", image: testImage2, tag: 0)
        testImage2 = testImage2?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        
        var testImage3 = UIImage.init(named: "friends")
        var communityViewTabBarItem = UITabBarItem.init(title: "Community", image: testImage3, tag: 0)
        testImage3 = testImage3?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        var tabBarController = UITabBarController.init()
        
        var homeViewController = ViewController.init()
        homeViewController.tabBarItem = homeViewTabBarItem
        
        var profileViewController = ProfileViewController.init(userObj: nil, isCurrentUser: true)
        //profileViewController.tabBarItem = profileViewTabBarItem
        
        var profileNavigationController = UINavigationController(rootViewController: profileViewController)
        profileNavigationController.tabBarItem = profileViewTabBarItem
        
        
        var communityViewController = CommunityViewController.init()
        var communityNavigationController = UINavigationController(rootViewController: communityViewController)
        communityNavigationController.tabBarItem = communityViewTabBarItem
        
        //var community = ProfileViewController.init()
        profileViewController.tabBarItem = profileViewTabBarItem
        

       // MyOtherViewController* vc2 = [[MyOtherViewController alloc] init];
        
        var controllers = [homeViewController, profileNavigationController, communityNavigationController] as NSArray
        tabBarController.viewControllers = controllers as! [UIViewController]
        
        window!.rootViewController = tabBarController
        

       // var homeViewTabBarItem = UITabBarItem.init
        
        //UIImage* anImage = [UIImage imageNamed:@"MyViewControllerImage.png"];
//        UITabBarItem* theItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:anImage tag:0];

        if(UIApplication.instancesRespondToSelector(Selector("registerUserNotificationSettings:"))) {
            UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
        }
        
        return true
    }
    
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject?) -> Bool {
            return FBSDKApplicationDelegate.sharedInstance().application(
                application,
                openURL: url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    } 
    
   
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "jskrak.RunMate" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("RunMate", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData!) {
        appDeviceToken = deviceToken
        self.saveInstalation()
    }
    
    func saveInstalation(){
        if let currentUser = PFUser.currentUser() {
            var currentInstallation = PFInstallation.currentInstallation()
            currentInstallation.setDeviceTokenFromData(appDeviceToken!)
       
            currentInstallation["user"] = currentUser
       
            currentInstallation.saveInBackground()
        }
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError!) {
        if (error.code == 3010) {
            print("push notificiations are NOT supported on simulatorrrr")
        }else{
            
            print("error!!  the code is \(error)")
        }
    }

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print("dictionary is \(userInfo.description)")
        if let userInfoDictionary : [String: AnyObject] = userInfo as! [String: AnyObject] {
            
            print(userInfoDictionary)
            PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
            if(application.applicationState != UIApplicationState.Active){
                PFPush.handlePush(userInfo)
            }
            let alert = UIAlertController(title: "Run Request", message: "your friend \(userInfoDictionary["name"]!) wants to for run!!!", preferredStyle: UIAlertControllerStyle.Alert)
            let cancelAction = UIAlertAction(title: "deny request", style: .Cancel) { (action) in
                let userQuery = PFUser.query()
                userQuery?.whereKey("objectId", equalTo: userInfoDictionary["objectId"]!)
                
                let query = PFQuery(className: "PendingRun")
                query.whereKey("sentBy", matchesQuery: userQuery!)
                query.includeKey("sentBy")
                
                query.findObjectsInBackgroundWithBlock {
                    (objects: [PFObject]?, error: NSError?) -> Void in
                    if error == nil{
                        if let pendingRun = objects?.first {
                            pendingRun["accepted"] = 2
                            pendingRun.saveInBackground()
                        }
                        
                    }
                }
                
                alert.dismissViewControllerAnimated(false, completion: nil)
            }
            
            alert.addAction(cancelAction)
        
            let OKAction = UIAlertAction(title: "OK GO!", style: .Default) { (action) in
                let userQuery = PFUser.query()
                userQuery?.whereKey("objectId", equalTo: userInfoDictionary["objectId"]!)
                
                let query = PFQuery(className: "PendingRun")
                query.whereKey("sentBy", matchesQuery: userQuery!)
                query.includeKey("sentBy")
                
                query.findObjectsInBackgroundWithBlock {
                    (objects: [PFObject]?, error: NSError?) -> Void in
                    if error == nil{
                        if let pendingRun = objects?.first {
                            print("\(pendingRun)")
                            var date = NSDate().timeIntervalSince1970
                            date = date + 30
                            pendingRun["beginRunTime"] = date
                            pendingRun["accepted"] = 1
                            pendingRun["test"] = "blah blah blah"
                            print(pendingRun)
                            pendingRun.saveInBackground()
                            self.runCountDownView = CountDownView(frame: self.window!.rootViewController!.view.frame)
                            self.runCountDownView!.timerLabel.text = "30"
                            self.countdownTimer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: "updateRunCountDown", userInfo: nil, repeats: true)
                            self.sentBy = pendingRun["sentBy"] as! PFUser
                            self.window!.rootViewController!.view.addSubview(self.runCountDownView!)
                        
                        }
                        
                    }
                }
                alert.dismissViewControllerAnimated(false, completion: nil)

                
            }
            alert.addAction(OKAction)
            window!.rootViewController!.presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
    func updateRunCountDown(){
        
        var seconds = Int(self.runCountDownView!.timerLabel.text!)! - 1
        if(seconds == 0){
            countdownTimer?.invalidate()
            self.runCountDownView!.removeFromSuperview()
            var runScreenViewController = RunScreenViewController.init(friendObj: self.sentBy!)
            window!.rootViewController!.presentViewController(runScreenViewController, animated: true, completion: nil)
        } else {
            self.runCountDownView!.timerLabel.text = String(seconds)
        }
    }
}

