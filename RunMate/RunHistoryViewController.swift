//
//  RunHistoryViewController.swift
//  RunMate
//
//  Created by Julia Skrak on 3/7/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

class RunHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView:UITableView
    
    required init(coder aDecoder: NSCoder) {
        tableView = UITableView.init()
        super.init(coder: aDecoder)!
        self.setUpTableView()
    }

    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        tableView = UITableView.init()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.setUpTableView()

    }
    
    func setUpTableView(){
        self.tableView.registerClass(GenericTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "headerView")
        tableView = UITableView.init(frame: self.view.frame)
        self.view.backgroundColor = UIColor.purpleColor()
        self.view.addSubview(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData() 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(60.0)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // let arraycount = self.friendArray as Array
        var cell = UITableViewCell.init()
        cell.backgroundColor = UIColor.redColor()
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = self.tableView.dequeueReusableHeaderFooterViewWithIdentifier("headerView") as! GenericTableViewHeaderFooterView
        header.setNeedsLayout()
        return header
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
