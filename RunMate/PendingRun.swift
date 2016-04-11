//
//  PendingRun.swift
//  RunMate
//
//  Created by Julia Skrak on 4/9/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

class PendingRun: PFObject, PFSubclassing {
    var sentBy: PFUser!
    var sentTo: PFUser!
    var beginRunTime: String!
    var accepted: NSNumber!
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    
    static func parseClassName() -> String {
        return "PendingRun"
    }
}
