//
//  TrophyCaseViewController.swift
//  RunMate
//
//  Created by Julia Skrak on 2/9/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

protocol TrophyCaseViewControllerDelegate {
    // func testMethodA(testString: NSString)
    func openWindow(trophInfo: TrophyInformation) -> String
}

class TrophyCaseViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var delegate: TrophyCaseViewControllerDelegate?
    var trophyCaseCollectionView: UICollectionView
    var trophyArray: [TrophyInformation]
    var userObjectId: String
    

    
    required init(coder aDecoder: NSCoder) {
        trophyCaseCollectionView = UICollectionView()
        trophyArray = [TrophyInformation]()
        userObjectId = ""
       // delegate = TrophyCaseViewControllerDelegate()
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        //UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //[flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        userObjectId = ""
        trophyArray = [TrophyInformation]()
        var flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        trophyCaseCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
      
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
       // trophyCaseCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: 100, height: 200), collectionViewLayout: UICollectionViewFlowLayout.init())
        //self.view.addSubview(trophyCaseCollectionView)
       // self.view.backgroundColor = UIColor.grayColor()
        self.trophyCaseCollectionView.backgroundColor = UIColor.whiteColor()
       
    }
    
    convenience init(profileViewFrame:CGRect, userId: String){
        self.init()
        userObjectId = userId
     //   trophyCaseCollectionView = UICollectionView.init(frame: CGRect(x: 0, y: 0, width: 300, height: 300), collectionViewLayout: UICollectionViewFlowLayout.init())
        print(profileViewFrame)
        trophyCaseCollectionView.frame = CGRect(x: 0, y: 0, width: profileViewFrame.size.width, height: profileViewFrame.size.height)//CGRect(x: 0, y: 0, width: 300, height: 300) //need to reposition the profileViewFrame to the center
        //print("in convienience \(viewFrame)")
       // trophyCaseCollectionView.backgroundColor = UIColor.redColor()
        self.trophyCaseCollectionView.layer.borderColor = UIColor.whiteColor().CGColor
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
            delegate?.openWindow(trophyArray[indexPath.row])
       // }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("cltn \(trophyArray.count)")
        
        return trophyArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("mycell", forIndexPath: indexPath) as! TrophyCollectionViewCell
       
        print(indexPath.row)
        cell.trophyImg.frame = cell.bounds
        cell.setImage(trophyArray[indexPath.row])
        cell.setNeedsLayout()
        cell.setNeedsDisplay()
        //var collectionViewcell = UICollectionViewCell.init()
        return cell
    }
    
    func loadTrophies(currentUser: PFUser){
        let objectId = (userObjectId == "") ? currentUser.objectId! : userObjectId
        let query = PFQuery(className: "TrophyInformation")
        query.whereKey("userObjectID", equalTo:objectId)
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
