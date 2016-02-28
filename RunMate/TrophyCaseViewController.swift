//
//  TrophyCaseViewController.swift
//  RunMate
//
//  Created by Julia Skrak on 2/9/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

class TrophyCaseViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var trophyCaseCollectionView: UICollectionView
    var trophyArray: [TrophyInformation]
    
    required init(coder aDecoder: NSCoder) {
        trophyCaseCollectionView = UICollectionView()
        trophyArray = [TrophyInformation]()
        super.init(coder: aDecoder)!
         self.view.backgroundColor = UIColor.brownColor()
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        //UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //[flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        trophyArray = [TrophyInformation]()
        var flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        trophyCaseCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
      
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
       // trophyCaseCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 200), collectionViewLayout: UICollectionViewFlowLayout.init())
        //self.view.addSubview(trophyCaseCollectionView)
       // self.view.backgroundColor = UIColor.grayColor()
        self.trophyCaseCollectionView.backgroundColor = UIColor.greenColor()
       
    }
    
    convenience init(profileViewFrame:CGRect){
        self.init()
     //   trophyCaseCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: 300, height: 300), collectionViewLayout: UICollectionViewFlowLayout.init())
        print(profileViewFrame)
        trophyCaseCollectionView.frame = CGRect(x: 0, y: 0, width: profileViewFrame.size.width, height: profileViewFrame.size.height)//CGRect(x: 0, y: 0, width: 300, height: 300) //need to reposition the profileViewFrame to the center
        //print("in convienience \(viewFrame)")
       // trophyCaseCollectionView.backgroundColor = UIColor.redColor()
        self.trophyCaseCollectionView.layer.borderColor = UIColor.blackColor().CGColor
        self.trophyCaseCollectionView.layer.borderWidth = 3.0
        self.view.addSubview(trophyCaseCollectionView)

     
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let currentUser = PFUser.currentUser() {
            loadTrophies(currentUser)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
/*
       var query:PFQuery = PFUser.query()!
        query.whereKey("userId", equalTo:PFUser.currentUser()!.objectId!)
        //query!.whereKey("weight", equalTo:100)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil && (objects!.count == 1){
                // The find succeeded.
                let runScreen:RunScreenViewController = RunScreenViewController()
                self.presentViewController(runScreen, animated: true, completion: nil)
                
                // Do something with the found objects
                runScreen.runHash = (objects![0].objectForKey("runNum") as? NSNumber)!
                runScreen.runHash = NSNumber(integer: runScreen.runHash.integerValue + 1)
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
       
       if let currentUser = PFUser.currentUser() {
            loadTrophies(currentUser)
        }
        */
        
        
        trophyCaseCollectionView.delegate = self
        trophyCaseCollectionView.dataSource = self
        trophyCaseCollectionView.reloadData()
        //self.view.backgroundColor = UIColor.yellowColor()
        print("loaded??? with frame \(self.view.frame)")

        trophyCaseCollectionView.registerClass(TrophyCollectionViewCell.self, forCellWithReuseIdentifier: "mycell")

    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: 50, height: 50)
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print("cltn")
        return trophyArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("mycell", forIndexPath: indexPath) as! TrophyCollectionViewCell
        cell.backgroundColor = UIColor.blueColor()
        print(indexPath.row)
        cell.trophyImg.frame = cell.bounds
        cell.setImage(trophyArray[indexPath.row])
        cell.setNeedsLayout()
        cell.setNeedsDisplay()
        //var collectionViewcell = UICollectionViewCell.init()
        return cell
    }
    
    func loadTrophies(currentUser: PFUser){
        let query = PFQuery(className: "TrophyInformation")
        query.whereKey("userObjectId", equalTo:currentUser.objectId!)
        query.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil{
                print("trophies found")
                //print(objects)
                self.trophyArray = (objects as? [TrophyInformation])!
                print(self.trophyArray)
                self.trophyCaseCollectionView.reloadData()
            } else {
                print("ERROR: \(error!) \(error!.userInfo)")
            }
        }
    }

}
