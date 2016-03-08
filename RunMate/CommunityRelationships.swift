//
//  CommunityRelationships.swift
//  RunMate
//
//  Created by Julia Skrak on 3/6/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

class CommunityRelationships: PFObject, PFSubclassing {

    
    @NSManaged var Friended: String!
    @NSManaged var Friender: String!
    @NSManaged var FrienderFacebookID: String!
    @NSManaged var FriendedFacebookID: String!
    @NSManaged var accepted: NSNumber!


    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "CommunityRelationships"
    }
    

}
