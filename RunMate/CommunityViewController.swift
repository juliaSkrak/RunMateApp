//
//  CommunityViewController.swift
//  RunMate
//
//  Created by Julia Skrak on 2/6/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

class CommunityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var communityTableView : UITableView
    
    
    required init(coder aDecoder: NSCoder!) {
        communityTableView = UITableView.init()
        super.init(coder: aDecoder)!
        communityTableView = UITableView.init(frame:self.view.frame)
        communityTableView.delegate = self
        communityTableView.dataSource = self
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        communityTableView = UITableView.init()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        communityTableView = UITableView.init(frame:self.view.frame)
        communityTableView.delegate = self
        communityTableView.dataSource = self
    }
    
/*
    override init(frame: CGRect) {
      //  CommunityView = CommunityView()
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

*/
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.communityTableView.backgroundColor = UIColor.purpleColor()
        self.view.opaque = true
        communityTableView.delegate = self
        communityTableView.dataSource = self
         communityTableView.reloadData()
        // Do any additional setup after loading the view.
        
        self.communityTableView.registerClass(FriendTableViewCell.self, forCellReuseIdentifier: "communityCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
       // (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
        
        
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(100.0)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.communityTableView.dequeueReusableCellWithIdentifier("communityCell")! as UITableViewCell
        
       // cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }

}
