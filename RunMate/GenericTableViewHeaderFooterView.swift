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
    
    
    override init(reuseIdentifier: String?) {
        titleLabel = UILabel.init()
        titleLabel.font = titleLabel.font.fontWithSize(30)
        titleLabel.textAlignment = .Right
        
        super.init(reuseIdentifier: reuseIdentifier)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(titleLabel)
        self.titleLabel.backgroundColor = UIColor(red: 254/255, green: 122/255, blue: 107/255, alpha: 1)
        self.titleLabel.textColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
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
