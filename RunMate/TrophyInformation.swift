//
//  TrophyInformation.swift
//  RunMate
//
//  Created by Julia Skrak on 2/11/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

class TrophyInformation: PFObject, PFSubclassing {
    @NSManaged var userObjectID: String!
    @NSManaged var completed: NSNumber!//should be 0 if false and 1 if true we can access with as Bool
    @NSManaged var runNum: NSNumber! //number it was completed at, -1 if not completed yet
    //@NSManaged var timestamp: NSNumber!
    @NSManaged var definitionOfTrophy: String!
    @NSManaged var distance: NSNumber! // lets just do in miles??
    @NSManaged var minutes: NSNumber! //would be nice to do this in number of minutes it took to do this run
    @NSManaged var imageName: String!
   
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "TrophyInformation"
    }

}
