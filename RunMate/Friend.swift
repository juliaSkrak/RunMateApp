//
//  Friend.swift
//  RunMate
//
//  Created by Julia Skrak on 3/30/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit
import Parse


class Friend: PFObject, PFSubclassing {
   // @NSManaged var Friended: String!
    var test: String!
    var sentBy: PFUser!
    var sentTo: PFUser!
    
    var accepted: Bool!
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    
    static func parseClassName() -> String {
        return "Friend"
    }
    
}
