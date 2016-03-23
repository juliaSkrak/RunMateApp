//
//  Run.swift
//  RunMate
//
//  Created by Julia Skrak on 3/23/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit
import Parse
import CoreLocation

class Run: PFObject, PFSubclassing {
    @NSManaged var runlocations: [String]!
    @NSManaged var user: String! //we could possibly just save user
    @NSManaged var userId: String!
    @NSManaged var runDate: String!
    @NSManaged var geopoints: NSNumber!
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
        return "Run"
    }
    

}




