//
//  RunLocation.swift
//  RunMate
//
//  Created by Julia Skrak on 2/5/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit
import Parse
import CoreLocation

class RunLocation: PFObject, PFSubclassing {

    
    @NSManaged var speed: NSNumber!
    @NSManaged var userObjId: String! //we could possibly just save user
    @NSManaged var runHash: NSNumber!
    @NSManaged var longitude: NSNumber!
    @NSManaged var latitude: NSNumber!
    @NSManaged var altitude:NSNumber!
    @NSManaged var timestamp: NSNumber!
    @NSManaged var facebookUserId: String!
    @NSManaged var distance: NSNumber!
    
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "RunLocation"
    }

    
}
