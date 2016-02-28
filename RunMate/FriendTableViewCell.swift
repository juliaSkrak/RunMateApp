//
//  FriendTableViewCell.swift
//  RunMate
//
//  Created by Julia Skrak on 2/27/16.
//  Copyright © 2016 skrakattack. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   /* override init(frame: CGRect) {
      super.init(frame: frame)
        self.backgroundColor = UIColor.redColor()
        //print("gottttum")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } */
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         self.backgroundColor = UIColor.redColor()
        self.opaque =  true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
