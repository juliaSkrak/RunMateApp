//
//  GenericTableViewHeaderFooterView.swift
//  RunMate
//
//  Created by Julia Skrak on 3/9/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

class GenericTableViewHeaderFooterView: UITableViewHeaderFooterView { //gonna use autolayout here b/c size mutates
    var titleLabel: UILabel
    
   /* convenience init(reuseIdentifier: String?, frameSize: CGRect){// so i guess using a convience init to get around having to init a frame twice doesnt work....
       // titleLabel = UILabel.init(frame: frameSize)
        self.init(reuseIdentifier: reuseIdentifier)
    } */
    
    override init(reuseIdentifier: String?) {
        titleLabel = UILabel.init()
        super.init(reuseIdentifier: reuseIdentifier)
        //titleLabel.text = "TESTING PLZ WORK"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(titleLabel)
        self.doLayoutStuff()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func doLayoutStuff(){
        let viewsDictionary = ["titleLabel" : self.titleLabel]
        let viewConstraintHorizontal = NSLayoutConstraint.constraintsWithVisualFormat("H:|[titleLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let viewConstraintVertical = NSLayoutConstraint.constraintsWithVisualFormat("V:|[titleLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        self.contentView.addConstraints(viewConstraintHorizontal)
        self.contentView.addConstraints(viewConstraintVertical)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
