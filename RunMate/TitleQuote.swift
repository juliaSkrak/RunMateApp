//
//  TitleQuote.swift
//  RunMate
//
//  Created by Julia Skrak on 4/5/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

class TitleQuote: PFObject, PFSubclassing {
    @NSManaged var quote: String
    @NSManaged var QuoteNum: NSNumber
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    
    static func parseClassName() -> String {
        return "TitleQuote"
    }
}
