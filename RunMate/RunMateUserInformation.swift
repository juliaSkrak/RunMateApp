//
//  RunMateUserInformation.swift
//  RunMate
//
//  Created by Julia Skrak on 2/8/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit
import Parse
import CoreLocation

class RunMateUserInformation: PFObject, PFSubclassing {
    
    @NSManaged var userObjId: String! //we could possibly just save user
    @NSManaged var facebookUserId: String!

    
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "RunMateUserInformation"
    }

}

